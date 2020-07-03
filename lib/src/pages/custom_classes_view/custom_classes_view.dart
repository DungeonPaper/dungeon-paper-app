import 'package:dungeon_paper/db/models/custom_class.dart';
import 'package:dungeon_paper/src/dialogs/confirmation_dialog.dart';
import 'package:dungeon_paper/src/dialogs/dialogs.dart';
import 'package:dungeon_paper/src/lists/custom_classes_list.dart';
import 'package:dungeon_paper/src/lists/player_class_list.dart';
import 'package:dungeon_paper/src/redux/stores.dart';
import 'package:dungeon_paper/src/scaffolds/custom_class_wizard/custom_class_wizard.dart';
import 'package:dungeon_paper/src/scaffolds/scaffold_with_elevation.dart';
import 'package:dungeon_paper/src/utils/analytics.dart';
import 'package:dungeon_paper/src/utils/logger.dart';
import 'package:dungeon_world_data/player_class.dart';
import 'package:flutter/material.dart';
import 'package:pedantic/pedantic.dart';

class CustomClassesView extends StatefulWidget {
  @override
  _CustomClassesViewState createState() => _CustomClassesViewState();
}

class _CustomClassesViewState extends State<CustomClassesView> {
  @override
  void initState() {
    super.initState();
    logger.d('Page View: ${ScreenNames.CustomClasses}');
    analytics.setCurrentScreen(screenName: ScreenNames.CustomClasses);
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithElevation.primaryBackground(
      title: Text('Custom Classes'),
      automaticallyImplyLeading: true,
      actions: [
        PlayerClassList(
          builder: (context, list) => PopupMenuButton<PlayerClass>(
            icon: Icon(Icons.content_copy),
            tooltip: 'Copy existing class',
            onSelected: _copyExisting,
            itemBuilder: (context) => [
              PopupMenuItem<PlayerClass>(
                value: null,
                enabled: false,
                child: Text('Copy existing class:'),
              ),
              ...list.map(
                (el) => PopupMenuItem<PlayerClass>(
                  value: el,
                  child: Text(el.name),
                ),
              ),
            ],
          ),
        ),
      ],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomClassesList(
          onEdit: _edit,
          onDelete: _delete,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        onPressed: _add,
      ),
    );
  }

  void _add() {
    Navigator.push(
      context,
      MaterialPageRoute<bool>(
        builder: (context) => CustomClassWizard(mode: DialogMode.Create),
      ),
    );
  }

  void _edit(CustomClass cls) {
    Navigator.push(
      context,
      MaterialPageRoute<bool>(
        builder: (context) => CustomClassWizard(
          mode: DialogMode.Edit,
          customClass: cls,
          onSave: _save,
        ),
      ),
    );
  }

  void _save(CustomClass _cls) async {
    for (var char in dwStore.state.characters.characters.values) {
      if (char.playerClasses.any((el) => el.key == _cls.key)) {
        var _updated = char.playerClasses
            .map((el) => el.key == _cls.key ? _cls.toPlayerClass() : el)
            .toList();
        char.playerClasses = _updated;
        await char.update();
      }
    }
  }

  void _delete(CustomClass cls) async {
    if (await showDialog(
          context: context,
          builder: (context) => ConfirmationDialog(
            title: Text('Are you sure you want to delete this class?'),
            text: Text(
                "Don't worry, your characters using this class wil not be affected."),
          ),
        ) ==
        true) {
      unawaited(cls.delete());
    }
  }

  void _copyExisting(PlayerClass cls) {
    var custCls = CustomClass.fromPlayerClass(cls);
    custCls.name = custCls.name + ' copy';

    Navigator.push(
      context,
      MaterialPageRoute<bool>(
        builder: (context) => CustomClassWizard(
          mode: DialogMode.Create,
          customClass: custCls,
        ),
      ),
    );
  }
}
