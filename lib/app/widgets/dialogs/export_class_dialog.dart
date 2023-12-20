import 'dart:convert';
import 'package:dungeon_paper/app/data/services/repository_provider.dart';
import 'package:dungeon_paper/app/modules/ImportExport/controllers/export_controller.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/models/character_class.dart';
import '../../modules/ImportExport/platforms/platform_export.dart';
import '../atoms/select_box.dart';
import '../molecules/dialog_controls.dart';

class ExportClassDialog extends StatefulWidget {
  const ExportClassDialog({super.key});

  @override
  State<ExportClassDialog> createState() => _ExportClassDialogState();
}

class _ExportClassDialogState extends State<ExportClassDialog>
    with RepositoryProviderMixin {
  CharacterClass? cls;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(tr.backup.exporting.bundles.characterClass.title),
      content: SingleChildScrollView(
        child: Column(
          children: [
            SelectBox<CharacterClass?>(
              value: cls,
              onChanged: (value) => setState(() => cls = value),
              isExpanded: true,
              label: Text(tr.entity(tn(CharacterClass))),
              items: {
                ...repo.builtIn.classes.values,
                ...repo.my.classes.values,
              }
                  .map(
                    (cls) => DropdownMenuItem(
                      value: cls,
                      child: Text(cls.name),
                    ),
                  )
                  .toList(),
            )
          ],
        ),
      ),
      actions: DialogControls.custom(
        context,
        onConfirm: cls != null ? _export : null,
        confirmLabel: tr.backup.exporting.button,
        onCancel: () => Navigator.of(context).pop(),
        cancelLabel: tr.generic.cancel,
      ),
    );
  }

  void _export() {
    if (cls == null) {
      return;
    }
    final toExport = ExportSelections()
      ..classes.add(cls!)
      ..moves.addAll(
        repo.my.moves.values
            .where((v) => v.classKeys.any((c) => c.key == cls!.key)),
      )
      ..spells.addAll(
        repo.my.spells.values
            .where((v) => v.classKeys.any((c) => c.key == cls!.key)),
      )
      ..races.addAll(
        repo.my.races.values
            .where((v) => v.classKeys.any((c) => c.key == cls!.key)),
      );
    final strData = utf8.encode(json.encode(toExport.toJson()));

    final dt = DateFormat('yy-MM-dd_HH.mm.ss').format(DateTime.now());
    final fileName = 'DungeonPaperV2_$dt.json';

    Exporter().export(strData, fileName);
  }
}

