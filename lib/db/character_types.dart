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

const AlignmentNameMap = {
  'good': Alignment.good,
  'lawful': Alignment.lawful,
  'neutral': Alignment.neutral,
  'chaotic': Alignment.chaotic,
  'evil': Alignment.evil,
};

enum Stats {
  str, dex, int, wis, cha, con
}

const StatNameMap = {
  Stats.str: 'Strength',
  Stats.dex: 'Dexterity',
  Stats.int: 'Intelligence',
  Stats.wis: 'Wisdom',
  Stats.cha: 'Charisma',
  Stats.con: 'Constitution',
};
