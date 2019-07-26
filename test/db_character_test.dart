import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_world_data/dw_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DbCharacter', () {
    test('base', () {
      var char = DbCharacter({
        'mainClass': 'wizard',
        'con': 10,
      });
      expect(char.mainClass, equals(dungeonWorld.classes['wizard']));
      expect(char.currentHP, equals(4));
      expect(char.maxHP,
          equals(dungeonWorld.classes['wizard'].baseHP + char.conMod));
    });
    test('json', () {
      var char = DbCharacter({
        'mainClass': 'druid',
        'displayName': 'Goku',
        'str': 20,
        'dex': 10,
        'int': 8,
        'wis': 11,
        'con': 10,
        'cha': 14,
      });
      var json = char.toJSON();
      expect(json['alignment'], equals('neutral'));
      expect(json['displayName'], equals('Goku'));
      expect(json['mainClass'], equals('druid'));
      expect(json['hitDice'], equals('1d6'));
    });
  });
}
