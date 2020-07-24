import 'dart:convert';
import 'dart:io';

import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_paper/src/dialogs/standard_dialog_controls.dart';
import 'package:dungeon_paper/src/lists/character_list.dart';
import 'package:dungeon_paper/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

class ExportCharactersDialog extends StatefulWidget {
  @override
  _ExportCharactersDialogState createState() => _ExportCharactersDialogState();
}

enum ExportFormat {
  JSON,
  HTML,
  PDF,
}

class _ExportCharactersDialogState extends State<ExportCharactersDialog> {
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
    return SimpleDialog(
      title: Text('Export Characters'),
      contentPadding: EdgeInsets.only(bottom: 8),
      children: [
        _Padded(child: Text('Select characters to export')),
        _Padded(
          child: Row(
            children: [
              Text('Select export format:'),
              SizedBox(width: 16),
              DropdownButton(
                value: _format,
                onChanged: _setFormat,
                items: [
                  for (var format in ExportFormat.values
                      .where((format) => _dataParsers[format] != null))
                    DropdownMenuItem(
                      child: Text(enumName(format)),
                      value: _dataParsers[format] != null ? format : null,
                    ),
                ],
              ),
            ],
          ),
        ),
        CharacterList(
          key: Key(_toExport.map((char) => char.documentID).toString()),
          builder: (context, list) => _Padded(
            horizontal: 8,
            child: Row(
              children: [
                Flexible(
                  child: Column(
                    children: [
                      ListTile(
                        leading: Checkbox(
                          value: _allChecked(list),
                          onChanged: _onCheckAll(list),
                        ),
                        title: Text(
                          'Select All',
                          style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.6),
                          ),
                        ),
                        onTap: _toggleAll(list),
                      ),
                      for (var char in list)
                        ListTile(
                          leading: Checkbox(
                            value: _toExport.contains(char),
                            onChanged: _onChecked(char),
                          ),
                          title: Text(char.displayName),
                          onTap: _toggle(char),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        StandardDialogControls(
          okText: Text('Export'),
          onOK: _export,
          onCancel: _exit,
        ),
      ],
    );
  }

  void Function(bool) _onChecked(Character char) {
    return (bool state) {
      setState(() {
        if (state) {
          _toExport.add(char);
        } else {
          _toExport.remove(char);
        }
      });
    };
  }

  void Function(bool) _onCheckAll(List<Character> list) {
    return (bool state) {
      setState(() {
        if (state) {
          _toExport = list.toSet();
        } else {
          _toExport = {};
        }
      });
    };
  }

  void Function() _toggle(Character char) {
    return () {
      setState(() {
        if (!_toExport.contains(char)) {
          _toExport.add(char);
        } else {
          _toExport.remove(char);
        }
      });
    };
  }

  void Function() _toggleAll(List<Character> list) {
    return () {
      setState(() {
        if (!_allChecked(list)) {
          _toExport = list.toSet();
        } else {
          _toExport = {};
        }
      });
    };
  }

  bool _allChecked(List<Character> list) =>
      list.every((char) => _toExport.contains(char));

  void _export() async {
    var _strData = _dumpDataString();
    var tmp = await getTemporaryDirectory();
    var fileName = 'dungeon-paper-characters.json';

    var _tmpFile = File(join(tmp.path, fileName));
    await _tmpFile.writeAsString(_strData);

    final params = SaveFileDialogParams(sourceFilePath: _tmpFile.path);
    await FlutterFileDialog.saveFile(params: params);
  }

  String _dumpDataString() {
    final chars = Set<Character>.from(_toExport).toList()
      ..sort((a, b) => a.order - b.order);
    return _dataParsers[_format]?.call(chars);
  }

  static final Map<ExportFormat, String Function(List<Character>)>
      _dataParsers = {
    ExportFormat.JSON: (chars) {
      var charsData = chars.map((char) => char.toJSON()).toList();
      var _strData = jsonEncode(charsData);
      return _strData;
    }
  };

  void _setFormat(ExportFormat format) {
    if (format != null) {
      setState(() {
        _format = format;
      });
    }
  }

  void _exit() {
    Navigator.pop(context);
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
