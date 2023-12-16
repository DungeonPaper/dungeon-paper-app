import 'dart:convert';

import 'package:dungeon_paper/app/data/models/ability_scores.dart';
import 'package:dungeon_paper/app/data/models/campaign.dart';
import 'package:dungeon_paper/app/data/models/session_marks.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/data/models/user.dart';
import 'package:dungeon_paper/app/data/services/repository_service.dart';
import 'package:dungeon_paper/app/data/services/user_service.dart';
import 'package:dungeon_paper/core/utils/date_utils.dart';
import 'package:dungeon_paper/core/utils/uuid.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:dungeon_world_data/gear_option.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;

import 'alignment.dart';
import 'bio.dart';
import 'character_class.dart';
import 'character_stats.dart';
import 'character.dart';
import 'gear_choice.dart';
import 'gear_selection.dart';
import 'item.dart';
import 'monster.dart';
import 'move.dart';
import 'note.dart';
import 'race.dart';

class Meta<DataType> with RepositoryServiceMixin {
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
  final DataType? data;
  final String? language;
  final String version;
  final MetaSharing? sharing;
  final DateTime? updated;

  M? getLibraryCopy<M extends WithMeta>() => repo.my
      .listByType<M>()
      .entries
      .toList()
      .firstWhereOrNull((e) => e.value.key == sharing?.sourceKey)
      ?.value;

  bool get isFork => sharing != null;
  bool get isSource => !isFork;

  bool isForkOf(WithMeta parent) => isFork && sharing!.sourceKey == parent.key;
  bool isOwnedBy(User user) => createdBy == user.username;
  bool isSourceOf(WithMeta parent) => !isForkOf(parent);
  bool isOutOfSyncWith(WithMeta parent) =>
      isForkOf(parent) && sharing!.sourceVersion != version;

  factory Meta.empty({
    String? version,
    String? createdBy,
    DateTime? created,
    DateTime? updated,
    MetaSharing? sharing,
    DataType? data,
    String? language,
  }) =>
      Meta._(
        createdBy:
            createdBy ?? '', // ?? Get.find<UserService>().current.displayName,
        version: version ?? uuid(),
        created: created ?? DateTime.now(),
        updated: updated,
        sharing: sharing,
        data: data,
        language: language,
      );

