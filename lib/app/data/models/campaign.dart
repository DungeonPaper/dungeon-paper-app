import 'package:dungeon_paper/app/data/models/meta.dart';
import 'package:dungeon_paper/core/utils/icon_utils.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:flutter/material.dart';

class Campaign with WithIcon implements WithMeta {
  @override
  final Meta meta;
  @override
  final String key;
  final String name;
  final String description;

  final List<dw.EntityReference> owners;
  final List<dw.EntityReference> moderators;
  final List<dw.EntityReference> participants;

  Campaign({
    required this.meta,
    required this.key,
    required this.name,
    required this.description,
    required this.owners,
    required this.moderators,
    required this.participants,
  });

  @override
  Map<String, dynamic> toJson() => {
        '_meta': meta.toJson(),
        'key': key,
        'name': name,
        'description': description,
        'owners': List<dynamic>.from(owners.map((x) => x.toJson())),
        'moderators': List<dynamic>.from(moderators.map((x) => x.toJson())),
        'participants': List<dynamic>.from(participants.map((x) => x.toJson())),
      };

  factory Campaign.fromJson(Map<String, dynamic> json) => Campaign(
        meta: Meta.tryParse(json['_meta']),
        key: json['key'],
        name: json['name'],
        description: json['description'],
        owners: List<dw.EntityReference>.from(
            json['owners'].map((x) => dw.EntityReference.fromJson(x))),
        moderators: List<dw.EntityReference>.from(
            json['moderators'].map((x) => dw.EntityReference.fromJson(x))),
        participants: List<dw.EntityReference>.from(
            json['participants'].map((x) => dw.EntityReference.fromJson(x))),
      );

  @override
  Campaign copyWith({
    Meta? meta,
    String? key,
    String? name,
    String? description,
    List<dw.EntityReference>? owners,
    List<dw.EntityReference>? moderators,
    List<dw.EntityReference>? participants,
  }) =>
      Campaign(
        meta: meta ?? this.meta,
        key: key ?? this.key,
        name: name ?? this.name,
        description: description ?? this.description,
        owners: owners ?? this.owners,
        moderators: moderators ?? this.moderators,
        participants: participants ?? this.participants,
      );

  @override
  Campaign copyWithInherited({
    Meta? meta,
    String? key,
    String? name,
    String? description,
    List<dw.EntityReference>? owners,
    List<dw.EntityReference>? moderators,
    List<dw.EntityReference>? participants,
  }) =>
      copyWith(
        meta: meta,
        key: key,
        name: name,
        description: description,
        owners: owners,
        moderators: moderators,
        participants: participants,
      );

  @override
  String get displayName => name;

  @override
  IconData get icon => genericIcon;

  static IconData get genericIcon => Icons.groups;

  @override
  String get storageKey => 'Campaigns';

  @override
  dw.EntityReference get reference => Meta.referenceFor(this);
}
