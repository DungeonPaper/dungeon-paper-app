import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dungeon_paper/db/models/firebase_entity/fields/fields.dart';
import 'package:dungeon_paper/db/models/firebase_entity/firebase_entity.dart';
import 'package:dungeon_paper/db/models/user.dart';
import 'package:dungeon_paper/src/redux/campaigns/campaigns_store.dart';
import 'package:dungeon_paper/src/redux/stores.dart';
import 'package:pedantic/pedantic.dart';
import 'package:uuid/uuid.dart';

import 'character/character.dart';

// Ordered by whichever data needs to come earliest for the rest to be able to calculate
FieldsContext _clsFields = FieldsContext([
  StringField(fieldName: 'key', defaultValue: (ctx) => Uuid().v4()),
  StringField(fieldName: 'name'),
  StringField(fieldName: 'description'),
  Field<User>(fieldName: 'owner', defaultValue: (ctx) => null),
  ListOfField<Character>(
    fieldName: 'characters',
    defaultValue: (ctx) => [],
    field: Field<Character>(
      fieldName: '_player',
      defaultValue: (ctx) => null,
    ),
  ),
]);

class Campaign extends FirebaseEntity {
  FieldsContext _fields;

  @override
  FieldsContext get fields => _fields ??= _clsFields.copy();

  Campaign({
    Map<String, dynamic> data,
    DocumentReference ref,
    bool autoLoad,
  }) : super(ref: ref, data: data, autoLoad: autoLoad);

  String get key => fields.get('key').get;
  set key(value) => fields.get('key').set(value);
  String get name => fields.get('name').get;
  set name(value) => fields.get('name').set(value);
  String get description => fields.get('description').get;
  set description(value) => fields.get('description').set(value);
  User get owner => fields.get('owner').get;
  set owner(value) => fields.get('owner').set(value);
  List<Character> get characters => fields.get('characters').get;
  set characters(value) => fields.get('characters').set(value);

  @override
  void finalizeCreate(Map<String, dynamic> json) async {
    dwStore.dispatch(UpsertCampaign(this));
    await _updateChars();
    super.finalizeCreate(json);
  }

  @override
  void finalizeUpdate(Map<String, dynamic> json, {bool save = true}) async {
    if (save) {
      dwStore.dispatch(UpsertCampaign(this));
    }
    await _updateChars();
    super.finalizeUpdate(json, save: save);
  }

  @override
  Future<void> delete() async {
    unawaited(super.delete());
    dwStore.dispatch(RemoveCampaign(this));
  }

  Future<void> _updateChars() async {
    // TODO implement
    // for (final char in dwStore.state.characters.all.values) {
    //   if (char.playerClasses.any((el) => el.key == key)) {
    //     final _updated = char.playerClasses
    //         .map((el) => el.key == key ? toPlayerClass() : el)
    //         .toList();
    //     char.playerClasses = _updated;
    //     await char.update();
    //   }
    // }
  }

  @override
  String toString() => 'Custom Class: $name ($key)';
}
