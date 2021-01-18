import 'package:dungeon_world_data/dice.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class DiceConverter implements JsonConverter<Dice, dynamic> {
  const DiceConverter();

  @override
  Dice fromJson(dynamic json) {
    if (json == null) {
      return null;
    }

    if (json is Dice) {
      return json;
    }

    if (json is String) {
      return Dice.parse(json);
    }

    throw Exception(
        'Could not determine the constructor for mapping from JSON');
  }

  @override
  dynamic toJson(Dice data) => data;
}
