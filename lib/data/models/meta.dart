import 'dart:convert';

class Meta {
  Meta({
    DateTime? created,
    this.updated,
    required this.schemaVersion,
    this.shared = false,
    this.originalKey,
  }) {
    this.created = created ?? DateTime.now();
  }

  factory Meta.version(
    int schemaVersion, {
    DateTime? created,
    DateTime? updated,
    bool shared = false,
    String? originalKey,
  }) =>
      Meta(
        schemaVersion: schemaVersion,
        created: created,
        updated: updated,
        shared: shared,
        originalKey: originalKey,
      );

  late final DateTime created;
  final DateTime? updated;
  final int schemaVersion;
  final bool shared;
  final String? originalKey;

  Meta copyWith({
    DateTime? created,
    DateTime? updated,
    int? schemaVersion,
    bool? shared,
    String? originalKey,
  }) =>
      Meta(
        created: created ?? this.created,
        updated: updated ?? this.updated,
        schemaVersion: schemaVersion ?? this.schemaVersion,
        shared: shared ?? this.shared,
        originalKey: originalKey ?? this.originalKey,
      );

  factory Meta.fromRawJson(String str) => Meta.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        created: DateTime.parse(json["created"]),
        updated:
            json["updated"] != null ? DateTime.parse(json["updated"]) : null,
        schemaVersion: json["schemaVersion"],
        shared: json["shared"],
        originalKey: json["originalKey"],
      );

  Map<String, dynamic> toJson() => {
        "created": created.toString(),
        "updated": updated?.toString(),
        "schemaVersion": schemaVersion,
        "originalKey": originalKey,
      };
}
