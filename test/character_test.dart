import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_world_data/dw_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Character', () {
    final wizard = dungeonWorld.classes.firstWhere((k) => k.key == 'wizard');
    final druid = dungeonWorld.classes.firstWhere((k) => k.key == 'druid');
    final immolator =
        dungeonWorld.classes.firstWhere((k) => k.key == 'immolator');

    test('properly uses class values', () {
      final char = Character.fromJson(
        {
          'playerClasses': [wizard.toJSON()],
          'con': 10,
        },
      );
      expect(char.mainClass.key, equals(wizard.key));
      expect(char.currentHP, equals(wizard.baseHP + char.constitution));
      expect(char.maxHP, equals(wizard.baseHP + char.constitution));
    });

    test('properly dumps json', () {
      final char = Character.fromJson(
        {
          'playerClasses': [druid.toJSON()],
          'displayName': 'Goku',
          'str': 20,
          'dex': 10,
          'int': 8,
          'wis': 11,
          'con': 10,
          'cha': 14,
        },
      );
      final json = char.toJson();
      expect(json['alignment'], equals('neutral'));
      expect(json['displayName'], equals('Goku'));
      expect(json['playerClasses'][0]['key'], equals('druid'));
      expect(json['hitDice'], equals('1d6'));
    });

    test('auto max HP get/set', () {
      var char1 = Character.fromJson(
        {
          'playerClasses': [immolator.toJSON()], // base HP 6
          'displayName': 'Goku',
          'str': 20,
          'dex': 10,
          'int': 8,
          'wis': 11,
          'con': 10, // mod = 0
          'cha': 14,
          'settings': {'useDefaultMaxHp': true},
        },
      );
      var char2 = Character.fromJson(
        {
          'playerClasses': [wizard.toJSON()], // base HP 4
          'displayName': 'Harry Potter',
          'str': 20,
          'dex': 10,
          'int': 8,
          'wis': 11,
          'con': 16,
          'cha': 14,
          'settings': {'useDefaultMaxHp': true},
        },
      );
      expect(char1.maxHP, equals(immolator.baseHP + char1.constitution));
      expect(char2.maxHP, equals(wizard.baseHP + char2.constitution));

      char1 = char1.copyWith(constitution: 16); // +1 mod
      char2 = char2.copyWith(constitution: 10); // 0 mod
      expect(char1.maxHP, equals(immolator.baseHP + char1.constitution));
      expect(char2.maxHP, equals(wizard.baseHP + char2.constitution));
    });
  });

  group('Character migrations', () {
    group('Settings migration', () {
      group('useDefaultMaxHP', () {
        test('value different from default', () {
          final char2 = Character.fromJson({
            'settings': {'useDefaultMaxHp': false},
          });

          // ignore: deprecated_member_use_from_same_package
          expect(char2.useDefaultMaxHP, equals(false));
          expect(char2.settings.useDefaultMaxHp, equals(false));
        });

        test('value set and changed but has lingering old data', () {
          final char3 = Character.fromJson(
            {
              'useDefaultMaxHP': true,
              'settings': {
                'useDefaultMaxHp': false,
              }
            },
          );

          // ignore: deprecated_member_use_from_same_package
          expect(char3.useDefaultMaxHP, equals(false));
          expect(char3.settings.useDefaultMaxHp, equals(false));
        });
      });
    });
  });
}
