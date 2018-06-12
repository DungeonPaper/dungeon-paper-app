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

  String get alignment { return get<String>('alignment'); }
  String get displayName { return get<String>('displayName'); }
  String get mainClass { return get<String>('mainClass'); }
  String get photoURL { return get<String>('photoURL'); }
  num get level { return get<num>('level'); }
  num get currentHP { return get<num>('currentHP'); }
  num get currentXP { return get<num>('currentXP'); }
  num get maxHP { return get<num>('maxHP'); }
  num get armor { return get<num>('armor'); }
  num get str { return get<num>('str'); }
  num get dex { return get<num>('dex'); }
  num get con { return get<num>('con'); }
  num get wis { return get<num>('wis'); }
  num get int { return get<num>('int'); }
  num get cha { return get<num>('cha'); }
  List get moves { return get<List>('moves'); }
  List get notes { return get<List>('notes'); }

  DbCharacter([Map map]): super(map);
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
