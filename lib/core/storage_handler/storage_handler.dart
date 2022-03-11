import 'dart:async';

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
  Future<Map<String, dynamic>?> getDocument(String collection, String document) =>
      delegate.getDocument(collection, document);

  @override
  Future<void> create(String collection, String document, Map<String, dynamic> value) =>
      delegate.create(collection, document, value);

  @override
  Future<List<Map<String, dynamic>>> getCollection(String collection) =>
      delegate.getCollection(collection);

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

  @override
  StreamSubscription<List<Map<String, dynamic>>> collectionListener(
    String collection,
    void Function(List<Map<String, dynamic>> data)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) =>
      delegate.collectionListener(collection, onData,
          onError: onError, onDone: onDone, cancelOnError: cancelOnError);

  @override
  StreamSubscription<Map<String, dynamic>?> documentListener(
    String collection,
    String document,
    void Function(Map<String, dynamic>? data)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) =>
      delegate.documentListener(collection, document, onData,
          onError: onError, onDone: onDone, cancelOnError: cancelOnError);
}

class CacheHandler extends StorageHandler {
  @override
  String get currentDelegate => 'firestore';
}

abstract class StorageDelegate {
  String? _collectionPrefix;
  String? get collectionPrefix => _collectionPrefix;

  void setCollectionPrefix(String? prefix) => _collectionPrefix = prefix;

  Future<List<Map<String, dynamic>>> getCollection(String collection);
  StreamSubscription<List<Map<String, dynamic>>> collectionListener(
    String collection,
    void Function(List<Map<String, dynamic>> data)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  });
  Future<Map<String, dynamic>?> getDocument(String collection, String document);
  StreamSubscription<Map<String, dynamic>?> documentListener(
    String collection,
    String document,
    void Function(Map<String, dynamic>? data)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  });
  Future<void> create(String collection, String document, Map<String, dynamic> value);
  Future<void> update(String collection, String document, Map<String, dynamic> value);
  Future<void> delete(String collection, String document);
}

class FirestoreDelegate extends StorageDelegate {
  final storage = FirebaseFirestore.instance;

  @override
  Future<List<Map<String, dynamic>>> getCollection(String collection) => storage
      .collection(collection)
      .get()
      .then((list) => list.docs.map((snap) => snap.data()).toList());

  @override
  Future<Map<String, dynamic>?> getDocument(String collection, String document) =>
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

  @override
  StreamSubscription<List<Map<String, dynamic>>> collectionListener(
    String collection,
    void Function(List<Map<String, dynamic>> data)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return asCollectionStream(storage.collection(collection).snapshots()).listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }

  @override
  StreamSubscription<Map<String, dynamic>?> documentListener(
    String collection,
    String document,
    void Function(Map<String, dynamic>? data)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return asDocumentStream(storage.collection(collection).doc(document).snapshots()).listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }

  Stream<Map<String, dynamic>?> asDocumentStream(
      Stream<DocumentSnapshot<Map<String, dynamic>?>> source) async* {
    await for (final snap in source) {
      yield snap.data();
    }
  }

  Stream<List<Map<String, dynamic>>> asCollectionStream(
      Stream<QuerySnapshot<Map<String, dynamic>>> source) async* {
    await for (final query in source) {
      yield query.docs.map((doc) => doc.data()).toList();
    }
  }
}

class LocalStorageDelegate extends StorageDelegate {
  final storage = Localstore.instance;

  @override
  Future<List<Map<String, dynamic>>> getCollection(String collection) => storage
      .collection(collection)
      .get()
      .then((map) => map?.values.toList().cast<Map<String, dynamic>>() ?? <Map<String, dynamic>>[]);

  @override
  Future<Map<String, dynamic>?> getDocument(String collection, String document) =>
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

  @override
  StreamSubscription<List<Map<String, dynamic>>> collectionListener(
    String collection,
    void Function(List<Map<String, dynamic>> data)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return asCollectionStream(getCollection(collection)).listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }

  @override
  StreamSubscription<Map<String, dynamic>?> documentListener(
    String collection,
    String document,
    void Function(Map<String, dynamic>? data)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return asDocumentStream(getDocument(collection, document)).listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }

  Stream<Map<String, dynamic>?> asDocumentStream(Future<Map<String, dynamic>?> source) async* {
    final resp = await source;
    yield resp;
  }

  Stream<List<Map<String, dynamic>>> asCollectionStream(
      Future<List<Map<String, dynamic>>> source) async* {
    final resp = await source;
    yield resp;
  }
}
