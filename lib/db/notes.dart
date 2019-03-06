import 'package:dungeon_paper/db/base.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'character.dart';

enum NoteKeys { title, description, category }

class Note with Serializer<NoteKeys> {
  NoteCategory category;
  String title;
  String description;

  Note([Map map]) {
    map ??= {};
    initSerializeMap({
      NoteKeys.title: map['title'],
      NoteKeys.description: map['description'],
      NoteKeys.category: map['category'],
    });
  }

  @override
  toJSON() {
    return {
      NoteKeys.title: title,
      NoteKeys.category: category,
      NoteKeys.description: description,
    };
  }

  @override
  initSerializeMap([Map map]) {
    serializeMap = {
      NoteKeys.title: (v) {
        title = v ?? '';
      },
      NoteKeys.description: (v) {
        description = v ?? '';
      },
      NoteKeys.category: (v) {
        category = NoteCategory(v);
      },
    };
    return serializeAll(map);
  }
}

class NoteCategory {
  String name;
  NoteCategory(String _name)
      : name = _name != null && _name.length > 0 ? _name : 'Misc';

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

Future updateNote(num index, Note note) async {
  if (dwStore.state.characters.current == null) {
    throw ('No character loaded.');
  }

  DbCharacter character = dwStore.state.characters.current;
  character.notes[index] = note;
  await updateCharacter(character, [CharacterKeys.notes]);
}

Future deleteNote(num index) async {
  if (dwStore.state.characters.current == null) {
    throw ('No character loaded.');
  }

  DbCharacter character = dwStore.state.characters.current;
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
