import 'dart:typed_data';

import 'package:dungeon_paper/app/modules/ImportExport/platforms/abstract_import_export.dart';

class Exporter extends AbstractExporter {
  @override
  void export(Uint8List data, String filename) {
    throw UnimplementedError('Unsupported platform is unsupported');
  }
}
