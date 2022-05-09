import 'dart:convert';

import 'package:dungeon_paper/app/data/services/user_service.dart';
import 'package:get/instance_manager.dart';

class Meta<T> {
  Meta._({
    required this.schemaVersion,
    DateTime? created,
    this.updated,
    this.sharing,
    this.data,
    this.language,
    required this.createdBy,
  }) : created = created ?? DateTime.now();

  final String createdBy;
  late final DateTime created;
  final T? data;
  final String? language;
  final int schemaVersion;
  final MetaSharing? sharing;
  final DateTime? updated;

  factory Meta.version(
    int schemaVersion, {
    String? createdBy,
    DateTime? created,
    DateTime? updated,
    MetaSharing? sharing,
    T? data,
    String? language,
  }) =>
      Meta._(
        createdBy: createdBy ?? Get.find<UserService>().current.displayName,
        schemaVersion: schemaVersion,
        created: created ?? DateTime.now(),
        updated: updated,
        sharing: sharing,
        data: data,
        language: language,
      );

  Meta<T> copyWith({
    DateTime? created,
    DateTime? updated,
    int? schemaVersion,
    MetaSharing? sharing,
    String? createdBy,
    T? data,
    String? language,
  }) =>
      Meta._(
        createdBy: createdBy ?? this.createdBy,
        created: created ?? this.created,
        updated: updated ?? this.updated,
        schemaVersion: schemaVersion ?? this.schemaVersion,
        sharing: sharing ?? this.sharing,
        data: data ?? this.data,
        language: language ?? this.language,
      );

  Meta<T> fork({
    required String createdBy,
    required String sourceKey,
  }) =>
      copyWith(
        createdBy: createdBy,
        created: DateTime.now(),
        sharing: MetaSharing.fork(
          sourceOwner: this.createdBy,
          sourceKey: sourceKey,
        ),
      );

  factory Meta.fromRawJson(String str) => Meta.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Meta.fromJson(Map<String, dynamic> json, [T Function(dynamic json)? parseData]) => Meta._(
        created: json['created'] != null ? DateTime.parse(json['created']) : DateTime.now(),
        createdBy: json['createdBy'] ?? 'Guest',
        data: json['data'] != null
            ? parseData != null
                ? parseData(json['data'])
                : json['data']
            : null,
        language: json['language'],
        schemaVersion: json['schemaVersion'] ?? 1,
        sharing: json['sharing'] != null ? MetaSharing.fromJson(json['sharing']) : null,
        updated: json['updated'] != null ? DateTime.parse(json['updated']) : null,
      );

  factory Meta.tryParse(dynamic meta, {String? owner, T Function(dynamic json)? parseData}) =>
      meta != null
          ? meta is Meta<T>
              ? meta
              : Meta.fromJson(meta, parseData)
          : Meta.version(1, createdBy: owner);

  Map<String, dynamic> toJson([dynamic Function(T? data)? dumpData]) => {
        'created': created.toString(),
        'createdBy': createdBy,
        'data': dumpData != null ? dumpData(data) : data,
        'language': language,
        'schemaVersion': schemaVersion,
        'sharing': sharing?.toJson(),
        'updated': updated?.toString(),
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

  bool get isFork => sourceOwner?.isNotEmpty == true && sourceKey?.isNotEmpty == true;
  bool get isSource => !isFork;

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
