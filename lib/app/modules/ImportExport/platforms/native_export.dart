import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:path/path.dart' as path;
import 'package:get/get.dart';
import 'package:dungeon_paper/generated/l10n.dart';

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
          title: S.current.exportFailedTitle,
          message: S.current.errorUserOperationCanceled,
        );
      } else {
        Get.rawSnackbar(
          title: S.current.exportSuccessfulTitle,
          message: S.current.exportSuccessfulMessage,
        );
      }
    } catch (e) {
      Get.rawSnackbar(
        title: S.current.exportFailedTitle,
        message: S.current.exportFailedMessage,
      );
      rethrow;
    }
  }
}
