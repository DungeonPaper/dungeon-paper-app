import 'package:dungeon_paper/db/base.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:dungeon_paper/utils.dart';
import 'package:uuid/uuid.dart';
import 'character.dart';
import 'character_db.dart';
import 'character_utils.dart';

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

ReturnPredicate<Note> matchNote = matcher<Note>(
    (Note i, Note o) => i.key == o.key);

Future updateNote(Note note) async {
  if (dwStore.state.characters.current == null) {
    throw ('No character loaded.');
  }

  DbCharacter character = dwStore.state.characters.current;
  num index = character.notes.indexWhere(matchNote(note));
  character.notes[index] = note;
  await updateCharacter(character, [CharacterKeys.notes]);
}

Future deleteNote(Note note) async {
  if (dwStore.state.characters.current == null) {
    throw ('No character loaded.');
  }

  DbCharacter character = dwStore.state.characters.current;
  num index = character.notes.indexWhere(matchNote(note));
  character.notes.removeAt(index);
  await updateCharacter(character, [CharacterKeys.notes]);
}

Future createNote(Note note) async {
  if (dwStore.state.characters.current == null) {
    throw ('No character loaded.');
  }

  DbCharacter character = dwStore.state.characters.current;
  character.notes.add(note);
  await updateCharacter(character, [CharacterKeys.notes]);
}
