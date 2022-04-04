import 'dart:convert';

import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/data/services/user_service.dart';
import 'package:get/instance_manager.dart';

class Meta<T> {
  Meta({
    DateTime? created,
    this.updated,
    required this.schemaVersion,
    this.sharing,
    this.data,
    required this.owner,
  }) : created = created ?? DateTime.now();

  late final DateTime created;
  final DateTime? updated;
  final int schemaVersion;
  final MetaSharing? sharing;
  final String owner;
  final T? data;

  factory Meta.version(
    int schemaVersion, {
    String? owner,
    DateTime? created,
    DateTime? updated,
    MetaSharing? sharing,
    T? data,
  }) =>
      Meta(
        owner: owner ?? Get.find<UserService>().current.displayName,
        schemaVersion: schemaVersion,
        created: created ?? DateTime.now(),
        updated: updated,
        sharing: sharing,
        data: data,
      );

  Meta<T> copyWith({
    DateTime? created,
    DateTime? updated,
    int? schemaVersion,
    MetaSharing? sharing,
    String? owner,
    T? data,
  }) =>
      Meta(
        owner: owner ?? this.owner,
        created: created ?? this.created,
        updated: updated ?? this.updated,
        schemaVersion: schemaVersion ?? this.schemaVersion,
        sharing: sharing ?? this.sharing,
        data: data ?? this.data,
      );

  factory Meta.fromRawJson(String str) => Meta.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Meta.fromJson(Map<String, dynamic> json, [T Function(dynamic json)? parseData]) => Meta(
        owner: json['owner'] ?? 'Guest',
        created: json['created'] != null ? DateTime.parse(json['created']) : DateTime.now(),
        updated: json['updated'] != null ? DateTime.parse(json['updated']) : null,
        schemaVersion: json['schemaVersion'] ?? 1,
        sharing: json['sharing'] != null ? MetaSharing.fromJson(json['sharing']) : null,
        data: json['data'] != null
            ? parseData != null
                ? parseData(json['data'])
                : json['data']
            : null,
      );

  factory Meta.tryParse(dynamic meta, {String? owner, T Function(dynamic json)? parseData}) =>
      meta != null
          ? meta is Meta<T>
              ? meta
              : Meta.fromJson(meta, parseData)
          : Meta.version(1, owner: owner);

  Map<String, dynamic> toJson([dynamic Function(T? data)? dumpData]) => {
        'created': created.toString(),
        'updated': updated?.toString(),
        'schemaVersion': schemaVersion,
        'sharing': sharing?.toJson(),
        'data': dumpData != null ? dumpData(data) : data,
      };
}

class MetaSharing {
  MetaSharing._({
    this.shared = false,
    this.sourceKey,
    this.sourceOwner,
    this.dirty = false,
  });

  MetaSharing.source({
    this.shared = false,
    this.sourceOwner,
  })  : dirty = false,
        sourceKey = null;

  MetaSharing.fork({
    this.sourceKey,
    this.sourceOwner,
    this.dirty = false,
  }) : shared = false;

  final bool shared;
  final bool dirty;
  final String? sourceKey;
  final String? sourceOwner;

  bool get isSource => sourceOwner?.isNotEmpty == true && sourceKey?.isNotEmpty == true;
  bool get isFork => !isSource;

  MetaSharing copyWith({
    bool? shared,
    bool? dirty,
    String? sourceKey,
    String? sourceOwner,
  }) =>
      MetaSharing._(
        shared: shared ?? this.shared,
        dirty: dirty ?? this.dirty,
        sourceKey: sourceKey ?? this.sourceKey,
        sourceOwner: sourceOwner ?? this.sourceOwner,
      );

  factory MetaSharing.fromRawJson(String str) => MetaSharing.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MetaSharing.fromJson(Map<String, dynamic> json) {
    return MetaSharing._(
      shared: json['shared'] ?? false,
      dirty: json['dirty'] ?? false,
      sourceKey: json['sourceKey'],
      sourceOwner: json['sourceOwner'],
    );
  }

  factory MetaSharing.createFork(
    String sourceKey, {
    MetaSharing? meta,
    bool? dirty,
    String? owner,
  }) {
    final _m = meta ?? MetaSharing.fork();
    return _m.copyWith(
      sourceKey: _m.sourceKey ?? sourceKey,
      sourceOwner: owner,
      dirty: dirty,
    );
  }

  Map<String, dynamic> toJson() => {
        'shared': shared,
        'outOfSync': dirty,
        'originalKey': sourceKey,
        'createdBy': sourceOwner,
      };
}

abstract class WithMeta {
  abstract final Meta meta;
}
