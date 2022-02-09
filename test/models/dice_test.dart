import 'package:dungeon_paper/data/models/dice.dart';
import 'package:test/test.dart';

void main() {
  group('Dice', () {
    group("Parse JSON", () {
      test("No modifier", () {
        var str = "1d6";
        var dice = Dice.fromJson(str);
        expect(dice.amount, equals(1));
        expect(dice.sides, equals(6));
        expect(dice.modifier, equals(null));
      });
      test("With positive modifier", () {
        var str = "3d8+3";
        var dice = Dice.fromJson(str);
        expect(dice.amount, equals(3));
        expect(dice.sides, equals(8));
        expect(dice.modifier, equals(3));
      });
      test("With negative modifier", () {
        var str = "2d20-4";
        var dice = Dice.fromJson(str);
        expect(dice.amount, equals(2));
        expect(dice.sides, equals(20));
        expect(dice.modifier, equals(-4));
      });
    });

    group("Dump JSON", () {
      test("No modifier", () {
        var str = "1d6";
        var dice = Dice(amount: 1, sides: 6);
        expect(dice.toJson(), equals(str));
      });
      test("With positive modifier", () {
        var str = "3d8+3";
        var dice = Dice(amount: 3, sides: 8, modifier: 3);
        expect(dice.toJson(), equals(str));
      });
      test("With negative modifier", () {
        var str = "2d20-4";
        var dice = Dice(amount: 2, sides: 20, modifier: -4);
        expect(dice.toJson(), equals(str));
      });
    });
  });
}
