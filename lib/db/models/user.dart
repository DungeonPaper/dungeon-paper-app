import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dungeon_paper/db/db.dart';
import 'package:dungeon_paper/db/models/converters/document_reference_converter.dart';
import 'package:dungeon_paper/src/redux/characters/characters_store.dart';
import 'package:dungeon_paper/src/redux/custom_classes/custom_classes_store.dart';
import 'package:dungeon_paper/src/redux/stores.dart';
import 'package:dungeon_paper/src/utils/auth/auth.dart';
// import 'package:dungeon_paper/src/redux/users/user_store.dart';
// import 'package:dungeon_paper/src/utils/auth/auth.dart';
import 'package:dungeon_paper/src/utils/logger.dart';

import 'character.dart';
import 'custom_class.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
abstract class User with _$User {
  const User._();

  const factory User({
    String displayName,
    String email,
    String photoURL,
    @JsonKey(defaultValue: {}) Map<String, dynamic> features,
    @DocumentReferenceConverter() DocumentReference ref,
  }) = _User;

  factory User.fromJson(json, {DocumentReference ref}) =>
      _$UserFromJson(json).copyWith(ref: ref);

  String get documentID => ref.id;

  bool hasFeature(String key) =>
      key != null &&
      features.containsKey(key) &&
      features[key] != false &&
      features[key] != null;

  bool featureEnabled(String key) =>
      features[key] is bool && features[key] == true;

  bool get isDm => featureEnabled('dm_tools_preview');

  bool get isTester => hasFeature('tester');

  Future<Character> createCharacter(Character character) async {
    var doc = firestore.collection(ref.path + '/characters').doc();
    var data = character.toJSON();
    logger.d('Creating character: $data');
    await doc.set(data);
    character..ref = doc;
    dwStore.dispatch(UpsertCharacter(character));
    dwStore.dispatch(SetCurrentChar(character));
    return character;
  }

  Future<CustomClass> createCustomClass(CustomClass cls) async {
    var doc = firestore.collection(ref.path + '/custom_classes').doc();
    var data = cls.toJSON();
    logger.d('Creating custom class: $data');
    await doc.set(data);
    cls..ref = doc;
    dwStore.dispatch(UpsertCustomClass(cls));
    return cls;
  }

  Future<User> changeEmail(String newEmail) async {
    final _user = copyWith(email: newEmail);
    final newRef = await helpers.move(
      newId: 'user_data/$newEmail',
      ref: ref,
      json: _user.toJson(),
    );
    await updateFirebaseEmail(newEmail);
    return _user.copyWith(
      ref: newRef,
    );
  }
}
