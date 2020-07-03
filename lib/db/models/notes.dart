import 'package:dungeon_paper/db/base.dart';
import 'package:dungeon_paper/src/utils/utils.dart';
import 'package:uuid/uuid.dart';

import 'character.dart';

enum NoteKeys { key, title, description, category }

class Note with Serializer<NoteKeys> {
  NoteCategory category;
  String key;
  String title;
  String description;

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
      'category': category.toString(),
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
        category = NoteCategory((v ?? NoteCategory.misc.name).toString());
      },
    };
    return serializeAll(map);
  }
}

class NoteCategory {
  String name;
  NoteCategory(String _name)
      : name = _name != null && _name.isNotEmpty ? _name : 'Misc';

  static NoteCategory npcs = NoteCategory('NPCs');
  static NoteCategory loot = NoteCategory('Loot');
  static NoteCategory locations = NoteCategory('Locations');
  static NoteCategory quests = NoteCategory('Quests');
  static NoteCategory misc = NoteCategory('Misc');
  static NoteCategory emptyState = NoteCategory('Empty State');

  static List<NoteCategory> defaultCategories = [
    npcs,
    loot,
    locations,
    quests,
    misc
  ];

  @override
  String toString() => name;

  @override
  bool operator ==(dynamic obj) {
    if (obj is! NoteCategory) {
      return false;
    }

    return obj.name == name;
  }

  @override
  int get hashCode => name.hashCode;
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
