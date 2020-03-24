import 'package:dungeon_paper/refactor/character.dart';
import 'package:dungeon_world_data/dw_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Character', () {
    //
    //
    test('properly uses class values', () {
      var wizard = dungeonWorld.classes.firstWhere((k) => k.key == 'wizard');
      var char = Character(
        data: {
          'mainClass': 'wizard',
          'con': 10,
        },
      );
      expect(char.mainClass, equals(wizard));
      expect(char.currentHP, equals(4));
      expect(char.maxHP, equals(wizard.baseHP + char.conMod));
    });
    test('properly dumps json', () {
      var char = Character(
        data: {
          'mainClass': 'druid',
          'displayName': 'Goku',
          'str': 20,
          'dex': 10,
          'int': 8,
          'wis': 11,
          'con': 10,
          'cha': 14,
        },
      );
      var json = char.toJSON();
      expect(json['alignment'], equals('neutral'));
      expect(json['displayName'], equals('Goku'));
      expect(json['mainClass'], equals('druid'));
      expect(json['hitDice'], equals('1d6'));
    });

    test('auto max HP get/set', () {
      var char1 = Character(
        data: {
          'mainClass': 'immolator', // base HP 6
          'displayName': 'Goku',
          'str': 20,
          'dex': 10,
          'int': 8,
          'wis': 11,
          'con': 10, // mod = 0
          'cha': 14,
          'useDefaultMaxHP': true,
        },
      );
      var char2 = Character(
        data: {
          'mainClass': 'wizard', // base HP 4
          'displayName': 'Harry Potter',
          'str': 20,
          'dex': 10,
          'int': 8,
          'wis': 11,
          'con': 16,
          'cha': 14,
          'useDefaultMaxHP': true,
        },
      );
      var immolator =
          dungeonWorld.classes.firstWhere((el) => el.key == 'immolator');
      var wizard = dungeonWorld.classes.firstWhere((el) => el.key == 'wizard');
      expect(
          char1.maxHP, equals(immolator.baseHP + Character.statModifier(10)));
      expect(char2.maxHP, equals(6));
      char1.con = 16; // +1 mod
      char2.con = 10; // 0 mod
      expect(
          char1.maxHP, equals(immolator.baseHP + Character.statModifier(16)));
      expect(char2.maxHP, equals(wizard.baseHP + Character.statModifier(10)));
    });
  });
}
