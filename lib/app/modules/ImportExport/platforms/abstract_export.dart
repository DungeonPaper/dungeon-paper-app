import 'dart:typed_data';

import 'package:flutter/material.dart';

abstract class AbstractExporter {
  void export(BuildContext context, Uint8List data, String filename);
}

class Exporter extends AbstractExporter {
  @override
  void export(BuildContext context, Uint8List data, String filename) {
    throw UnimplementedError('Unsupported platform is unsupported');
  }
}
