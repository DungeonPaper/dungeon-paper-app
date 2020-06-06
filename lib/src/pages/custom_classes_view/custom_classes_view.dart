import 'package:dungeon_paper/db/models/custom_class.dart';
import 'package:dungeon_paper/src/dialogs/dialogs.dart';
import 'package:dungeon_paper/src/lists/custom_classes_list.dart';
import 'package:dungeon_paper/src/lists/player_class_list.dart';
import 'package:dungeon_paper/src/scaffolds/custom_class_wizard/custom_class_wizard.dart';
import 'package:dungeon_paper/src/scaffolds/scaffold_with_elevation.dart';
import 'package:dungeon_world_data/player_class.dart';
import 'package:flutter/material.dart';

class CustomClassesView extends StatefulWidget {
  @override
  _CustomClassesViewState createState() => _CustomClassesViewState();
}

class _CustomClassesViewState extends State<CustomClassesView> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldWithElevation.primaryBackground(
      title: Text('Custom Classes'),
      actions: [
        PlayerClassList(
          builder: (context, list) => PopupMenuButton<PlayerClass>(
            icon: Icon(Icons.content_copy),
            tooltip: 'Copy existing class:',
            onSelected: _copyExisting,
            itemBuilder: (context) => [
              PopupMenuItem<PlayerClass>(
                value: null,
                enabled: false,
                child: Text('Copy existing class'),
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
        child: CustomClassesList(onEdit: _edit),
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
        ),
      ),
    );
  }

  void _copyExisting(PlayerClass cls) {
    var custCls = CustomClass.fromPlayerClass(cls);
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
