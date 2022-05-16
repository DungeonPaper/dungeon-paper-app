import 'dart:convert';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;

class SessionMark extends dw.SessionMark {
  SessionMark({
    required super.key,
    required super.description,
    required super.completed,
    required super.type,
  });

  factory SessionMark.fromRawJson(String str) => SessionMark.fromJson(json.decode(str));

  factory SessionMark.fromJson(Map<String, dynamic> json) => SessionMark(
        key: json['key'],
        completed: json['completed'],
        description: json['description'],
        type: json['type'],
      );

  SessionMark copyWithInherited({
    String? key,
    String? description,
    bool? completed,
    dw.SessionMarkType? type,
  }) =>
      SessionMark(
        key: key ?? this.key,
        description: description ?? this.description,
        completed: completed ?? this.completed,
        type: type ?? this.type,
      );
}
