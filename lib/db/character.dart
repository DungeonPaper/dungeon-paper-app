import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dungeon_paper/db/character_types.dart';
import 'package:dungeon_paper/db/user.dart';
import 'package:dungeon_paper/redux/actions/character_actions.dart';
import 'package:dungeon_paper/redux/stores/character_store.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'base.dart';

class DbCharacter extends DbBase {
  var defaultData = {
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
  };

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
  List get notes => get('notes');

  DbCharacter([Map map]) : super(map);

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

  characterStore.dispatch(
    CharacterActions.updateChar(character.documentID, dbCharacter),
  );

  return dbCharacter;
}

unsetCurrentCharacter() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('characterId');
  characterStore.dispatch(CharacterActions.remove());
}

updateCharacter(Map<String, dynamic> data) async {
  Firestore firestore = Firestore.instance;
  final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
  final String charDocId = sharedPrefs.getString('characterId');
  final charDoc = firestore.document('character_bios/$charDocId')
    ..updateData(data);
  final charData = await charDoc.get();

  characterStore.dispatch(
    CharacterActions.updateChar(charDoc.documentID, DbCharacter(charData.data)),
  );
}

createCharacter() async {
  SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
  DbCharacter character = DbCharacter({});

  DocumentReference charDoc =
      await firestore.collection('character_bios').add(character.map);

  String userDocId = sharedPrefs.getString('userId');

  firestore.document('user/$userDocId').updateData({
    'characters': [charDoc]
  });

  characterStore.dispatch(
    CharacterActions.updateChar(charDoc.documentID, character),
  );
}
