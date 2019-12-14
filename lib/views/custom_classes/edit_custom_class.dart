import 'package:dungeon_paper/components/dialogs.dart';
import 'package:dungeon_paper/components/scaffold_with_elevation.dart';
import 'package:dungeon_paper/views/custom_classes/custom_class_basic_details.dart';
import 'package:dungeon_paper/views/custom_classes/custom_class_looks.dart';
import 'package:dungeon_paper/views/custom_classes/custom_class_moves_list.dart';
import 'package:dungeon_world_data/dice.dart';
import 'package:dungeon_world_data/player_class.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../utils.dart';

class EditCustomClass extends StatefulWidget {
  final DialogMode mode;

  const EditCustomClass({
    Key key,
    @required this.mode,
  }) : super(key: key);

  @override
  _EditCustomClassState createState() => _EditCustomClassState();
}

enum EditCustomClassTab { BasicInfo, Moves, Looks, Alignments }

class _EditCustomClassState extends State<EditCustomClass>
    with SingleTickerProviderStateMixin {
  PlayerClass def;
  TabController tabController;
  ValueNotifier<bool> basicInfoValid;
  ValueNotifier<bool> movesValid;
  ValueNotifier<bool> looksValid;
  ValueNotifier<bool> alignmentsValid;

  static const Map<EditCustomClassTab, String> TAB_TITLES = {
    EditCustomClassTab.BasicInfo: 'General',
    EditCustomClassTab.Moves: 'Moves',
    EditCustomClassTab.Looks: 'Look Choices',
    EditCustomClassTab.Alignments: 'Alignments',
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
      spells: {},
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
      child: Column(
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

  Tab _mapTab(EditCustomClassTab k) => Tab(
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

  Map<EditCustomClassTab, Widget> get _tabs => {
        EditCustomClassTab.BasicInfo: ClassBasicDetails(
          mode: widget.mode,
          playerClass: def,
          validityNotifier: basicInfoValid,
          onUpdate: (cls) => setState(() {
            def = cls;
          }),
        ),
        EditCustomClassTab.Moves: CustomClassMoveList(
          mode: widget.mode,
          playerClass: def,
          validityNotifier: movesValid,
          onUpdate: (cls) => setState(() {
            def = cls;
          }),
        ),
        EditCustomClassTab.Looks: CustomClassLooks(
          mode: widget.mode,
          looks: def.looks,
          validityNotifier: looksValid,
          onUpdate: (looks) => setState(() {
            def.looks = looks;
          }),
        ),
        EditCustomClassTab.Alignments: CustomClassLooks(
          mode: widget.mode,
          looks: def.looks,
          validityNotifier: looksValid,
          onUpdate: (looks) => setState(() {
            def.looks = looks;
          }),
        ),
      };

  bool _isValid(EditCustomClassTab k) {
    switch (k) {
      case EditCustomClassTab.BasicInfo:
        return basicInfoValid.value;
      case EditCustomClassTab.Moves:
        return movesValid.value;
      case EditCustomClassTab.Looks:
        return looksValid.value;
      case EditCustomClassTab.Alignments:
        return alignmentsValid.value;
    }
    return true;
  }
}
