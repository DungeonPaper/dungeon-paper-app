import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_paper/src/dialogs/change_alignment_dialog.dart';
import 'package:dungeon_paper/src/dialogs/confirmation_dialog.dart';
import 'package:dungeon_paper/src/dialogs/dialogs.dart';
import 'package:dungeon_paper/src/redux/stores.dart';
import 'package:dungeon_paper/src/scaffolds/class_select_scaffold.dart';
import 'package:dungeon_paper/src/scaffolds/main_scaffold.dart';
import 'package:dungeon_paper/src/utils/analytics.dart';
import 'package:dungeon_paper/src/utils/logger.dart';
import 'package:dungeon_paper/src/utils/utils.dart';
import 'package:get/get.dart';
import 'package:pedantic/pedantic.dart';
import 'edit_basic_info_view.dart';
import 'edit_race.dart';
import 'edit_looks.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'edit_stats.dart';

enum CreateCharacterTab {
  BasicInfo,
  MainClass,
  Alignment,
  Race,
  Looks,
  Stats,
}

class EditCharacterView extends StatefulWidget {
  final DialogMode mode;
  final Character character;
  final void Function(Character) onSave;

  const EditCharacterView({
    Key key,
    @required this.mode,
    @required this.character,
    this.onSave,
  }) : super(key: key);

  @override
  _EditCharacterViewState createState() => _EditCharacterViewState();
}

class _EditCharacterViewState extends State<EditCharacterView>
    with SingleTickerProviderStateMixin {
  Character character;
  TabController tabController;
  ValueNotifier<bool> basicInfoValid;
  ValueNotifier<bool> mainClassValid;
  ValueNotifier<bool> alignmentValid;
  ValueNotifier<bool> raceValid;
  ValueNotifier<bool> looksValid;
  ValueNotifier<bool> statsValid;
  bool dirty;

  static const Map<CreateCharacterTab, String> TAB_TITLES = {
    CreateCharacterTab.BasicInfo: 'General',
    CreateCharacterTab.MainClass: 'Class',
    CreateCharacterTab.Alignment: 'Alignment',
    CreateCharacterTab.Race: 'Race',
    CreateCharacterTab.Looks: 'Looks',
    CreateCharacterTab.Stats: 'Stats',
  };

  @override
  void initState() {
    var user = dwStore.state.user.current;
    character = widget.character != null
        ? Character(
            data: widget.character.toJSON(),
            ref:
                widget.character.ref ?? user.ref.collection('characters').doc(),
          )
        : Character(
            ref: user.ref.collection('characters').doc(),
          );

    basicInfoValid = ValueNotifier(character.displayName.isNotEmpty);
    mainClassValid = ValueNotifier(character.mainClass != null);
    alignmentValid = ValueNotifier(character.alignment != null);
    raceValid = ValueNotifier(character.race != null);
    looksValid = ValueNotifier(true);
    statsValid = ValueNotifier(true);
    dirty = false;

    tabController = TabController(length: _tabs.keys.length, vsync: this);
    logger.d('Page View: ${ScreenNames.CharacterScreen}');
    analytics.setCurrentScreen(screenName: ScreenNames.CharacterScreen);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _confirmExit,
      child: MainScaffold(
        title: Text(character.displayName.isEmpty
            ? 'Character'
            : '${widget.mode == DialogMode.Create ? 'Creat' : 'Edit'}ing: ${character.displayName}'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            tooltip: 'Save',
            onPressed: _isCharValid ? _save : null,
          )
        ],
        wrapWithScrollable: false,
        useElevation: false,
        automaticallyImplyLeading: true,
        elevation: 0,
        body: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
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
      ),
    );
  }

  Tab _mapTab(CreateCharacterTab k) => Tab(
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

  Map<CreateCharacterTab, Widget> get _tabs => {
        CreateCharacterTab.BasicInfo: EditBasicInfoView(
          character: character,
          mode: DialogMode.Create,
          onUpdate: (char) => setState(() {
            dirty = true;
            character = char;
          }),
        ),
        CreateCharacterTab.MainClass: ClassSelectView(
          character: character,
          mode: DialogMode.Create,
          onUpdate: (char) => setState(() {
            dirty = true;
            character = char;
          }),
        ),
        CreateCharacterTab.Alignment: ChangeAlignmentDialog(
          character: character,
          mode: DialogMode.Create,
          onUpdate: (char) => setState(() {
            dirty = true;
            character = char;
          }),
        ),
        CreateCharacterTab.Race: ChangeRaceDialog(
          character: character,
          mode: DialogMode.Create,
          onUpdate: (char) => setState(() {
            dirty = true;
            character = char;
          }),
        ),
        CreateCharacterTab.Looks: ChangeLooksDialog(
          character: character,
          mode: DialogMode.Create,
          onUpdate: (char) => setState(() {
            dirty = true;
            character.looks = char.looks;
          }),
        ),
        CreateCharacterTab.Stats: EditStats(
          character: character,
          onUpdate: (char) => setState(() {
            dirty = true;
            character = char;
          }),
        ),
      };

  bool _isValid(CreateCharacterTab k) {
    switch (k) {
      case CreateCharacterTab.BasicInfo:
        return basicInfoValid.value;
      case CreateCharacterTab.MainClass:
        return mainClassValid.value;
      case CreateCharacterTab.Alignment:
        return alignmentValid.value;
      case CreateCharacterTab.Race:
        return raceValid.value;
      case CreateCharacterTab.Looks:
        return looksValid.value;
      case CreateCharacterTab.Stats:
        return statsValid.value;
    }
    return true;
  }

  bool get _isCharValid => [
        basicInfoValid,
        mainClassValid,
        alignmentValid,
        raceValid,
        looksValid,
        statsValid,
      ].every((validator) => validator.value == true);

  void _save() async {
    unawaited(analytics.logEvent(
      name: Events.SaveCharacter,
      parameters: {
        'mode': enumName(widget.mode).toLowerCase(),
      },
    ));
    if (widget.mode == DialogMode.Create) {
      await character.create();
    } else {
      await character.update();
    }
    widget.onSave?.call(character);
    Get.back();
  }

  Future<bool> _confirmExit() async {
    var verb = widget.mode == DialogMode.Edit ? 'edit' : 'creation';
    if (!dirty) {
      return true;
    }
    if (await showDialog(
          context: context,
          builder: (ctx) => ConfirmationDialog(
              text: Text(
                  'Are you sure you want to quit character $verb?\nYour changes will not be saved.')),
        ) ==
        true) {
      Get.back(result: true);
      return true;
    }
    return false;
  }
}

class GenericAppBarActionButton extends StatelessWidget {
  final Widget child;
  final Function() onPressed;

  const GenericAppBarActionButton({
    Key key,
    @required this.child,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0).copyWith(left: 4.0),
      child: RaisedButton(
        child: child,
        color: Get.theme.canvasColor,
        onPressed: onPressed,
      ),
    );
  }
}
