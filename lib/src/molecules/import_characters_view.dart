import 'dart:convert';
import 'dart:io';

import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_paper/src/dialogs/confirmation_dialog.dart';
import 'package:dungeon_paper/src/lists/character_select_list.dart';
import 'package:dungeon_paper/src/redux/characters/characters_store.dart';
import 'package:dungeon_paper/src/redux/stores.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:get/get.dart';

class ImportCharactersView extends StatefulWidget {
  @override
  _ImportCharactersViewState createState() => _ImportCharactersViewState();
}

enum ImportFormat {
  JSON,
}

class _ImportCharactersViewState extends State<ImportCharactersView> {
  Set<Character> _toImport;
  Set<Character> _loadedCharacters;

  @override
  void initState() {
    super.initState();
    _loadedCharacters = {};
    _toImport = {};
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _Padded(
          child: Text(
            '${_loadedCharacters.isNotEmpty ? 'Select' : 'Load'} characters to import',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Divider(),
        if (_loadedCharacters.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: CharacterSelectList(
              characters: _loadedCharacters,
              selected: _toImport,
              onChange: (chars) => setState(() => _toImport = chars),
            ),
          ),
        if (_loadedCharacters.isEmpty)
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8).copyWith(bottom: 8),
            child: RaisedButton(
              padding: const EdgeInsets.all(8),
              child: Text('Import'),
              onPressed: _pickFile,
            ),
          ),
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 8).copyWith(bottom: 8),
          child: Align(
            alignment: Alignment.centerRight,
            child: RaisedButton(
              padding: const EdgeInsets.all(8),
              child: Text(
                'Import',
                textScaleFactor: 1.5,
              ),
              onPressed: _toImport.isNotEmpty ? _confirmImport : null,
            ),
          ),
        ),
      ],
    );
  }

  void _pickFile() async {
    final params = OpenFileDialogParams(
        fileExtensionsFilter: ['json'], allowedUtiTypes: ['public.json']);

    try {
      final path = await FlutterFileDialog.pickFile(params: params);
      if (path == null) {
        Get.snackbar('Import Failed', 'Operation canceled');
      } else {
        final _tmpFile = File(path);
        final chars = await _loadFile(_tmpFile);
        setState(() {
          _loadedCharacters = Set.from(chars);
        });
      }
    } catch (e) {
      Get.snackbar('Import Failed', 'Something went wrong.');
      rethrow;
    }
  }

  void _import() async {
    try {
      final user = dwStore.state.user.current;
      final characters = dwStore.state.characters.all;
      final finalChars = Set<Character>.from(characters.values);
      for (final char in _toImport) {
        final found = finalChars.firstWhere(
            (_char) => _char.displayName == char.displayName,
            orElse: () => null);
        Character added;
        if (found == null) {
          added = await user.createCharacter(char);
        } else {
          await found.update(json: char.toJSON());
          added = found;
        }
        finalChars.remove(found);
        finalChars.add(added);
      }

      dwStore.dispatch(SetCharacters.fromIterable(finalChars));

      setState(() {
        _loadedCharacters = {};
        _toImport = {};
      });

      Get.snackbar(
        'Import Successful',
        'Your characters were imported without problems',
      );
    } catch (e) {
      Get.snackbar('Import Failed', 'Something went wrong.');
      rethrow;
    }
  }

  void _confirmImport() async {
    final res = await Get.dialog(ConfirmationDialog(
      title: Text('Please Confirm'),
      text: Text(
          "Existing characters with the same name will be overwritten.\nAre you sure that's okay?"),
      okButtonText: Text('Overwrite & Import'),
    ));

    if (res == true) {
      _import();
    }
  }

  Future<List<Character>> _loadFile(File file) async {
    final str = await file.readAsString();
    final _format = ImportFormat.JSON;
    return _dataParsers[_format]?.call(str);
  }

  static final Map<ImportFormat, List<Character> Function(String)>
      _dataParsers = {
    ImportFormat.JSON: (str) {
      final json = jsonDecode(str) as List<dynamic>;
      final chars = Set<Character>.from(
        json.map((v) => Character(data: v)),
      ).toList();
      return chars;
    }
  };
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
