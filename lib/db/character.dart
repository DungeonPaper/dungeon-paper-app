import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dungeon_paper/db/character_types.dart';
import 'package:dungeon_paper/db/notes.dart';
import 'package:dungeon_paper/db/user.dart';
import 'package:dungeon_paper/redux/actions/character_actions.dart';
import 'package:dungeon_paper/redux/actions/user_actions.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'base.dart';

class DbCharacter extends DbBase {
  var listProperties = ['notes', 'moves'];

  String get alignment => get('alignment');
  String get displayName => get('displayName');
  String get mainClass => get('mainClass');
  String get photoURL => get('photoURL');
  num get level => get('level');
  num get currentHP => get('currentHP');
  num get currentXP => get('currentXP');
  num get maxHP => get('maxHP');
  num get armor => get('armor');
  num get str => get('str');
  num get dex => get('dex');
  num get con => get('con');
  num get wis => get('wis');
  num get int => get('int');
  num get cha => get('cha');
  List get moves => get('moves');
  List<Note> get notes => getList('notes');

  DbCharacter([Map map])
      : super(map, defaultData: {
          'alignment': AlignmentMap[Alignment.good],
          'displayName': 'Traveler',
          'mainClass': 'bard',
          'photoURL': null,
          'level': 0,
          'currentHP': 0,
          'currentXP': 0,
          'maxHP': 0,
          'armor': 0,
          'str': 0,
          'dex': 0,
          'con': 0,
          'wis': 0,
          'int': 0,
          'cha': 0,
          'moves': [],
          'notes': [],
        }, propertyMapping: {
          'notes': (note) => Note(note),
          // 'moves': (moves) => moves.map((move) => Move(move)),
        });

  static num statModifier(num stat) {
    const modifiers = {1: -3, 4: -2, 6: -1, 9: 0, 13: 1, 16: 2, 18: 3};

    if (modifiers.containsKey(stat)) {
      return modifiers[stat];
    }

    for (num i = stat; i > 0; --i) {
      if (modifiers.containsKey(i)) {
        return modifiers[i];
      }
    }

    return -1;
  }

  static String statModifierText(num stat) {
    num mod = statModifier(stat);
    return (mod >= 0 ? '+' : '') + mod.toString();
  }
}

Future<DbCharacter> setCurrentCharacterById(String documentId) async {
  DocumentSnapshot character =
      await Firestore.instance.document('character_bios/$documentId').get();
  DbCharacter dbCharacter = DbCharacter(character.data);

  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('characterId', character.documentID);

  dwStore.dispatch(
    CharacterActions.setCurrentChar(character.documentID, dbCharacter),
  );

  return dbCharacter;
}

Future<Map<String, DbCharacter>> getAllCharacters(DocumentSnapshot user) async {
  Map<String, Future<DocumentSnapshot>> refs = {};
  Map<String, DbCharacter> chars = {};
  user.data['characters'].forEach((char) {
    refs[char.documentID] =
        Firestore.instance.document('character_bios/${char.documentID}').get();
  });

  List<DocumentSnapshot> results = await Future.wait(refs.values);

  results.forEach((r) {
    chars[r.documentID] = DbCharacter(r.data);
  });

  dwStore.dispatch(CharacterActions.setCharacters(chars));
  return chars;
}

unsetCurrentCharacter() async {
  print('Unsetting characters');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('characterId');
  dwStore.dispatch(CharacterActions.remove());
}

Future<Map> updateCharacter(Map<String, dynamic> data) async {
  Firestore firestore = Firestore.instance;
  final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
  final String charDocId = sharedPrefs.getString('characterId');
  print('Updating character: $data');
  DbCharacter character = dwStore.state.characters.current;
  data.forEach((k, v) {
    if (character.isListProperty(k)) {
      data[k] = List<Map>.from(v.map((i) {
        return i.map;
      }));
    }
    dwStore.dispatch(CharacterActions.updateField(k, data[k]));
  });
  final charDoc = firestore.document('character_bios/$charDocId')
    ..updateData(data is DbBase ? data.map : data);
  final charData = await charDoc.get();

  return charData.data;
}

createCharacter() async {
  SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
  DbCharacter character = DbCharacter();

  DocumentReference charDoc =
      await firestore.collection('character_bios').add(character.map);

  String userDocId = sharedPrefs.getString('userId');
  var userDoc = Firestore.instance.document('users/$userDocId');
  DocumentSnapshot user = await userDoc.get();
  List characters = List.from(user.data['characters']);
  if (characters == null) {
    characters = [];
  }
  characters.add(charDoc);
  userDoc.updateData({'characters': characters});
  dwStore.dispatch(
    CharacterActions.setCurrentChar(charDoc.documentID, character),
  );
}

getOrCreateCharacter(DocumentSnapshot userSnap) {
  if (userSnap.data['characters'].length > 0) {
    print('userSnap data:' + userSnap.data['characters'][0].documentID);
    getAllCharacters(userSnap);
    setCurrentCharacterById(userSnap.data['characters'][0].documentID);
  } else {
    createCharacter();
  }
}
