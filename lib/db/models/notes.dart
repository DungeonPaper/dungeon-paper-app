import 'package:dungeon_paper/db/base.dart';
import 'package:dungeon_paper/src/utils/utils.dart';
import 'package:uuid/uuid.dart';

import 'character.dart';

enum NoteKeys { key, title, description, category }

class Note with Serializer<NoteKeys> {
  String category;
  String key;
  String title;
  String description;

  static final defaultCategories = [
    'NPCs',
    'Loot',
    'Locations',
    'Quests',
    'Misc'
  ];

  Note([Map map]) {
    map ??= {};
    initSerializeMap({
      NoteKeys.key: map['key'],
      NoteKeys.title: map['title'],
      NoteKeys.description: map['description'],
      NoteKeys.category: map['category'],
    });
  }

  factory Note.fromJSON(Map map) => Note(map);

  @override
  Map<String, dynamic> toJSON() {
    return {
      'key': key,
      'title': title,
      'category': category,
      'description': description,
    };
  }

  @override
  dynamic initSerializeMap([Map map]) {
    serializeMap = {
      NoteKeys.key: (v) {
        key = v ?? Uuid().v4();
      },
      NoteKeys.title: (v) {
        title = v ?? '';
      },
      NoteKeys.description: (v) {
        description = v ?? '';
      },
      NoteKeys.category: (v) {
        category = v ?? 'Misc';
      },
    };
    return serializeAll(map);
  }
}

ReturnPredicate<Note> matchNote =
    matcher<Note>((Note i, Note o) => i.key == o.key);

Future updateNote(Character character, Note note) async {
  await character.update(json: {
    'notes': findAndReplaceInList<Note>(
        character.notes, note, (n) => note.key == n.key)
  });
}

Future deleteNote(Character character, Note note) async {
  await character.update(json: {
    'notes': removeFromList(character.notes, note, (n) => note.key == n.key)
  });
}

Future createNote(Character character, Note note) async {
  await character.update(json: {'notes': addToList(character.notes, note)});
}

List<String> collectCategories(
  List<Note> notes, {
  bool includeDefault = true,
}) =>
    {
      if (includeDefault == true) ...Note.defaultCategories,
      ...groupBy<String, Note>(notes, (note) => note.category).keys
    }.toList();
