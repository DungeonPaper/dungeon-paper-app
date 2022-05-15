import 'dart:convert';

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

  bool get isFork => sharing != null && sharing!.isFork;

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
        createdBy: createdBy ?? '', // ?? Get.find<UserService>().current.displayName,
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
      createdBy == this.createdBy
          ? this
          : copyWith(
              schemaVersion: 1,
              createdBy: createdBy,
              created: DateTime.now(),
              sharing: MetaSharing.fork(
                sourceOwner: this.createdBy,
                sourceKey: sourceKey,
                sourceVersion: schemaVersion,
              ),
            );

  Meta originalOf() => sharing == null
      ? this
      : Meta._(
          createdBy: sharing!.sourceOwner!,
          schemaVersion: schemaVersion,
          created: created,
          updated: updated,
          sharing: sharing,
          data: data,
          language: language,
        );

  factory Meta.fromRawJson(String str) => Meta.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Meta.fromJson(Map<String, dynamic> json, [T Function(dynamic json)? parseData]) => Meta._(
        created: json['created'] != null ? DateTime.parse(json['created']) : DateTime.now(),
        createdBy: json['createdBy'],
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
    required this.sourceVersion,
    this.dirty = false,
  });

  MetaSharing.createSource({
    this.shared = false,
    this.sourceOwner,
  })  : dirty = false,
        sourceVersion = 1,
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
  final int sourceVersion;

  bool get isFork => sourceOwner?.isNotEmpty == true && sourceKey?.isNotEmpty == true;
  bool get isSource => !isFork;

  MetaSharing copyWith({
    bool? shared,
    bool? dirty,
    String? sourceKey,
    String? sourceOwner,
    int? sourceVersion,
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

  factory MetaSharing.fromJson(Map<String, dynamic> json) {
    return MetaSharing._(
      shared: json['shared'] ?? false,
      dirty: json['dirty'] ?? false,
      sourceKey: json['sourceKey'],
      sourceOwner: json['sourceOwner'],
      sourceVersion: json['sourceVersion'] ?? 1,
    );
  }

  factory MetaSharing.createFork(
    String sourceKey, {
    MetaSharing? meta,
    bool? dirty,
    String? owner,
  }) {
    final _m = meta ?? MetaSharing.fork(sourceVersion: 1);
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
  T copyWithInherited({Meta<M>? meta}) => copyWith(meta: meta);
}
