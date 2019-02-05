import 'package:dungeon_paper/db/base.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'character.dart';

// NOT USED...
class Note extends DbBase {
  String get category => get('category');
  String get title => get('title');
  String get description => get('description');

  Note([Map map])
      : super(map, defaultData: {
          'category': '',
          'title': '',
          'description': '',
        });
}
// ...NOT USED

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
