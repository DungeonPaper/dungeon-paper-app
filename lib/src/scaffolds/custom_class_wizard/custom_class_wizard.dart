import 'package:dungeon_paper/db/models/custom_class.dart';
import 'package:dungeon_paper/src/dialogs/dialogs.dart';
import 'package:dungeon_paper/src/lists/custom_class_moves_list.dart';
import 'package:dungeon_paper/src/molecules/custom_class_alignments.dart';
import 'package:dungeon_paper/src/molecules/custom_class_basic_details.dart';
import 'package:dungeon_paper/src/molecules/custom_class_looks.dart';
import 'package:dungeon_paper/src/redux/stores.dart';
import 'package:dungeon_paper/src/scaffolds/scaffold_with_elevation.dart';
import 'package:flutter/material.dart';

class CustomClassWizard extends StatefulWidget {
  final DialogMode mode;
  final CustomClass customClass;
  final void Function(CustomClass) onSave;

  const CustomClassWizard({
    Key key,
    @required this.mode,
    this.customClass,
    this.onSave,
  })  : assert(mode == DialogMode.Create || customClass != null),
        super(key: key);

  @override
  _CustomClassWizardState createState() => _CustomClassWizardState();
}

enum CustomClassWizardTab { BasicInfo, Moves, Races, Looks, Alignments }

class _CustomClassWizardState extends State<CustomClassWizard>
    with SingleTickerProviderStateMixin {
  CustomClass def;
  TabController tabController;
  ValueNotifier<bool> basicInfoValid;
  ValueNotifier<bool> movesValid;
  ValueNotifier<bool> racesValid;
  ValueNotifier<bool> looksValid;
  ValueNotifier<bool> alignmentsValid;

  static const Map<CustomClassWizardTab, String> TAB_TITLES = {
    CustomClassWizardTab.BasicInfo: 'General',
    CustomClassWizardTab.Moves: 'Moves',
    CustomClassWizardTab.Races: 'Races',
    CustomClassWizardTab.Looks: 'Look Choices',
    CustomClassWizardTab.Alignments: 'Alignments',
  };

  @override
  void initState() {
    var user = dwStore.state.user.current;
    def = widget.customClass != null
        ? CustomClass(
            data: widget.customClass.toJSON(),
            ref: widget.customClass.ref ??
                user.ref.collection('custom_classes').document(),
          )
        : CustomClass(
            ref: user.ref.collection('custom_classes').document(),
          );

    basicInfoValid = ValueNotifier(def.name.isNotEmpty);
    racesValid = ValueNotifier(def.raceMoves.isNotEmpty);
    movesValid = ValueNotifier(true);
    looksValid = ValueNotifier(true);
    alignmentsValid = ValueNotifier(true);

    tabController = TabController(length: _tabs.keys.length, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithElevation.primaryBackground(
      title: Text(def.name.isEmpty
          ? 'Custom Class'
          : '${widget.mode == DialogMode.Create ? 'Creat' : 'Edit'}ing: ${def.name}'),
      actions: [
        IconButton(
          icon: Icon(Icons.save),
          tooltip: 'Save',
          onPressed: _isClsValid ? _save : null,
        )
      ],
      wrapWithScrollable: false,
      useElevation: false,
      elevation: 0,
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: Theme.of(context).primaryColor,
                    child: TabBar(
                      isScrollable: true,
                      controller: tabController,
                      tabs: _tabs.keys.map(_mapTab).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: _tabs.values.toList(),
            ),
          ),
        ],
      ),
    );
  }

  Tab _mapTab(CustomClassWizardTab k) => Tab(
        child: Container(
          constraints: BoxConstraints(maxWidth: 150),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(TAB_TITLES[k]),
              if (!_isValid(k))
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Icon(
                    Icons.error,
                    color: Colors.orange[300],
                  ),
                ),
            ],
          ),
        ),
      );

  Map<CustomClassWizardTab, Widget> get _tabs => {
        CustomClassWizardTab.BasicInfo: ClassBasicDetails(
          mode: widget.mode,
          customClass: def,
          validityNotifier: basicInfoValid,
          onUpdate: (cls) => setState(() {
            def = cls;
          }),
        ),
        CustomClassWizardTab.Races: CustomClassMoveList(
          mode: widget.mode,
          customClass: def,
          validityNotifier: racesValid,
          raceMoveMode: true,
          onUpdate: (cls) => setState(() {
            def = cls;
          }),
        ),
        CustomClassWizardTab.Moves: CustomClassMoveList(
          mode: widget.mode,
          customClass: def,
          validityNotifier: movesValid,
          raceMoveMode: false,
          onUpdate: (cls) => setState(() {
            def = cls;
          }),
        ),
        CustomClassWizardTab.Looks: CustomClassLooks(
          mode: widget.mode,
          looks: def.looks,
          validityNotifier: looksValid,
          onUpdate: (looks) => setState(() {
            def.looks = Map<String, List<String>>.from(
              looks.asMap().map(
                    (k, v) => MapEntry(k.toString(), v),
                  ),
            );
          }),
        ),
        CustomClassWizardTab.Alignments: CustomClassAlignments(
          mode: widget.mode,
          alignments: def.alignments,
          onUpdate: (alignments) => setState(() {
            def.alignments = alignments;
          }),
        ),
      };

  bool _isValid(CustomClassWizardTab k) {
    switch (k) {
      case CustomClassWizardTab.BasicInfo:
        return basicInfoValid.value;
      case CustomClassWizardTab.Moves:
        return movesValid.value;
      case CustomClassWizardTab.Races:
        return racesValid.value;
      case CustomClassWizardTab.Looks:
        return looksValid.value;
      case CustomClassWizardTab.Alignments:
        return alignmentsValid.value;
    }
    return true;
  }

  bool get _isClsValid => [
        basicInfoValid,
        racesValid,
        movesValid,
        looksValid,
        alignmentsValid,
      ].every((validator) => validator.value == true);

  void _save() async {
    if (widget.mode == DialogMode.Create) {
      await def.create();
    } else {
      await def.update();
      widget.onSave?.call(def);
    }
    Navigator.pop(context);
  }
}
