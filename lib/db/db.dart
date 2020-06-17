import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';

const APP_NAME = null;
FirebaseApp _app;
Firestore _firestore;

FirebaseApp get app => _app ??= initApp();
Firestore get firestore {
  if (_firestore != null) {
    return _firestore;
  }

  initApp();
  return _firestore;
}

FirebaseApp initApp({bool web}) {
  WidgetsFlutterBinding.ensureInitialized();
  _app = FirebaseApp.instance;
  _firestore = Firestore.instance..settings(persistenceEnabled: true);

  return _app;
}

void main() => initApp();
