import 'dart:typed_data';

abstract class AbstractExporter {
  void export(Uint8List data, String filename);
}
