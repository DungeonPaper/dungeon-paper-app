import 'package:dungeon_paper/src/utils/utils.dart';
import 'package:flutter/material.dart';

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

enum AlignmentName {
  good,
  lawful,
  neutral,
  chaotic,
  evil,
}

const AlignmentMap = {
  AlignmentName.good: 'good',
  AlignmentName.lawful: 'lawful',
  AlignmentName.neutral: 'neutral',
  AlignmentName.chaotic: 'chaotic',
  AlignmentName.evil: 'evil',
};

// ignore: non_constant_identifier_names
final Map<String, AlignmentName> AlignmentNameMap = invertMap(AlignmentMap);

enum Stats { str, dex, int, wis, cha, con }

const StatNameMap = {
  Stats.str: 'Strength',
  Stats.dex: 'Dexterity',
  Stats.int: 'Intelligence',
  Stats.wis: 'Wisdom',
  Stats.cha: 'Charisma',
  Stats.con: 'Constitution',
};

enum CharacterKey {
  alignment,
  displayName,
  mainClass,
  photoURL,
  level,
  currentHP,
  currentXP,
  maxHP,
  useDefaultMaxHP,
  armor,
  str,
  dex,
  con,
  wis,
  int,
  cha,
  moves,
  notes,
  spells,
  inventory,
  docVersion,
  hitDice,
  looks,
  race,
  coins,
  lastUpdateDt,
}

const int MAX_STAT_VALUE = 18;

const List<CharacterKey> ORDERED_STATS = [
  CharacterKey.str,
  CharacterKey.dex,
  CharacterKey.con,
  CharacterKey.int,
  CharacterKey.wis,
  CharacterKey.cha,
];

const Map<CharacterKey, String> CHARACTER_STAT_LABELS = {
  CharacterKey.str: 'Strength',
  CharacterKey.dex: 'Dexterity',
  CharacterKey.con: 'Constitution',
  CharacterKey.wis: 'Wisdom',
  CharacterKey.int: 'Intelligence',
  CharacterKey.cha: 'Charisma',
};

const Map<CharacterKey, String> CHARACTER_STAT_MODIFIER_LABELS = {
  CharacterKey.str: 'STR',
  CharacterKey.dex: 'DEX',
  CharacterKey.con: 'CON',
  CharacterKey.wis: 'WIS',
  CharacterKey.int: 'INT',
  CharacterKey.cha: 'CHA',
};

const Map<AlignmentName, IconData> ALIGNMENT_ICON_MAP = {
  AlignmentName.good: Icons.mood,
  AlignmentName.lawful: Icons.sentiment_satisfied,
  AlignmentName.neutral: Icons.sentiment_neutral,
  AlignmentName.chaotic: Icons.sentiment_dissatisfied,
  AlignmentName.evil: Icons.mood_bad,
};
