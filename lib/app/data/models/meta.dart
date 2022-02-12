import 'dart:convert';

class Meta {
  Meta({
    DateTime? created,
    this.updated,
    required this.schemaVersion,
  }) {
    this.created = created ?? DateTime.now();
  }

  late final DateTime created;
  final DateTime? updated;
  final int schemaVersion;

  factory Meta.version(
    int schemaVersion, {
    DateTime? created,
    DateTime? updated,
  }) =>
      Meta(
        schemaVersion: schemaVersion,
        created: created,
        updated: updated,
      );
  Meta copyWith({
    DateTime? created,
    DateTime? updated,
    int? schemaVersion,
  }) =>
      Meta(
        created: created ?? this.created,
        updated: updated ?? this.updated,
        schemaVersion: schemaVersion ?? this.schemaVersion,
      );

  factory Meta.fromRawJson(String str) => Meta.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        created: DateTime.parse(json["created"]),
        updated:
            json["updated"] != null ? DateTime.parse(json["updated"]) : null,
        schemaVersion: json["schemaVersion"],
      );

  Map<String, dynamic> toJson() => {
        "created": created.toString(),
        "updated": updated?.toString(),
        "schemaVersion": schemaVersion,
      };
}

class SharedMeta extends Meta {
  SharedMeta({
    DateTime? created,
    DateTime? updated,
    required int schemaVersion,
    this.shared = false,
    this.originalKey,
    this.outOfSync = false,
  }) : super(created: created, updated: updated, schemaVersion: schemaVersion);

  final bool shared;
  final bool outOfSync;
  final String? originalKey;

  factory SharedMeta.version(
    int schemaVersion, {
    DateTime? created,
    DateTime? updated,
    bool shared = false,
    bool outOfSync = false,
    String? originalKey,
  }) =>
      SharedMeta(
        schemaVersion: schemaVersion,
        created: created,
        updated: updated,
        shared: shared,
        outOfSync: outOfSync,
        originalKey: originalKey,
      );

  @override
  SharedMeta copyWith({
    DateTime? created,
    DateTime? updated,
    int? schemaVersion,
    bool? shared,
    bool? outOfSync,
    String? originalKey,
  }) =>
      SharedMeta(
        created: created ?? this.created,
        updated: updated ?? this.updated,
        schemaVersion: schemaVersion ?? this.schemaVersion,
        shared: shared ?? this.shared,
        outOfSync: outOfSync ?? this.outOfSync,
        originalKey: originalKey ?? this.originalKey,
      );

  factory SharedMeta.fromRawJson(String str) =>
      SharedMeta.fromJson(json.decode(str));

  @override
  String toRawJson() => json.encode(toJson());

  factory SharedMeta.fromMeta(
    Meta meta, {
    bool? shared,
    bool? outOfSync,
    String? originalKey,
  }) =>
      SharedMeta(
        schemaVersion: meta.schemaVersion,
        created: meta.created,
        updated: meta.updated,
        shared: shared ?? false,
        outOfSync: outOfSync ?? false,
        originalKey: originalKey,
      );

  factory SharedMeta.fromJson(Map<String, dynamic> json) {
    var meta = Meta.fromJson(json);
    return SharedMeta.fromMeta(
      meta,
      shared: json["shared"],
      outOfSync: json["outOfSync"],
      originalKey: json["originalKey"],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        "originalKey": originalKey,
        "shared": shared,
        "outOfSync": outOfSync,
      };
}
