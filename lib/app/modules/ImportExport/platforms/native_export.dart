import 'dart:io';
import 'dart:typed_data';

import 'package:dungeon_paper/app/modules/ImportExport/platforms/abstract_export.dart';
import 'package:dungeon_paper/app/widgets/atoms/custom_snack_bar.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class Exporter extends AbstractExporter {
  @override
  void export(BuildContext context, Uint8List data, String filename) async {
    final tmp = await getTemporaryDirectory();

    final tmpFile = File(path.join(tmp.path, filename));
    await tmpFile.writeAsBytes(data, mode: FileMode.writeOnly);

    try {
      final path = await FilePicker.platform.saveFile(bytes: tmpFile.readAsBytesSync());
      if (path == null) {
        CustomSnackBar.show(
          title: tr.backup.exporting.error.title,
          content: tr.errors.userOperationCanceled,
        );
      } else {
        CustomSnackBar.show(
          title: tr.backup.exporting.success.title,
          content: tr.backup.exporting.success.message,
        );
      }
    } catch (e) {
      CustomSnackBar.show(
        title: tr.backup.exporting.error.title,
        content: tr.backup.exporting.error.message,
      );
      rethrow;
    }
  }
}