  Meta<DataType> copyWith({
    DateTime? created,
    DateTime? updated,
    String? version,
    MetaSharing? sharing,
    String? createdBy,
    DataType? data,
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

  Meta<DataType> fork({
    required String createdBy,
    required String sourceKey,
    String? version,
  }) =>
      copyWith(
        version: version,
        createdBy: createdBy,
        created: DateTime.now(),
        sharing: MetaSharing.fork(
          sourceOwner: this.createdBy,
          sourceKey: sourceKey,
          sourceVersion: this.version,
        ),
      );

  factory Meta.fromRawJson(String str) => Meta.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Meta.fromJson(Map<String, dynamic> json,
          [DataType Function(dynamic json)? parseData]) =>
      Meta._(
        created: json['created'] != null
            ? parseDate(json['created'])
            : DateTime.now(),
        createdBy: json['createdBy'],
        data: json['data'] != null
            ? parseData != null
                ? parseData(json['data'])
                : json['data']
            : null,
        language: json['language'],
        version: json['version']?.toString() ?? uuid(),
        sharing: json['sharing'] != null
            ? MetaSharing.fromJson(json['sharing'])
            : null,
        updated: json['updated'] != null ? parseDate(json['updated']) : null,
      );

  factory Meta.tryParse(dynamic meta,
          {String? owner, DataType Function(dynamic json)? parseData}) =>
      meta != null
          ? meta is Meta<DataType>
              ? meta
              : Meta.fromJson(meta, parseData)
          : Meta.empty(createdBy: owner);

  Map<String, dynamic> toJson([dynamic Function(DataType? data)? dumpData]) => {
        'created': created.toString(),
        'createdBy': createdBy,
        'data': dumpData != null ? dumpData(data) : data,
        'language': language,
        'version': version,
        'sharing': sharing?.toJson(),
        'updated': updated?.toString(),
      };

  static String keyFor(dynamic object) => object is WithKey
      ? object.key
      : object is dw.Tag
          ? object.name
          : object.toString();

  static Meta<T> metaFor<T>(dynamic object) {
    assert(object is WithMeta);
    return (object as dynamic).meta;
  }

  /// Returns an item with forked meta, or the same meta if its by the same user
  static T forkMeta<T extends WithMeta>(T object, User user,
      {Meta? meta, String? version}) {
    final Meta m = (meta ?? object.meta);
    // final _o =
    //     force || _m.createdBy != user.username ? object.copyWithInherited(key: uuid()) : object;
    final o = object;

    return Meta.copyObjectWithMeta<T>(
      o,
      m.fork(
        createdBy: user.username,
        sourceKey: object.key,
        version: version,
      ),
    );
  }

  static Map<String, dynamic> toJsonFor(dynamic object) {
    final dyn = object as dynamic;
    switch (object.runtimeType) {
      case AlignmentValue _:
      case Bio _:
      case SessionMark _:
      case CharacterClass _:
      case CharacterStats _:
      case Character _:
      case GearChoice _:
      case GearSelection _:
      case GearOption _:
      case Item _:
      case Monster _:
      case Move _:
      case Note _:
      case Race _:
      case Spell _:
      case dw.Tag _:
        return dyn.toJson();
    }
    throw TypeError();
  }

  static T increaseMetaVersion<T extends WithMeta>(T object) {
    return Meta.copyObjectWithMeta(
      object,
      object.meta.copyWith(version: uuid()),
    );
  }

  static User get user => Get.find<UserService>().current;

  static T forkOrIncrease<T extends WithMeta>(T object) {
    if (object.meta.isOwnedBy(user)) {
      return increaseMetaVersion(object);
    }
    return forkMeta(object, user);
  }

  static T copyObjectWithMeta<T extends WithMeta>(dynamic object, Meta? meta) {
    switch (object.runtimeType) {
      case AlignmentValue _:
      case CharacterClass _:
      case Character _:
      case Item _:
      case Monster _:
      case Move _:
      case Note _:
      case Race _:
      case Spell _:
        return object.copyWithInherited(meta: meta) as T;
      default:
        throw UnsupportedError('Type ${object.runtimeType} not supported');
    }
  }

  static storageKeyFor(Type t) {
    switch (t) {
      case CharacterClass _:
        return 'CharacterClasses';
      case Character _:
        return 'Characters';
      case Item _:
        return 'Items';
      case Monster _:
        return 'Monsters';
      case Move _:
        return 'Moves';
      case Spell _:
        return 'Spells';
      case Race _:
        return 'Races';
      case Note _:
        return 'Notes';
      case dw.Tag _:
        return 'Tags';
    }
  }

  static typeFromString(String type) {
    final map = {
      'AbilityScore': AbilityScore,
      'Campaign': Campaign,
      'Character': Character,
      'AlignmentValue': AlignmentValue,
      'Move': Move,
      'Spell': Spell,
      'Item': Item,
      'CharacterClass': CharacterClass,
      'Race': Race,
      'GearSelection': GearSelection,
      'Note': Note,
      'MoveCategory': MoveCategory,
      'Tag': dw.Tag,
      'Dice': dw.Dice,
    };

    if (!map.containsKey(type)) {
      throw UnsupportedError('Type $type not supported');
    }

    return map[type];
  }

  static final allStorageKeys = <Type, String>{
    for (final t in [
      CharacterClass,
      Character,
      Item,
      Monster,
      Move,
      Spell,
      Race,
      Note,
      dw.Tag
    ])
      t: Meta.storageKeyFor(t),
  };

  static IconData genericIconFor(Type t) {
    switch (t) {
      case Character _:
        return Character.genericIcon;
      case CharacterClass _:
        return CharacterClass.genericIcon;
      case AlignmentValue _:
      case Item _:
        return Item.genericIcon;
      case Move _:
        return Move.genericIcon;
      case Note _:
        return Note.genericIcon;
      case Race _:
        return Race.genericIcon;
      case Spell _:
        return Spell.genericIcon;
    }
    throw TypeError();
  }

  static referenceFor(WithMeta object) => dw.EntityReference(
        key: object.key,
        name: object.displayName,
        type: tn(object.runtimeType),
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Meta &&
          runtimeType == other.runtimeType &&
          created == other.created &&
          createdBy == other.createdBy &&
          updated == other.updated &&
          version == other.version &&
          sharing == other.sharing &&
          data == other.data &&
          language == other.language;

  @override
  int get hashCode => Object.hashAll(
      [created, createdBy, updated, version, sharing, data, language]);

  String get debugProperties =>
      'created: $created, createdBy: $createdBy, updated: $updated, version: $version, sharing: $sharing, data: $data, language: $language';

  @override
  String toString() => 'Meta($debugProperties)';

  Meta<DataType> stampUpdate() => copyWith(updated: DateTime.now());
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

  factory MetaSharing.fromRawJson(String str) =>
      MetaSharing.fromJson(json.decode(str));

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
    final m = meta ?? MetaSharing.fork(sourceVersion: uuid());
    if (owner == m.sourceOwner) {
      return m;
    }
    return m.copyWith(
      sourceKey: m.sourceKey ?? sourceKey,
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MetaSharing &&
          runtimeType == other.runtimeType &&
          shared == other.shared &&
          dirty == other.dirty &&
          sourceKey == other.sourceKey &&
          sourceOwner == other.sourceOwner &&
          sourceVersion == other.sourceVersion;

  @override
  int get hashCode =>
      Object.hashAll([shared, dirty, sourceKey, sourceOwner, sourceVersion]);

  String get debugProperties =>
      'shared: $shared, dirty: $dirty, sourceKey: $sourceKey, sourceOwner: $sourceOwner, sourceVersion: $sourceVersion';

  @override
  String toString() => 'MetaSharing($debugProperties)';
}

abstract mixin class WithKey {
  abstract final String key;
}

abstract class MetaInterface<T, M> {
  T copyWith({Meta<M>? meta});
  T copyWithInherited({Meta<M>? meta, String? key}) => copyWith(meta: meta);
  dynamic toJson();
}

mixin WithMeta<T, MetaDataType>
    implements WithKey, MetaInterface<T, MetaDataType> {
  abstract final Meta<MetaDataType> meta;
  String get displayName;
  String get storageKey;
  dw.EntityReference get reference => Meta.referenceFor(this);
}

