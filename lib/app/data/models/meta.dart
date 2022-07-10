import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dungeon_paper/app/data/services/repository_service.dart';
import 'package:dungeon_paper/app/model_utils/model_key.dart';
import 'package:dungeon_paper/core/utils/date_utils.dart';
import 'package:dungeon_paper/core/utils/uuid.dart';
import 'package:flutter/material.dart';

class Meta<T> with RepositoryServiceMixin {
  Meta._({
    required this.version,
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
  final String version;
  final MetaSharing? sharing;
  final DateTime? updated;

  T? getLibraryCopy<T extends WithMeta>() => repo.my
      .listByType(T)
      .entries
      .cast<MapEntry<String, T?>>()
      .firstWhere(
        (e) => keyFor(e.value) == sharing?.sourceKey,
        orElse: () => const MapEntry('not_found', null),
      )
      .value;

  bool get isFork => sharing != null;
  bool get isSource => !isFork;

  bool isForkOf(WithMeta parent) => isFork && sharing!.sourceKey == parent.key;
  bool isSourceOf(WithMeta parent) => !isForkOf(parent);
  bool isOutOfSyncWith(WithMeta parent) => isForkOf(parent) && sharing!.sourceVersion != version;

  factory Meta.empty({
    String? version,
    String? createdBy,
    DateTime? created,
    DateTime? updated,
    MetaSharing? sharing,
    T? data,
    String? language,
  }) =>
      Meta._(
        createdBy: createdBy ?? '', // ?? Get.find<UserService>().current.displayName,
        version: version ?? uuid(),
        created: created ?? DateTime.now(),
        updated: updated,
        sharing: sharing,
        data: data,
        language: language,
      );

  Meta<T> copyWith({
    DateTime? created,
    DateTime? updated,
    String? version,
    MetaSharing? sharing,
    String? createdBy,
    T? data,
    String? language,
  }) =>
      Meta._(
        createdBy: createdBy ?? this.createdBy,
        created: created ?? this.created,
        updated: updated ?? this.updated,
        version: version ?? this.version,
        sharing: sharing ?? this.sharing,
        data: data ?? this.data,
        language: language ?? this.language,
      );

  Meta<T> fork({
    required String createdBy,
    required String sourceKey,
    bool force = false,
  }) {
    debugPrint('force: $force, createdBy: $createdBy, sourceKey: $sourceKey');
    return !force && createdBy == this.createdBy
        ? this
        : copyWith(
            version: uuid(),
            createdBy: createdBy,
            created: DateTime.now(),
            sharing: MetaSharing.fork(
              sourceOwner: this.createdBy,
              sourceKey: sourceKey,
              sourceVersion: version,
            ),
          );
  }

  Meta originalOf() => sharing == null
      ? this
      : Meta._(
          createdBy: sharing!.sourceOwner!,
          version: sharing!.sourceVersion,
          created: created,
          updated: updated,
          sharing: sharing,
          data: data,
          language: language,
        );

  factory Meta.fromRawJson(String str) => Meta.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Meta.fromJson(Map<String, dynamic> json, [T Function(dynamic json)? parseData]) => Meta._(
        created: json['created'] != null ? parseDate(json['created']) : DateTime.now(),
        createdBy: json['createdBy'],
        data: json['data'] != null
            ? parseData != null
                ? parseData(json['data'])
                : json['data']
            : null,
        language: json['language'],
        version: json['version']?.toString() ?? uuid(),
        sharing: json['sharing'] != null ? MetaSharing.fromJson(json['sharing']) : null,
        updated: json['updated'] != null ? parseDate(json['updated']) : null,
      );

  factory Meta.tryParse(dynamic meta, {String? owner, T Function(dynamic json)? parseData}) =>
      meta != null
          ? meta is Meta<T>
              ? meta
              : Meta.fromJson(meta, parseData)
          : Meta.empty(createdBy: owner);

  Map<String, dynamic> toJson([dynamic Function(T? data)? dumpData]) => {
        'created': created.toString(),
        'createdBy': createdBy,
        'data': dumpData != null ? dumpData(data) : data,
        'language': language,
        'version': version,
        'sharing': sharing?.toJson(),
        'updated': updated?.toString(),
      };
}

class MetaSharing {
  MetaSharing._({
    this.shared = false,
    this.sourceKey,
    this.sourceOwner,
    required this.sourceVersion,
    this.dirty = false,
  });

  MetaSharing.createSource({
    this.shared = false,
    this.sourceOwner,
  })  : dirty = false,
        sourceVersion = uuid(),
        sourceKey = null;

  MetaSharing.fork({
    this.sourceKey,
    this.sourceOwner,
    required this.sourceVersion,
    this.dirty = false,
  }) : shared = false;

  final bool shared;
  final bool dirty;
  final String? sourceKey;
  final String? sourceOwner;
  final String sourceVersion;

  // bool get isFork => sourceOwner?.isNotEmpty == true && sourceKey?.isNotEmpty == true;
  // bool get isSource => !isFork;

  MetaSharing copyWith({
    bool? shared,
    bool? dirty,
    String? sourceKey,
    String? sourceOwner,
    String? sourceVersion,
  }) =>
      MetaSharing._(
        shared: shared ?? this.shared,
        dirty: dirty ?? this.dirty,
        sourceKey: sourceKey ?? this.sourceKey,
        sourceOwner: sourceOwner ?? this.sourceOwner,
        sourceVersion: sourceVersion ?? this.sourceVersion,
      );

  factory MetaSharing.fromRawJson(String str) => MetaSharing.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MetaSharing.fromJson(Map<String, dynamic> json) => MetaSharing._(
        shared: json['shared'] ?? false,
        dirty: json['dirty'] ?? false,
        sourceKey: json['sourceKey'],
        sourceOwner: json['sourceOwner'],
        sourceVersion: json['sourceVersion']?.toString() ?? uuid(),
      );

  factory MetaSharing.createFork(
    String sourceKey, {
    MetaSharing? meta,
    bool? dirty,
    String? owner,
  }) {
    final _m = meta ?? MetaSharing.fork(sourceVersion: uuid());
    if (owner == _m.sourceOwner) {
      return _m;
    }
    return _m.copyWith(
      sourceKey: _m.sourceKey ?? sourceKey,
      sourceOwner: owner,
      dirty: dirty,
    );
  }

  Map<String, dynamic> toJson() => {
        'shared': shared,
        'dirty': dirty,
        'sourceKey': sourceKey,
        'sourceOwner': sourceOwner,
        'sourceVersion': sourceVersion,
      };
}

abstract class WithMeta<T, M> {
  abstract final Meta<M> meta;
  abstract final String key;
  T copyWith({Meta<M>? meta});
  T copyWithInherited({Meta<M>? meta, String? key}) => copyWith(meta: meta);
}
