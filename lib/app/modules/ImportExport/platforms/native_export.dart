import 'dart:io';
import 'dart:typed_data';

import 'package:dungeon_paper/app/modules/ImportExport/platforms/abstract_export.dart';
import 'package:path_provider/path_provider.dart';

class Exporter extends AbstractExporter {
  @override
  void export(Uint8List data, String filename) async {
    final tmp = await getTemporaryDirectory();

    final tmpFile = File(path.join(tmp.path, filename));
    await tmpFile.writeAsBytes(data, mode: FileMode.writeOnly);

    final params = SaveFileDialogParams(sourceFilePath: tmpFile.path);
    try {
      final path = await FlutterFileDialog.saveFile(params: params);
      if (path == null) {
        Get.rawSnackbar(
          title: tr.backup.exporting.error.title,
          message: tr.errors.userOperationCanceled,
        );
      } else {
        Get.rawSnackbar(
          title: tr.backup.exporting.success.title,
          message: tr.backup.exporting.success.message,
        );
      }
    } catch (e) {
      Get.rawSnackbar(
        title: tr.backup.exporting.error.title,
        message: tr.backup.exporting.error.message,
      );
      rethrow;
    }
  }
}
