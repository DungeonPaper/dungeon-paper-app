import 'dart:convert';
import 'dart:io';

import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_paper/src/lists/character_select_list.dart';
import 'package:dungeon_paper/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

class ExportCharactersView extends StatefulWidget {
  @override
  _ExportCharactersViewState createState() => _ExportCharactersViewState();
}

enum ExportFormat {
  JSON,
  CSV,
  // HTML,
  // PDF,
}

class _ExportCharactersViewState extends State<ExportCharactersView> {
  Set<Character> _toExport;
  ExportFormat _format;

  @override
  void initState() {
    super.initState();
    _format = ExportFormat.JSON;
    _toExport = {};
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _Padded(
          child: Text(
            'Select characters to export',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        if (_dataParsers.values.length > 1)
          _Padded(
            child: Row(
              children: [
                Text('Select export format:'),
                SizedBox(width: 16),
                DropdownButton(
                  value: _format,
                  onChanged: _setFormat,
                  items: [
                    for (final format in ExportFormat.values)
                      if (_dataParsers[format] != null)
                        DropdownMenuItem(
                          child: Text(enumName(format)),
                          value: format,
                        ),
                  ],
                ),
              ],
            ),
          ),
        CharacterSelectList(
          selected: _toExport,
          onChange: (chars) => setState(() => _toExport = chars),
        ),
        SizedBox(height: 16),
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 8).copyWith(bottom: 8),
          child: Align(
            alignment: Alignment.centerRight,
            child: RaisedButton.icon(
              padding: const EdgeInsets.all(8),
              icon: Icon(Icons.file_upload),
              label: Text(
                'Export',
                textScaleFactor: 1.5,
              ),
              onPressed: _toExport.isNotEmpty ? _export : null,
            ),
          ),
        ),
      ],
    );
  }

  void _export() async {
    final _strData = _dumpDataString();
    final tmp = await getTemporaryDirectory();
    final ext = formatExts[_format];
    final dt = DateTime.now().toIso8601String();
    final fileName = 'dungeon-paper-$dt.$ext';

    final _tmpFile = File(join(tmp.path, fileName));
    await _tmpFile.writeAsString(_strData);

    final params = SaveFileDialogParams(sourceFilePath: _tmpFile.path);
    try {
      final path = await FlutterFileDialog.saveFile(params: params);
      if (path == null) {
        Get.snackbar('Export Failed', 'Operation canceled');
      } else {
        Get.snackbar(
          'Export Successful',
          'Your characters were exported without problems',
        );
      }
    } catch (e) {
      Get.snackbar('Export Failed', 'Something went wrong.');
      rethrow;
    }
  }

  String _dumpDataString() {
    final chars = Set<Character>.from(_toExport).toList()
      ..sort((a, b) => a.order - b.order);
    return _dataParsers[_format]?.call(chars);
  }

  static Map<ExportFormat, String> formatExts = {
    ExportFormat.JSON: 'json',
    ExportFormat.CSV: 'csv',
  };

  static Map<ExportFormat, String Function(List<Character>)> _dataParsers = {
    ExportFormat.JSON: (chars) {
      final charsData = chars.map((char) => char.toJSON()).toList();
      final _strData = jsonEncode(charsData);
      return _strData;
    },
    // ExportFormat.CSV: (chars) {
    //   final output = <List<String>>[];
    //   final headers = <String>[];
    //   for (final field in chars.elementAt(0).fields.fields) {
    //     if (field.isSerialized) {
    //       headers.add(field.outputFieldName);
    //     }
    //   }
    //   output.add(headers);

    //   for (final char in chars) {
    //     final row = <String>[];
    //     for (final field in char.fields.fields) {
    //       if (field.isSerialized) {
    //         row.add(__quoteWrap(field.toJSON().toString()));
    //       }
    //     }
    //     output.add(row);
    //   }
    //   return output.map((r) => r.map(__quoteWrap).join(',')).join('\n');
    // },
  };

  static String __quoteWrap(String str) => str.contains(' ') ? '"$str"' : str;

  void _setFormat(ExportFormat format) {
    if (format != null) {
      setState(() {
        _format = format;
      });
    }
  }
}

class _Padded extends StatelessWidget {
  final Widget child;
  final double vertical;
  final double horizontal;

  const _Padded({
    Key key,
    @required this.child,
    this.vertical,
    this.horizontal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      child: child,
      padding: _padding,
    );
  }

  EdgeInsets get _padding {
    var _p = EdgeInsets.symmetric(horizontal: 24, vertical: 8);
    if (vertical != null) {
      _p = _p.copyWith(top: vertical, bottom: vertical);
    }
    if (horizontal != null) {
      _p = _p.copyWith(left: horizontal, right: horizontal);
    }
    return _p;
  }
}
