import 'dart:convert';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;

class SessionMark extends dw.SessionMark {
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

  factory SessionMark.fromRawJson(String str) => SessionMark.fromJson(json.decode(str));

  factory SessionMark.fromJson(Map<String, dynamic> json) => SessionMark(
        key: json['key'],
        completed: json['completed'],
        description: json['description'],
        type: dw.SessionMarkType.values.firstWhere((e) => e.name == json['type']),
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
          ? S.current.characterBondsFlagsDialogTitle
          : flags.isNotEmpty
              ? S.current.characterBondsFlagsDialogFlags
              : bonds.isNotEmpty
                  ? S.current.characterBondsFlagsDialogBonds
                  : S.current.characterBondsFlagsDialogTitle;
}
