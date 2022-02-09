// To parse this JSON data, do
//
//     final character = characterFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'alignment.dart';
import 'dice.dart';
import 'gear_choice.dart';
import 'meta.dart';

class CharacterClass {
  CharacterClass({
    required this.meta,
    required this.name,
    required this.key,
    required this.description,
    required this.damageDice,
    required this.load,
    required this.alignments,
    required this.bonds,
    required this.gearChoices,
  });

  final Meta meta;
  final String name;
  final String key;
  final String description;
  final Dice damageDice;
  final int load;
  final AlignmentValues alignments;
  final List<String> bonds;
  final List<GearChoice> gearChoices;

  CharacterClass copyWith({
    Meta? meta,
    String? name,
    String? key,
    String? description,
    Dice? damageDice,
    int? load,
    AlignmentValues? alignments,
    List<String>? bonds,
    List<GearChoice>? gearChoices,
  }) =>
      CharacterClass(
        meta: meta ?? this.meta,
        name: name ?? this.name,
        key: key ?? this.key,
        description: description ?? this.description,
        damageDice: damageDice ?? this.damageDice,
        load: load ?? this.load,
        alignments: alignments ?? this.alignments,
        bonds: bonds ?? this.bonds,
        gearChoices: gearChoices ?? this.gearChoices,
      );

  factory CharacterClass.fromRawJson(String str) =>
      CharacterClass.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CharacterClass.fromJson(Map<String, dynamic> json) => CharacterClass(
        meta: Meta.fromJson(json["_meta"]),
        name: json["name"],
        key: json["key"],
        description: json["description"],
        damageDice: Dice.fromJson(json["damageDice"]),
        load: json["load"],
        alignments: AlignmentValues.fromJson(json["alignments"]),
        bonds: List<String>.from(json["bonds"].map((x) => x)),
        gearChoices: List<GearChoice>.from(
            json["gearChoices"].map((x) => GearChoice.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_meta": meta.toJson(),
        "name": name,
        "key": key,
        "description": description,
        "damageDice": damageDice.toJson(),
        "load": load,
        "alignments": alignments.toJson(),
        "bonds": List<dynamic>.from(bonds.map((x) => x)),
        "gearChoices": List<dynamic>.from(gearChoices.map((x) => x.toJson())),
      };
}
