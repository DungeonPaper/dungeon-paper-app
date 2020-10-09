import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';

const APP_NAME = null;
FirebaseApp _app;
FirebaseFirestore _firestore;
FirebaseAuth _auth;

T withInitApp<T>(T Function() cb) {
  if (_app != null) {
    return cb();
  }
  initApp();
  return cb();
}

FirebaseApp get firebase => withInitApp(() => _app);
FirebaseFirestore get firestore => withInitApp(() => _firestore);
FirebaseAuth get auth => withInitApp(() => _auth);

FirebaseApp initApp({bool web}) {
  if (_app != null) {
    return _app;
  }

  WidgetsFlutterBinding.ensureInitialized();
  _app = Firebase.app();
  _firestore = FirebaseFirestore.instance..enablePersistence();

  return _app;
}

void main() => initApp();
