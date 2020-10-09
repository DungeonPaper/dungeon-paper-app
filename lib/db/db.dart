import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/widgets.dart';

const APP_NAME = null;
FirebaseApp _app;
FirebaseFirestore _firestore;
FirebaseAuth _auth;

// T withInitApp<T>(T Function() cb) {
//   if (_app != null) {
//     return cb();
//   }
//   initApp();
//   return cb();
// }

FirebaseApp get firebase => _app;
FirebaseFirestore get firestore => _firestore;
FirebaseAuth get auth => _auth;

Future<FirebaseApp> initApp({bool web}) async {
  if (_app != null) {
    return _app;
  }

  WidgetsFlutterBinding.ensureInitialized();
  _app = await Firebase.initializeApp();
  _firestore = FirebaseFirestore.instance;
  _auth = FirebaseAuth.instance;
  if (kIsWeb) {
    await _firestore.enablePersistence();
  } else {
    _firestore.settings = Settings(persistenceEnabled: true);
  }
  return _app;
}

void main() => initApp();
