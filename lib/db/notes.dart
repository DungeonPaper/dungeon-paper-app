import 'package:dungeon_paper/db/base.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:dungeon_paper/refactor/character.dart';
import 'package:dungeon_paper/utils.dart';
import 'package:uuid/uuid.dart';

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

  @override
  toJSON() {
    return {
      'key': key,
      'title': title,
      'category': category.toString(),
      'description': description,
    };
  }

  @override
  initSerializeMap([Map map]) {
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

  static List<NoteCategory> defaultCategories = [
    npcs,
    loot,
    locations,
    quests,
    misc
  ];

  @override
  String toString() => name;

  operator ==(dynamic obj) {
    if (obj == null || obj is! NoteCategory) {
      return false;
    }

    return obj.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}

ReturnPredicate<Note> matchNote =
    matcher<Note>((Note i, Note o) => i.key == o.key);

Future updateNote(Note note) async {
  if (dwStore.state.characters.current == null) {
    throw ('No character loaded.');
  }

  Character character = dwStore.state.characters.current;
  await character
      .update(json: {'notes': findAndReplaceInList(character.notes, note)});
}

Future deleteNote(Note note) async {
  if (dwStore.state.characters.current == null) {
    throw ('No character loaded.');
  }

  Character character = dwStore.state.characters.current;
  await character
      .update(json: {'notes': removeFromList(character.notes, note)});
}

Future createNote(Note note) async {
  if (dwStore.state.characters.current == null) {
    throw ('No character loaded.');
  }

  Character character = dwStore.state.characters.current;
  await character.update(json: {'notes': addToList(character.notes, note)});
}
