import 'dart:convert';

class Meta {
  Meta({
    DateTime? created,
    this.updated,
    required this.schemaVersion,
    this.sharing,
  }) : created = created ?? DateTime.now();

  late final DateTime created;
  final DateTime? updated;
  final int schemaVersion;
  final MetaSharing? sharing;

  factory Meta.version(
    int schemaVersion, {
    DateTime? created,
    DateTime? updated,
    MetaSharing? sharing,
  }) =>
      Meta(
        schemaVersion: schemaVersion,
        created: created,
        updated: updated,
        sharing: sharing,
      );

  Meta copyWith({
    DateTime? created,
    DateTime? updated,
    int? schemaVersion,
    MetaSharing? sharing,
  }) =>
      Meta(
        created: created ?? this.created,
        updated: updated ?? this.updated,
        schemaVersion: schemaVersion ?? this.schemaVersion,
        sharing: sharing ?? this.sharing,
      );

  factory Meta.fromRawJson(String str) => Meta.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        created: json['created'] != null ? DateTime.parse(json['created']) : DateTime.now(),
        updated: json['updated'] != null ? DateTime.parse(json['updated']) : null,
        schemaVersion: json['schemaVersion'] ?? 1,
        sharing: json['sharing'] != null ? MetaSharing.fromJson(json['sharing']) : null,
      );

  Map<String, dynamic> toJson() => {
        'created': created.toString(),
        'updated': updated?.toString(),
        'schemaVersion': schemaVersion,
        'sharing': sharing?.toJson(),
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

  Map<String, dynamic> toJson() => {
        'shared': shared,
        'outOfSync': outOfSync,
        'originalKey': originalKey,
        'createdBy': createdBy,
      };
}
