import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dungeon_paper/redux/stores.dart';
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

  String get alignment => get<String>('alignment');
  String get displayName => get<String>('displayName');
  String get mainClass => get<String>('mainClass');
  String get photoURL => get<String>('photoURL');
  num get level => get<num>('level');
  num get currentHP => get<num>('currentHP');
  num get currentXP => get<num>('currentXP');
  num get maxHP => get<num>('maxHP');
  num get armor => get<num>('armor');
  num get str => get<num>('str');
  num get dex => get<num>('dex');
  num get con => get<num>('con');
  num get wis => get<num>('wis');
  num get int => get<num>('int');
  num get cha => get<num>('cha');
  List get moves => get<List>('moves');
  List get notes => get<List>('notes');

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

enum ClassNames {
  bard,
  cleric,
  druid,
  fighter,
  paladin,
  ranger,
  thief,
  wizard,
  immolator,
}

const ClassNamesMap = {
  ClassNames.bard: 'bard',
  ClassNames.cleric: 'cleric',
  ClassNames.druid: 'druid',
  ClassNames.fighter: 'fighter',
  ClassNames.paladin: 'paladin',
  ClassNames.ranger: 'ranger',
  ClassNames.thief: 'thief',
  ClassNames.wizard: 'wizard',
  ClassNames.immolator: 'immolator',
};

enum Alignment {
  good,
  lawful,
  neutral,
  chaotic,
  evil,
}

const AlignmentMap = {
  Alignment.good: 'good',
  Alignment.lawful: 'lawful',
  Alignment.neutral: 'neutral',
  Alignment.chaotic: 'chaotic',
  Alignment.evil: 'evil',
};

Future<DbCharacter> setCurrentCharacterById(String documentId) async {
  DocumentSnapshot character =
      await Firestore.instance.document('character_bios/$documentId').get();
  DbCharacter dbCharacter = DbCharacter(character.data);

  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('characterId', character.documentID);

  characterStore.dispatch(new Action(
      type: CharacterActions.Change,
      payload: {'id': character.documentID, 'data': dbCharacter}));

  return dbCharacter;
}

unsetCurrentCharacter() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('characterId');
  characterStore.dispatch(Action(
    type: CharacterActions.RemoveAll,
  ));
}
