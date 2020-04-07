import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dungeon_paper/refactor/firebase_entity/firebase_entity.dart';

var _fields = Fields([
  Field<num>(fieldName: 'a', defaultValue: (ctx) => 0),
  Field<String>(fieldName: 'b', defaultValue: (ctx) => ''),
]);

class EntityTestBase extends FirebaseEntity {
  Fields fields = _fields.copy();
  num get a => fields.get<num>('a').get;
  set a(val) => fields.get<num>('a').set(val);

  EntityTestBase({
    DocumentReference ref,
    Map<String, dynamic> data,
  }) : super(ref: ref, data: data);
}

class EntityTest extends EntityTestBase {
  Fields fields = _fields.copy();
  String get b => fields.get<String>('b').get;
  set b(val) => fields.get<String>('b').set(val);

  EntityTest({
    DocumentReference ref,
    Map<String, dynamic> data,
  }) : super(ref: ref, data: data);
}
