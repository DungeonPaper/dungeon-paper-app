import 'dart:convert';
import 'dart:io';

import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_paper/db/models/custom_class.dart';
import 'package:dungeon_paper/src/dialogs/confirmation_dialog.dart';
import 'package:dungeon_paper/src/lists/character_select_list.dart';
import 'package:dungeon_paper/src/lists/custom_class_select_list.dart';
import 'package:dungeon_paper/src/redux/characters/characters_store.dart';
import 'package:dungeon_paper/src/redux/stores.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:get/get.dart';

class ImportView extends StatefulWidget {
  @override
  _ImportViewState createState() => _ImportViewState();
}

enum ImportFormat {
  JSON,
}

class _ImportViewState extends State<ImportView> {
  Set<Character> _charactersToImport;
  Set<CustomClass> _classesToImport;
  Set<Character> _loadedCharacters;
  Set<CustomClass> _loadedClasses;

  @override
  void initState() {
    super.initState();
    _loadedCharacters = {};
    _loadedClasses = {};
    _charactersToImport = {};
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
        if (_loadedCharacters.isNotEmpty)
          ExpansionTile(
            title: Text('Select characters'),
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: CharacterSelectList(
                  characters: _loadedCharacters,
                  selected: _charactersToImport,
                  onChange: (chars) =>
                      setState(() => _charactersToImport = chars),
                ),
              ),
            ],
          ),
        if (_loadedClasses.isNotEmpty)
          ExpansionTile(
            title: Text('Select custom classes'),
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: CustomClassSelectList(
                  characters: _loadedClasses.map((c) => c.toPlayerClass()),
                  selected: _classesToImport.map((c) => c.toPlayerClass()),
                  onChange: (chars) => setState(() => _classesToImport =
                      chars.map((c) => CustomClass.fromPlayerClass(c))),
                ),
              ),
            ],
          ),
        if (_loadedCharacters.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 24),
            child: RaisedButton.icon(
              padding: const EdgeInsets.all(8),
              label: Text('Browse...'),
              icon: Icon(Icons.folder),
              onPressed: _pickFile,
            ),
          ),
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 8).copyWith(bottom: 8),
          child: Align(
            alignment: Alignment.centerRight,
            child: RaisedButton.icon(
              padding: const EdgeInsets.all(8),
              icon: Icon(Icons.file_download),
              label: Text(
                'Import',
                textScaleFactor: 1.5,
              ),
              onPressed: _charactersToImport.isNotEmpty ? _confirmImport : null,
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
        await _loadFile(_tmpFile);
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
      for (final char in _charactersToImport) {
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
        _charactersToImport = {};
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

  void _loadFile(File file) async {
    final str = await file.readAsString();
    final _format = ImportFormat.JSON;
    final data = _dataParsers[_format]?.call(str);

    setState(() {
      _loadedCharacters = Set.from(data.characters);
      _loadedCharacters = Set.from(data.characters);
    });
  }

  final Map<ImportFormat, ImportData Function(String)> _dataParsers = {
    ImportFormat.JSON: (str) {
      final raw = jsonDecode(str);
      final json = raw is List ? {'characters': raw} : raw;
      final chars = Set<Character>.from(json.map((v) => Character(data: v)));
      final customClasses =
          Set<CustomClass>.from(json.map((v) => CustomClass(data: v)));

      return ImportData(characters: chars, customClasses: customClasses);
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

class ImportData {
  final Set<Character> characters;
  final Set<CustomClass> customClasses;

  ImportData({
    @required this.characters,
    @required this.customClasses,
  });
}
