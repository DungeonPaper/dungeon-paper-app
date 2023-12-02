import 'dart:convert';
import 'dart:typed_data';
import 'dart:html' as html;

import 'package:dungeon_paper/app/modules/ImportExport/platforms/abstract_export.dart';

void downloadFileFromDataURL(String dataURL, String fileName) => html.AnchorElement(href: dataURL)
  ..setAttribute('download', fileName)
  ..click();

class Exporter extends AbstractExporter {
  @override
  void export(Uint8List data, String filename) {
    final base64Data = base64Encode(data);
    final dataUrl = 'data:;base64,$base64Data';
    downloadFileFromDataURL(dataUrl, filename);
  }
}
