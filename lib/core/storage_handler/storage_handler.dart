import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:localstore/localstore.dart';

class StorageHandler implements StorageDelegate {
  static StorageHandler? _instance;
  static StorageHandler get instance => _instance ??= StorageHandler();

  String currentDelegate = 'local';

  final delegates = <String, StorageDelegate>{
    'local': LocalStorageDelegate(),
    'firestore': FirestoreDelegate(),
  };

  StorageDelegate get delegate => delegates[currentDelegate]!;

  @override
  Future<Map<String, dynamic>?> get(String collection, String document) =>
      delegate.get(collection, document);

  @override
  Future<void> create(String collection, String document, Map<String, dynamic> value) =>
      delegate.create(collection, document, value);

  @override
  Future<List<Map<String, dynamic>>> getAllItems(String collection) =>
      delegate.getAllItems(collection);

  @override
  String? _collectionPrefix;

  @override
  void setCollectionPrefix(String? prefix) => delegate.setCollectionPrefix(prefix);

  @override
  String? get collectionPrefix => delegate.collectionPrefix;

  @override
  Future<void> delete(String collection, String document) => delegate.delete(collection, document);

  @override
  Future<void> update(String collection, String document, Map<String, dynamic> value) =>
      delegate.update(collection, document, value);
}

abstract class StorageDelegate {
  String? _collectionPrefix;
  String? get collectionPrefix => _collectionPrefix;

  void setCollectionPrefix(String? prefix) => _collectionPrefix = prefix;

  Future<Map<String, dynamic>?> get(String collection, String document);
  Future<void> create(String collection, String document, Map<String, dynamic> value);
  Future<void> update(String collection, String document, Map<String, dynamic> value);
  Future<void> delete(String collection, String document);

  Future<List<Map<String, dynamic>>> getAllItems(String collection);
}

class FirestoreDelegate extends StorageDelegate {
  final storage = FirebaseFirestore.instance;

  @override
  Future<List<Map<String, dynamic>>> getAllItems(String collection) => storage
      .collection(collection)
      .get()
      .then((list) => list.docs.map((snap) => snap.data()).toList());

  @override
  Future<Map<String, dynamic>?> get(String collection, String document) =>
      storage.collection(collection).doc(document).get().then((snap) => snap.data());

  @override
  Future<void> create(String collection, String document, Map<String, dynamic> value) =>
      storage.collection(collection).doc(document).set(value, fs.SetOptions(merge: true));

  @override
  Future<void> delete(String collection, String document) =>
      storage.collection(collection).doc(document).delete();

  @override
  Future<void> update(String collection, String document, Map<String, dynamic> value) =>
      storage.collection(collection).doc(document).update(value);
}

class LocalStorageDelegate extends StorageDelegate {
  final storage = Localstore.instance;

  @override
  Future<List<Map<String, dynamic>>> getAllItems(String collection) => storage
      .collection(collection)
      .get()
      .then((map) => map?.values.toList().cast<Map<String, dynamic>>() ?? <Map<String, dynamic>>[]);

  @override
  Future<Map<String, dynamic>?> get(String collection, String document) =>
      storage.collection(collection).doc(document).get();

  @override
  Future<void> update(String collection, String document, Map<String, dynamic> value) =>
      storage.collection(collection).doc(document).set(value);

  @override
  Future<void> delete(String collection, String document) =>
      storage.collection(collection).doc(document).delete();

  @override
  Future<void> create(String collection, String document, Map<String, dynamic> value) =>
      update(collection, document, value);
}
