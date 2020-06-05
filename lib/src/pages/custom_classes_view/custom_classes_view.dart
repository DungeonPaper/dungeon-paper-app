import 'package:dungeon_paper/db/models/custom_class.dart';
import 'package:dungeon_paper/src/dialogs/dialogs.dart';
import 'package:dungeon_paper/src/lists/custom_classes_list.dart';
import 'package:dungeon_paper/src/scaffolds/custom_class_wizard/custom_class_wizard.dart';
import 'package:dungeon_paper/src/scaffolds/scaffold_with_elevation.dart';
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
      body: CustomClassesList(onEdit: _edit),
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
}
