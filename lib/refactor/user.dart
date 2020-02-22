import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dungeon_paper/refactor/entity_base.dart';

class User extends FirebaseEntity {
  String displayName;
  String email;
  String photoURL;

  User([DocumentReference ref]) : super(ref);
  User.fromData({
    DocumentReference ref,
    Map<String, dynamic> data,
  }) : super.fromData(ref: ref, data: data);

  @override
  deserializeData(Map<String, dynamic> data) {
    displayName = data['displayName'];
    email = data['email'];
    photoURL = data['photoURL'];
  }

  @override
  Map<String, dynamic> toJSON() {
    return {
      'displayName': displayName,
      'email': email,
      'photoURL': photoURL,
    };
  }

  @override
  Map<String, dynamic> defaultData() {
    return {
      'displayName': 'New User',
      'email': 'guest@guest.com',
      'photoURL': 'about:blank',
    };
  }
}
