import 'package:flutter/material.dart';

import '../utils.dart';

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

enum CharacterKeys {
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

const int MAX_STAT_VALUE = 20;

const Map<CharacterKeys, String> CHARACTER_KEY_DB_MAPPING = {
  CharacterKeys.mainClass: 'mainClass',
  CharacterKeys.useDefaultMaxHP: 'useDefaultMaxHP',
  CharacterKeys.str: 'str',
  CharacterKeys.dex: 'dex',
  CharacterKeys.con: 'con',
  CharacterKeys.wis: 'wis',
  CharacterKeys.int: 'int',
  CharacterKeys.cha: 'cha',
  CharacterKeys.alignment: 'alignment',
  CharacterKeys.displayName: 'displayName',
  CharacterKeys.photoURL: 'photoURL',
  CharacterKeys.level: 'level',
  CharacterKeys.currentHP: 'currentHP',
  CharacterKeys.currentXP: 'currentXP',
  CharacterKeys.maxHP: 'maxHP',
  CharacterKeys.armor: 'armor',
  CharacterKeys.moves: 'moves',
  CharacterKeys.notes: 'notes',
  CharacterKeys.spells: 'spells',
  CharacterKeys.inventory: 'inventory',
  CharacterKeys.docVersion: 'docVersion',
  CharacterKeys.hitDice: 'hitDice',
  CharacterKeys.looks: 'looks',
  CharacterKeys.race: 'race',
  CharacterKeys.coins: 'coins',
};

const List<CharacterKeys> ORDERED_STATS = [
  CharacterKeys.str,
  CharacterKeys.dex,
  CharacterKeys.con,
  CharacterKeys.int,
  CharacterKeys.wis,
  CharacterKeys.cha,
];

const Map<CharacterKeys, String> CHARACTER_KEY_LABELS = {
  CharacterKeys.mainClass: 'Main Class',
  CharacterKeys.alignment: 'Alignment',
  CharacterKeys.displayName: 'Display Name',
  CharacterKeys.photoURL: 'Photo URL',
  CharacterKeys.level: 'Level',
  CharacterKeys.currentHP: 'HP',
  CharacterKeys.currentXP: 'XP',
  CharacterKeys.maxHP: 'Max HP',
  CharacterKeys.armor: 'Armor',
  CharacterKeys.moves: 'Moves',
  CharacterKeys.notes: 'Notes',
  CharacterKeys.spells: 'Spells',
  CharacterKeys.inventory: 'Inventory',
  CharacterKeys.hitDice: 'Damage Dice',
  CharacterKeys.looks: 'Looks',
  CharacterKeys.race: 'Race',
  CharacterKeys.coins: 'Coins',
};

const Map<CharacterKeys, String> CHARACTER_STAT_LABELS = {
  CharacterKeys.str: 'Strength',
  CharacterKeys.dex: 'Dexterity',
  CharacterKeys.con: 'Constitution',
  CharacterKeys.wis: 'Wisdom',
  CharacterKeys.int: 'Intelligence',
  CharacterKeys.cha: 'Charisma',
};

const Map<CharacterKeys, String> CHARACTER_STAT_MODIFIER_LABELS = {
  CharacterKeys.str: 'STR',
  CharacterKeys.dex: 'DEX',
  CharacterKeys.con: 'CON',
  CharacterKeys.wis: 'WIS',
  CharacterKeys.int: 'INT',
  CharacterKeys.cha: 'CHA',
};

const Map<AlignmentName, IconData> ALIGNMENT_ICON_MAP = {
  AlignmentName.good: Icons.mood,
  AlignmentName.lawful: Icons.sentiment_satisfied,
  AlignmentName.neutral: Icons.sentiment_neutral,
  AlignmentName.chaotic: Icons.sentiment_dissatisfied,
  AlignmentName.evil: Icons.mood_bad,
};
