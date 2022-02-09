import 'dart:convert';

class Meta {
  Meta({
    DateTime? created,
    this.updated,
    required this.schemaVersion,
    this.shared = false,
  }) {
    this.created = created ?? DateTime.now();
  }

  late final DateTime created;
  final DateTime? updated;
  final int schemaVersion;
  final bool shared;

  Meta copyWith({
    DateTime? created,
    DateTime? updated,
    int? schemaVersion,
    bool? shared,
  }) =>
      Meta(
        created: created ?? this.created,
        updated: updated ?? this.updated,
        schemaVersion: schemaVersion ?? this.schemaVersion,
        shared: shared ?? this.shared,
      );

  factory Meta.fromRawJson(String str) => Meta.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        created: DateTime.parse(json["created"]),
        updated:
            json["updated"] != null ? DateTime.parse(json["updated"]) : null,
        schemaVersion: json["schema_version"],
        shared: json["shared"],
      );

  Map<String, dynamic> toJson() => {
        "created": created,
        "updated": updated,
        "schema_version": schemaVersion,
      };
}
