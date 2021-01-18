import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dungeon_paper/db/helpers/character_utils.dart';
import 'package:dungeon_paper/db/models/character/character_settings.dart';
import 'package:dungeon_paper/db/models/converters/character_settings_converter.dart';
import 'package:dungeon_paper/db/models/converters/dice_converter.dart';
import 'package:dungeon_paper/db/models/converters/document_reference_converter.dart';
import 'package:dungeon_paper/db/models/converters/dw_alignment_converter.dart';
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

import '../notes.dart';

part 'character_new.freezed.dart';
part 'character_new.g.dart';

@freezed
abstract class CharacterNew implements _$CharacterNew {
  const CharacterNew._();

  const factory CharacterNew({
    @DocumentReferenceConverter() DocumentReference ref,
    @JsonKey(name: 'armor', defaultValue: 0) int baseArmor,
    @JsonKey(name: 'str', defaultValue: 8) int strength,
    @JsonKey(name: 'dex', defaultValue: 8) int dexterity,
    @JsonKey(name: 'con', defaultValue: 8) int constitution,
    @JsonKey(name: 'wis', defaultValue: 8) int wisdom,
    @JsonKey(name: 'int', defaultValue: 8) int intelligence,
    @JsonKey(name: 'cha', defaultValue: 0) int charisma,
    @PlayerClassConverter() List<PlayerClass> playerClasses,
    AlignmentName alignment,
    int maxHP,
    @Default('Traveler') String displayName,
    String photoURL,
    @Default(1) int level,
    @Default('') String bio,
    int currentHP,
    int currentXP,
    @DWMoveConverter() List<Move> moves,
    @NoteConverter() List<Note> notes,
    @SpellConverter() List<DbSpell> spells,
    @InventoryItemConverter() List<InventoryItem> inventory,
    @DiceConverter() Dice hitDice,
    List<String> looks,
    @DWMoveConverter() Move race,
    @Default(0) double coins,
    int order,
    @CharacterSettingsConverter() CharacterSettings settings,
  }) = _CharacterNew;

  factory CharacterNew.fromJson(value, {DocumentReference ref}) =>
      _$CharacterNewFromJson(value).copyWith(ref: ref);

  num statValueFromKey(CharacterKey key) {
    final _key = enumName(key).toLowerCase();
    switch (_key) {
      case 'int':
        return intelligence;
      case 'dex':
        return dexterity;
      case 'wis':
        return wisdom;
      case 'cha':
        return charisma;
      case 'str':
        return strength;
      case 'con':
        return constitution;
      default:
        throw Exception('Bad modifier provided: $key');
    }
  }

  num modifierFromKey(CharacterKey key) {
    final _key = enumName(key).toLowerCase();
    switch (_key) {
      case 'int':
        return modifierFromValue(intelligence);
      case 'dex':
        return modifierFromValue(dexterity);
      case 'wis':
        return modifierFromValue(wisdom);
      case 'cha':
        return modifierFromValue(charisma);
      case 'str':
        return modifierFromValue(strength);
      case 'con':
        return modifierFromValue(constitution);
      default:
        throw Exception('Bad modifier provided: $key');
    }
  }

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
