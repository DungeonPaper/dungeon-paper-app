import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dungeon_paper/db/db.dart';
import 'package:dungeon_paper/db/helpers/character_utils.dart';
import 'package:dungeon_paper/db/models/character_settings.dart';
import 'package:dungeon_paper/db/models/converters/character_settings_converter.dart';
import 'package:dungeon_paper/db/models/converters/default_uuid.dart';
import 'package:dungeon_paper/db/models/converters/dice_converter.dart';
import 'package:dungeon_paper/db/models/converters/document_reference_converter.dart';
import 'package:dungeon_paper/db/models/converters/dw_move_converter.dart';
import 'package:dungeon_paper/db/models/converters/inventory_item_converter.dart';
import 'package:dungeon_paper/db/models/converters/note_converter.dart';
import 'package:dungeon_paper/db/models/converters/player_class_converter.dart';
import 'package:dungeon_paper/db/models/converters/spell_converter.dart';
import 'package:dungeon_paper/db/models/inventory_items.dart';
import 'package:dungeon_paper/db/models/spells.dart';
import 'package:dungeon_paper/src/utils/utils.dart';
import 'package:dungeon_world_data/dice.dart';
import 'package:dungeon_world_data/dw_data.dart';
import 'package:dungeon_world_data/move.dart';
import 'package:dungeon_world_data/player_class.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'notes.dart';

part 'character.freezed.dart';
part 'character.g.dart';

@freezed
abstract class Character with FirebaseMixin, KeyMixin implements _$Character {
  const Character._();

  @With(FirebaseMixin)
  @With(KeyMixin)
  const factory Character({
    @DocumentReferenceConverter() DocumentReference ref,
    @DefaultUuid() String key,
    @JsonKey(name: 'armor', defaultValue: 0) int baseArmor,
    @JsonKey(name: 'str', defaultValue: 8) int strength,
    @JsonKey(name: 'dex', defaultValue: 8) int dexterity,
    @JsonKey(name: 'con', defaultValue: 8) int constitution,
    @JsonKey(name: 'wis', defaultValue: 8) int wisdom,
    @JsonKey(name: 'int', defaultValue: 8) int intelligence,
    @JsonKey(name: 'cha', defaultValue: 0) int charisma,
    @PlayerClassConverter() List<PlayerClass> playerClasses,
    @Default(AlignmentName.neutral) AlignmentName alignment,
    @JsonKey(name: 'maxHP') int customMaxHP,
    @Default('Traveler') String displayName,
    String photoURL,
    @Default(1) int level,
    @Default('') String bio,
    @JsonKey(name: 'currentHP', defaultValue: 100) int customCurrentHP,
    int currentXP,
    @DWMoveConverter() List<Move> moves,
    @NoteConverter() List<Note> notes,
    @SpellConverter() List<DbSpell> spells,
    @InventoryItemConverter() List<InventoryItem> inventory,
    @DiceConverter() @JsonKey(name: 'hitDice') Dice customDamageDice,
    List<String> looks,
    @DWMoveConverter() Move race,
    @Default(0) double coins,
    int order,
    @CharacterSettingsConverter() CharacterSettings settings,
  }) = _Character;

  Character copyWithStat(CharacterStat stat, int value) {
    switch (stat) {
      case CharacterStat.str:
        return copyWith(strength: value);
      case CharacterStat.dex:
        return copyWith(dexterity: value);
      case CharacterStat.con:
        return copyWith(constitution: value);
      case CharacterStat.int:
        return copyWith(intelligence: value);
      case CharacterStat.wis:
        return copyWith(wisdom: value);
      case CharacterStat.cha:
        return copyWith(charisma: value);
    }
    throw FormatException(
        'Stat expected, got ${stat.runtimeType} ($stat)', stat, 0);
  }

  static String getStatUpdateKey(CharacterStat stat) =>
      CHARACTER_STAT_KEYS[stat];

  Dice get damageDice => customDamageDice ?? mainClass?.damage ?? Dice.d6;

  int get currentHP => clamp<int>(customCurrentHP, 0, maxHP).toInt();

  factory Character.fromJson(value, {DocumentReference ref}) =>
      _$CharacterFromJson(value).copyWith(ref: ref);

  PlayerClass get mainClass => playerClasses.first;

  int get maxHP =>
      (settings.useDefaultMaxHp == true ? defaultMaxHP : customMaxHP) ??
      defaultMaxHP;
  int get defaultMaxHP => (mainClass?.baseHP ?? 0) + constitution;
  int get maxLoad => mainClass.load + strMod;

  static String statModifierText(num stat) {
    var mod = modifierFromValue(stat);
    return (mod >= 0 ? '+' : '') + mod.toString();
  }

  num statValueFromKey(CharacterStat key) {
    switch (key) {
      case CharacterStat.int:
        return intelligence;
      case CharacterStat.dex:
        return dexterity;
      case CharacterStat.wis:
        return wisdom;
      case CharacterStat.cha:
        return charisma;
      case CharacterStat.str:
        return strength;
      case CharacterStat.con:
        return constitution;
      default:
        throw Exception('Bad modifier provided: $key');
    }
  }

  num modifierFromKey(CharacterStat key) {
    switch (key) {
      case CharacterStat.int:
        return modifierFromValue(intelligence);
      case CharacterStat.dex:
        return modifierFromValue(dexterity);
      case CharacterStat.wis:
        return modifierFromValue(wisdom);
      case CharacterStat.cha:
        return modifierFromValue(charisma);
      case CharacterStat.str:
        return modifierFromValue(strength);
      case CharacterStat.con:
        return modifierFromValue(constitution);
      default:
        throw Exception('Bad modifier provided: $key');
    }
  }

  num get strMod => modifierFromValue(strength);
  num get dexMod => modifierFromValue(dexterity);
  num get conMod => modifierFromValue(constitution);
  num get wisMod => modifierFromValue(wisdom);
  num get intMod => modifierFromValue(intelligence);
  num get chaMod => modifierFromValue(charisma);

  CharacterKey modifierKey(String modifierName) =>
      CharacterKey.values.firstWhere(
        (v) => enumName(v) == modifierName,
        orElse: () => null,
      );

  static num modifierFromValue(num stat) {
    const modifiers = {1: -3, 4: -2, 6: -1, 9: 0, 13: 1, 16: 2, 18: 3};

    if (modifiers.containsKey(stat)) {
      return modifiers[stat];
    }

    for (var i = stat; i > 0; --i) {
      if (modifiers.containsKey(i)) {
        return modifiers[i];
      }
    }

    return -1;
  }

  num get armor => equippedArmor + baseArmor;

  num get load => inventory.fold(0, (count, item) => count += item.weight);

  num get equippedArmor => inventory.fold(
      0, (count, item) => count += (item.equipped ? item.armor : 0));

  num get equippedDamage => inventory.fold(
      0, (count, item) => count += (item.equipped ? item.damage : 0));
}
