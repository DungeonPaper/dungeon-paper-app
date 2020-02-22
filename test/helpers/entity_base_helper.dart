import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dungeon_paper/refactor/entity_base.dart';

class EntityTestBase extends FirebaseEntity {
  num a;

  EntityTestBase([DocumentReference ref]) : super(ref);
  EntityTestBase.fromData({
    DocumentReference ref,
    Map<String, dynamic> data,
  }) : super.fromData(ref: ref, data: data);

  @override
  Map<String, dynamic> defaultData() {
    return {'a': 1};
  }

  @override
  deserializeData(Map<String, dynamic> data) {
    a = data['a'];
  }

  @override
  Map<String, dynamic> toJSON() {
    return {'a': a};
  }
}

class EntityTest extends EntityTestBase {
  String b;

  EntityTest([DocumentReference ref]) : super(ref);
  EntityTest.fromData({
    DocumentReference ref,
    Map<String, dynamic> data,
  }) : super.fromData(ref: ref, data: data);

  @override
  Map<String, dynamic> defaultData() {
    return super.defaultData()..addAll({'b': 'Goku'});
  }

  @override
  deserializeData(Map<String, dynamic> data) {
    super.deserializeData(data);
    b = data['b'];
  }

  @override
  Map<String, dynamic> toJSON() {
    return super.toJSON()..addAll({'b': b});
  }
}
