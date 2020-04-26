import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

const APP_NAME = null;
FirebaseApp _app;
FirebaseApp get app => _app ??= initApp();
Firestore get firestore => Firestore.instance..settings();

FirebaseApp initApp({bool web}) => _app = FirebaseApp.instance;
main() => initApp();
