import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dungeon_paper/refactor/entity_base.dart';

class User extends FirebaseEntity {
  String displayName;
  String email;
  String photoURL;

  User({
    DocumentReference ref,
    Map<String, dynamic> data,
  }) : super(ref: ref, data: data);

  @override
  deserializeData(Map<String, dynamic> data) {
    var defaults = defaultData();
    displayName = data['displayName'] ?? defaults['displayName'];
    email = data['email'] ?? defaults['email'];
    photoURL = data['photoURL'] ?? defaults['photoURL'];
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
