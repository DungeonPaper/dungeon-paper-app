import 'dart:convert';

class Meta<T> {
  Meta({
    DateTime? created,
    this.updated,
    required this.schemaVersion,
    this.sharing,
    this.data,
  }) : created = created ?? DateTime.now();

  late final DateTime created;
  final DateTime? updated;
  final int schemaVersion;
  final MetaSharing? sharing;
  final T? data;

  factory Meta.version(
    int schemaVersion, {
    DateTime? created,
    DateTime? updated,
    MetaSharing? sharing,
    T? data,
  }) =>
      Meta(
        schemaVersion: schemaVersion,
        created: created,
        updated: updated,
        sharing: sharing,
        data: data,
      );

  Meta<T> copyWith({
    DateTime? created,
    DateTime? updated,
    int? schemaVersion,
    MetaSharing? sharing,
    T? data,
  }) =>
      Meta(
        created: created ?? this.created,
        updated: updated ?? this.updated,
        schemaVersion: schemaVersion ?? this.schemaVersion,
        sharing: sharing ?? this.sharing,
        data: data ?? this.data,
      );

  factory Meta.fromRawJson(String str) => Meta.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Meta.fromJson(Map<String, dynamic> json, [T Function(dynamic json)? parseData]) => Meta(
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

  factory Meta.tryParse(dynamic meta, [T Function(dynamic json)? parseData]) => meta != null
      ? meta is Meta<T>
          ? meta
          : Meta.fromJson(meta, parseData)
      : Meta.version(1);

  Map<String, dynamic> toJson([dynamic Function(T? data)? dumpData]) => {
        'created': created.toString(),
        'updated': updated?.toString(),
        'schemaVersion': schemaVersion,
        'sharing': sharing?.toJson(),
        'data': dumpData != null ? dumpData(data) : data,
      };
}

class MetaSharing {
  MetaSharing({
    this.shared = false,
    this.originalKey,
    this.createdBy,
    this.outOfSync = false,
  });

  final bool shared;
  final bool outOfSync;
  final String? originalKey;
  final String? createdBy;

  MetaSharing copyWith({
    bool? shared,
    bool? outOfSync,
    String? originalKey,
    String? createdBy,
  }) =>
      MetaSharing(
        shared: shared ?? this.shared,
        outOfSync: outOfSync ?? this.outOfSync,
        originalKey: originalKey ?? this.originalKey,
        createdBy: createdBy ?? this.createdBy,
      );

  factory MetaSharing.fromRawJson(String str) => MetaSharing.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MetaSharing.fromJson(Map<String, dynamic> json) {
    return MetaSharing(
      shared: json['shared'] ?? false,
      outOfSync: json['outOfSync'] ?? false,
      originalKey: json['originalKey'],
      createdBy: json['createdBy'],
    );
  }

  factory MetaSharing.createFork(String originalKey, MetaSharing? meta, {bool? outOfSync}) {
    final _m = meta ?? MetaSharing();
    return _m.copyWith(
      originalKey: _m.originalKey ?? originalKey,
      outOfSync: outOfSync,
      // TODO created by
    );
  }

  Map<String, dynamic> toJson() => {
        'shared': shared,
        'outOfSync': outOfSync,
        'originalKey': originalKey,
        'createdBy': createdBy,
      };
}

abstract class WithMeta {
  abstract final Meta meta;
}
