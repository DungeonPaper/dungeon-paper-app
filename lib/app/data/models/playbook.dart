import 'package:dungeon_paper/core/utils/icon_utils.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:dungeon_paper/app/data/models/meta.dart';
import 'package:flutter/material.dart';

@immutable
class Playbook with WithIcon implements WithMeta {
  @override
  final Meta meta;

  @override
  final String key;
  final String name;
  final String description;

  final List<dw.EntityReference> classes;
  final List<dw.EntityReference> moves;
  final List<dw.EntityReference> spells;
  final List<dw.EntityReference> races;
  final List<dw.EntityReference> items;
  final List<dw.EntityReference> notes;

  const Playbook({
    required this.meta,
    required this.key,
    required this.name,
    required this.description,
    required this.classes,
    required this.moves,
    required this.spells,
    required this.races,
    required this.items,
    required this.notes,
  });

  factory Playbook.fromJson(Map<String, dynamic> json) => Playbook(
        meta: Meta.tryParse(json['_meta']),
        key: json['key'],
        name: json['name'],
        description: json['description'],
        classes: List<dw.EntityReference>.from(
          json['classes'].map((x) => dw.EntityReference.fromJson(x)),
        ),
        moves: List<dw.EntityReference>.from(
          json['moves'].map((x) => dw.EntityReference.fromJson(x)),
        ),
        spells: List<dw.EntityReference>.from(
          json['spells'].map((x) => dw.EntityReference.fromJson(x)),
        ),
        races: List<dw.EntityReference>.from(
          json['races'].map((x) => dw.EntityReference.fromJson(x)),
        ),
        items: List<dw.EntityReference>.from(
          json['items'].map((x) => dw.EntityReference.fromJson(x)),
        ),
        notes: List<dw.EntityReference>.from(
          json['notes'].map((x) => dw.EntityReference.fromJson(x)),
        ),
      );

  @override
  toJson() => {
        '_meta': meta.toJson(),
        'key': key,
        'name': name,
        'description': description,
        'classes': List<dynamic>.from(classes.map((x) => x.toJson())),
        'moves': List<dynamic>.from(moves.map((x) => x.toJson())),
        'spells': List<dynamic>.from(spells.map((x) => x.toJson())),
        'races': List<dynamic>.from(races.map((x) => x.toJson())),
        'items': List<dynamic>.from(items.map((x) => x.toJson())),
        'notes': List<dynamic>.from(notes.map((x) => x.toJson())),
      };

  @override
  Playbook copyWith({
    Meta? meta,
    String? key,
    String? name,
    String? description,
    List<dw.EntityReference>? classes,
    List<dw.EntityReference>? moves,
    List<dw.EntityReference>? spells,
    List<dw.EntityReference>? races,
    List<dw.EntityReference>? items,
    List<dw.EntityReference>? notes,
  }) =>
      Playbook(
        meta: meta ?? this.meta,
        key: key ?? this.key,
        name: name ?? this.name,
        description: description ?? this.description,
        classes: classes ?? this.classes,
        moves: moves ?? this.moves,
        spells: spells ?? this.spells,
        races: races ?? this.races,
        items: items ?? this.items,
        notes: notes ?? this.notes,
      );

  @override
  copyWithInherited({
    Meta? meta,
    String? key,
    String? name,
    String? description,
    List<dw.EntityReference>? classes,
    List<dw.EntityReference>? moves,
    List<dw.EntityReference>? spells,
    List<dw.EntityReference>? races,
    List<dw.EntityReference>? items,
    List<dw.EntityReference>? notes,
  }) =>
      copyWith(
        meta: meta,
        key: key,
        name: name,
        description: description,
        classes: classes,
        moves: moves,
        spells: spells,
        races: races,
        items: items,
        notes: notes,
      );

  @override
  String get displayName => name;

  @override
  IconData get icon => Icons.collections_bookmark;

  @override
  String get storageKey => 'Playbooks';

  @override
  dw.EntityReference get reference => Meta.referenceFor(this);
}
