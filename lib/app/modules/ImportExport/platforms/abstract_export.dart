import 'dart:typed_data';

abstract class AbstractExporter {
  void export(Uint8List data, String filename);
}

class Exporter extends AbstractExporter {
  @override
  void export(Uint8List data, String filename) {
    throw UnimplementedError('Unsupported platform is unsupported');
  }
}
