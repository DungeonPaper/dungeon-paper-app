import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';

typedef DocData = Map<String, dynamic>;

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
  Future<DocData?> getDocument(String collection, String document) =>
      delegate.getDocument(collection, document);

  @override
  Future<void> create(String collection, String document, DocData value) =>
      delegate.create(collection, document, value);

  @override
  Future<List<DocData>> getCollection(String collection) => delegate.getCollection(collection);

  @override
  String? _collectionPrefix;

  @override
  void setCollectionPrefix(String? prefix) => delegate.setCollectionPrefix(prefix);

  @override
  String? get collectionPrefix => delegate.collectionPrefix;

  @override
  Future<void> delete(String collection, String document) => delegate.delete(collection, document);

  @override
  Future<void> update(String collection, String document, DocData value) =>
      delegate.update(collection, document, value);

  @override
  StreamSubscription<List<DocData>> collectionListener(
    String collection,
    void Function(List<DocData> data)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) =>
      delegate.collectionListener(collection, onData,
          onError: onError, onDone: onDone, cancelOnError: cancelOnError);

  @override
  StreamSubscription<DocData?> documentListener(
    String collection,
    String document,
    void Function(DocData? data)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) =>
      delegate.documentListener(collection, document, onData,
          onError: onError, onDone: onDone, cancelOnError: cancelOnError);
}

class CacheHandler extends StorageHandler {
  static LocalStorageDelegate? _instance;
  static LocalStorageDelegate get instance => _instance ??= LocalStorageDelegate();

  @override
  String get currentDelegate => 'local';
}

abstract class StorageDelegate {
  String? _collectionPrefix;
  String? get collectionPrefix => _collectionPrefix;

  void setCollectionPrefix(String? prefix) => _collectionPrefix = prefix;

  Future<List<DocData>> getCollection(String collection);
  StreamSubscription<List<DocData>> collectionListener(
    String collection,
    void Function(List<DocData> data)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  });
  Future<DocData?> getDocument(String collection, String document);
  StreamSubscription<DocData?> documentListener(
    String collection,
    String document,
    void Function(DocData? data)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  });
  Future<void> create(String collection, String document, DocData value);
  Future<void> update(String collection, String document, DocData value);
  Future<void> delete(String collection, String document);
}

class FirestoreDelegate extends StorageDelegate {
  final storage = FirebaseFirestore.instance;

  @override
  Future<List<DocData>> getCollection(String collection) => storage
      .collection(collection)
      .get()
      .then((list) => list.docs.map((snap) => snap.data()).toList());

  @override
  Future<DocData?> getDocument(String collection, String document) =>
      storage.collection(collection).doc(document).get().then((snap) => snap.data());

  @override
  Future<void> create(String collection, String document, DocData value) =>
      storage.collection(collection).doc(document).set(value, fs.SetOptions(merge: true));

  @override
  Future<void> delete(String collection, String document) =>
      storage.collection(collection).doc(document).delete();

  @override
  Future<void> update(String collection, String document, DocData value) =>
      storage.collection(collection).doc(document).update(value);

  @override
  StreamSubscription<List<DocData>> collectionListener(
    String collection,
    void Function(List<DocData> data)? onData, {
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
  StreamSubscription<DocData?> documentListener(
    String collection,
    String document,
    void Function(DocData? data)? onData, {
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

  Stream<DocData?> asDocumentStream(Stream<DocumentSnapshot<DocData?>> source) async* {
    await for (final snap in source) {
      yield snap.data();
    }
  }

  Stream<List<DocData>> asCollectionStream(Stream<QuerySnapshot<DocData>> source) async* {
    await for (final query in source) {
      yield query.docs.map((doc) => doc.data()).toList();
    }
  }
}

class LocalStorageDelegate extends StorageDelegate {
  final storage = Localstore.instance;
  final docStreams = <String, StreamController<DocData?>>{};
  final colStreams = <String, StreamController<List<DocData>>>{};

  @override
  Future<List<DocData>> getCollection(String collection) => storage
      .collection(collection)
      .get()
      .then((map) => map?.values.toList().cast<DocData>() ?? <DocData>[]);

  @override
  Future<DocData?> getDocument(String collection, String document) =>
      storage.collection(collection).doc(document).get();

  @override
  Future<void> update(String collection, String document, DocData value) async {
    docStreams['$collection/$document']?.add(value);
    colStreams[collection]?.add((await getCollection(collection))
        .map((e) => (e['key'] ?? e['name']) == document ? value : e)
        .toList());
    return storage.collection(collection).doc(document).set(value);
  }

  @override
  Future<void> delete(String collection, String document) async {
    docStreams['$collection/$document']?.add(null);
    colStreams[collection]?.add((await getCollection(collection))
        .where((e) => (e['key'] ?? e['name']) != document)
        .toList());
    return storage.collection(collection).doc(document).delete();
  }

  @override
  Future<void> create(String collection, String document, DocData value) async {
    docStreams['$collection/$document']?.add(value);
    colStreams[collection]?.add(
        (await getCollection(collection)).where((e) => (e['key'] ?? e['name']) != document).toList()
          ..add(value));
    return storage.collection(collection).doc(document).set(value);
  }

  @override
  StreamSubscription<List<DocData>> collectionListener(
    String collection,
    void Function(List<DocData> data)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return getCollectionStream(collection).listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }

  @override
  StreamSubscription<DocData?> documentListener(
    String collection,
    String document,
    void Function(DocData? data)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return getDocumentStream(collection, document).listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }

  Stream<DocData?> getDocumentStream(String collection, String document) {
    final key = '$collection/$document';
    if (!docStreams.containsKey(key)) {
      docStreams[key] = StreamController.broadcast();
      getDocument(collection, document).then((d) => docStreams[key]!.add(d));
    }
    return docStreams[key]!.stream.asBroadcastStream();
  }

  Stream<List<DocData>> getCollectionStream(String collection) {
    if (!colStreams.containsKey(collection)) {
      colStreams[collection] = StreamController.broadcast();
      getCollection(collection).then((d) => colStreams[collection]!.add(d));
    }
    return colStreams[collection]!.stream.asBroadcastStream();
  }
}
