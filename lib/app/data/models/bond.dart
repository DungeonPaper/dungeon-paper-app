import 'dart:convert';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;

class Bond extends dw.Bond {
  Bond({
    required String key,
    required String description,
    required bool completed,
  }) : super(key: key, description: description, completed: completed);

  factory Bond.fromRawJson(String str) => Bond.fromJson(json.decode(str));

  factory Bond.fromJson(Map<String, dynamic> json) => Bond(
        key: json['key'],
        completed: json['completed'],
        description: json['description'],
      );
}
