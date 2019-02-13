import 'package:dungeon_paper/db/base.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'character.dart';

class NoteCategory {
  String name;
  NoteCategory(String _name)
      : name = _name != null && _name.length > 0 ? _name : 'Misc';

  static NoteCategory npcs = NoteCategory('NPCs');
  static NoteCategory loot = NoteCategory('Loot');
  static NoteCategory locations = NoteCategory('Locations');
  static NoteCategory quests = NoteCategory('Quests');
  static NoteCategory misc = NoteCategory('Misc');

  @override
  String toString() => name;

  operator == (dynamic obj) {
    if (obj == null || obj is! NoteCategory) {
      return false;
    }

    return obj.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}

class Note extends DbBase {
  NoteCategory get category => NoteCategory(get('category'));
  String get title => get('title');
  String get description => get('description');

  Note([Map map])
      : super(map, defaultData: {
          'category': '',
          'title': '',
          'description': '',
        });
}

Future updateNote(num index, Note note) async {
  if (dwStore.state.characters.current == null) {
    throw ('No character loaded.');
  }

  List notes = List.from(dwStore.state.characters.current.notes);
  notes[index] = note;
  await updateCharacter({'notes': notes});
}

Future deleteNote(num index) async {
  if (dwStore.state.characters.current == null) {
    throw ('No character loaded.');
  }

  List notes = List.from(dwStore.state.characters.current.notes);
  notes.removeAt(index);
  await updateCharacter({'notes': notes});
}

Future createNote(Note note) async {
  if (dwStore.state.characters.current == null) {
    throw ('No character loaded.');
  }

  List notes = List.from(dwStore.state.characters.current.notes);
  notes.add(note);
  await updateCharacter({'notes': notes});
}
