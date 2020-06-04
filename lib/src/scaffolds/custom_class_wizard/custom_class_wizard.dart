import 'package:dungeon_paper/src/dialogs/dialogs.dart';
import 'package:dungeon_paper/src/lists/custom_class_moves_list.dart';
import 'package:dungeon_paper/src/molecules/custom_class_basic_details.dart';
import 'package:dungeon_paper/src/molecules/custom_class_looks.dart';
import 'package:dungeon_paper/src/scaffolds/scaffold_with_elevation.dart';
import 'package:dungeon_paper/src/utils/utils.dart';
import 'package:dungeon_world_data/dice.dart';
import 'package:dungeon_world_data/player_class.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class CustomClassWizard extends StatefulWidget {
  final DialogMode mode;

  const CustomClassWizard({
    Key key,
    @required this.mode,
  }) : super(key: key);

  @override
  _CustomClassWizardState createState() => _CustomClassWizardState();
}

enum CustomClassWizardTab { BasicInfo, Moves, Looks, Alignments }

class _CustomClassWizardState extends State<CustomClassWizard>
    with SingleTickerProviderStateMixin {
  PlayerClass def;
  TabController tabController;
  ValueNotifier<bool> basicInfoValid;
  ValueNotifier<bool> movesValid;
  ValueNotifier<bool> looksValid;
  ValueNotifier<bool> alignmentsValid;

  static const Map<CustomClassWizardTab, String> TAB_TITLES = {
    CustomClassWizardTab.BasicInfo: 'General',
    CustomClassWizardTab.Moves: 'Moves',
    CustomClassWizardTab.Looks: 'Look Choices',
    CustomClassWizardTab.Alignments: 'Alignments',
  };

  @override
  void initState() {
    basicInfoValid = ValueNotifier(false);
    movesValid = ValueNotifier(true);
    looksValid = ValueNotifier(false);
    alignmentsValid = ValueNotifier(true);

    def = PlayerClass(
      key: Uuid().v4(),
      name: '',
      description: '',
      baseHP: 0,
      load: 0,
      damage: Dice.d6,
      looks: [
        ['']
      ],
      startingMoves: [],
      advancedMoves1: [],
      advancedMoves2: [],
      alignments: {},
      // TBD
      names: {},
      bonds: [],
      gearChoices: [],
      raceMoves: [],
      spells: [],
    );
    tabController = TabController(length: _tabs.keys.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithElevation(
      title: Text(def.name.isEmpty
          ? 'Custom Class'
          : '${enumName(widget.mode).substring(0, 5)}ing: ${def.name}'),
      wrapWithScrollable: false,
      elevateAfterScrolling: false,
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  color: Theme.of(context).canvasColor,
                  child: TabBar(
                    isScrollable: true,
                    controller: tabController,
                    tabs: _tabs.keys.map(_mapTab).toList(),
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
                    color: Theme.of(context).errorColor,
                  ),
                ),
            ],
          ),
        ),
      );

  Map<CustomClassWizardTab, Widget> get _tabs => {
        CustomClassWizardTab.BasicInfo: ClassBasicDetails(
          mode: widget.mode,
          playerClass: def,
          validityNotifier: basicInfoValid,
          onUpdate: (cls) => setState(() {
            def = cls;
          }),
        ),
        CustomClassWizardTab.Moves: CustomClassMoveList(
          mode: widget.mode,
          playerClass: def,
          validityNotifier: movesValid,
          onUpdate: (cls) => setState(() {
            def = cls;
          }),
        ),
        CustomClassWizardTab.Looks: CustomClassLooks(
          mode: widget.mode,
          looks: def.looks,
          validityNotifier: looksValid,
          onUpdate: (looks) => setState(() {
            def.looks = looks;
          }),
        ),
        CustomClassWizardTab.Alignments: CustomClassLooks(
          mode: widget.mode,
          looks: def.looks,
          validityNotifier: looksValid,
          onUpdate: (looks) => setState(() {
            def.looks = looks;
          }),
        ),
      };

  bool _isValid(CustomClassWizardTab k) {
    switch (k) {
      case CustomClassWizardTab.BasicInfo:
        return basicInfoValid.value;
      case CustomClassWizardTab.Moves:
        return movesValid.value;
      case CustomClassWizardTab.Looks:
        return looksValid.value;
      case CustomClassWizardTab.Alignments:
        return alignmentsValid.value;
    }
    return true;
  }
}
