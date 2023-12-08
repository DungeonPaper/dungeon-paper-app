import 'dart:convert';

import 'package:dungeon_paper/i18n.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;

import 'meta.dart';

class SessionMark extends dw.SessionMark implements WithKey {
  SessionMark({
    required super.key,
    required super.description,
    required super.completed,
    required super.type,
  });

  SessionMark.bond({
    required super.key,
    required super.description,
    required super.completed,
  }) : super(type: dw.SessionMarkType.bond);

  SessionMark.flag({
    required super.key,
    required super.description,
    required super.completed,
  }) : super(type: dw.SessionMarkType.flag);

  SessionMark.endOfSession({
    required super.key,
    required super.description,
    required super.completed,
  }) : super(type: dw.SessionMarkType.endOfSession);

  factory SessionMark.fromRawJson(String str) =>
      SessionMark.fromJson(json.decode(str));

  factory SessionMark.fromJson(Map<String, dynamic> json) => SessionMark(
        key: json['key'],
        completed: json['completed'],
        description: json['description'],
        type:
            dw.SessionMarkType.values.firstWhere((e) => e.name == json['type']),
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

  static String categoryTitle({
    required List<SessionMark> bonds,
    required List<SessionMark> flags,
  }) =>
      bonds.isNotEmpty && flags.isNotEmpty
          ? tr.sessionMarks.title
          : flags.isNotEmpty
              ? tr.sessionMarks.flags
              : bonds.isNotEmpty
                  ? tr.sessionMarks.bonds
                  : tr.sessionMarks.title;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SessionMark &&
          runtimeType == other.runtimeType &&
          key == other.key &&
          description == other.description &&
          completed == other.completed &&
          type == other.type;

  @override
  int get hashCode => Object.hashAll([key, description, completed, type]);

  @override
  String get debugProperties =>
      'key: $key, description: $description, completed: $completed, type: $type';

  @override
  String toString() => 'SessionMark($debugProperties)';
}
