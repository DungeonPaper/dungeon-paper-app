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
  Future<Map<String, dynamic>?> getItem(String file, String key) => delegate.getItem(file, key);

  @override
  Future<void> setItem(String file, String key, Map<String, dynamic> value) =>
      delegate.setItem(file, key, value);

  @override
  Future<List<Map<String, dynamic>>> getAllItems(String collection) =>
      delegate.getAllItems(collection);

  @override
  String? _collectionPrefix;

  @override
  void setCollectionPrefix(String? prefix) => delegate.setCollectionPrefix(prefix);

  @override
  String? get collectionPrefix => delegate.collectionPrefix;
}

abstract class StorageDelegate {
  String? _collectionPrefix;
  String? get collectionPrefix => _collectionPrefix;

  void setCollectionPrefix(String? prefix) => _collectionPrefix = prefix;

  Future<Map<String, dynamic>?> getItem(String collection, String document);
  Future<void> setItem(String collection, String document, Map<String, dynamic> value);

  Future<List<Map<String, dynamic>>> getAllItems(String collection);
}

class FirestoreDelegate extends StorageDelegate {
  final dynamic storage = null;

  @override
  Future<List<Map<String, dynamic>>> getAllItems(String collection) =>
      storage.collection(collection).get().then((list) => list.docs.map((snap) => snap.data()));

  @override
  Future<Map<String, dynamic>?> getItem(String collection, String document) =>
      storage.collection(collection).doc(document).get().then((snap) => snap.data());

  @override
  Future<void> setItem(String collection, String document, Map<String, dynamic> value) =>
      storage.collection(collection).set(document, merge: true).set(value);
}

class LocalStorageDelegate extends StorageDelegate {
  final storage = Localstore.instance;

  @override
  Future<List<Map<String, dynamic>>> getAllItems(String collection) => storage
      .collection(collection)
      .get()
      .then((map) => map?.values.toList().cast<Map<String, dynamic>>() ?? <Map<String, dynamic>>[]);

  @override
  Future<Map<String, dynamic>?> getItem(String collection, String document) =>
      storage.collection(collection).doc(document).get();

  @override
  Future<void> setItem(String collection, String document, Map<String, dynamic> value) =>
      storage.collection(collection).doc(document).set(value);
}
