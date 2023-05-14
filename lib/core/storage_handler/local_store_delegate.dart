part of 'storage_handler.dart';

class LocalStorageDelegate extends StorageDelegate {
  final storage = Localstore.instance;
  final docStreams = <String, StreamController<DocData?>>{};
  final colStreams = <String, StreamController<List<DocData>>>{};

  @override
  Future<List<DocData>> getCollection(String collection) =>
      storage.collection(collection).get().then((map) => map?.values.toList().cast<DocData>() ?? <DocData>[]);

  @override
  Future<DocData?> getDocument(String collection, String document) =>
      storage.collection(collection).doc(document).get();

  @override
  Future<void> update(String collection, String document, DocData value) async {
    docStreams['$collection/$document']?.add(value);
    colStreams[collection]
        ?.add((await getCollection(collection)).map((e) => (e['key'] ?? e['name']) == document ? value : e).toList());
    return storage.collection(collection).doc(document).set(value);
  }

  @override
  Future<void> delete(String collection, String document) async {
    docStreams['$collection/$document']?.add(null);
    colStreams[collection]
        ?.add((await getCollection(collection)).where((e) => (e['key'] ?? e['name']) != document).toList());
    return storage.collection(collection).doc(document).delete();
  }

  @override
  Future<void> create(String collection, String document, DocData value) async {
    docStreams['$collection/$document']?.add(value);
    colStreams[collection]
        ?.add((await getCollection(collection)).where((e) => (e['key'] ?? e['name']) != document).toList()..add(value));
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

  @override
  Future<void> clear() async {
    debugPrint('clearing $this');
    for (final col in Meta.allStorageKeys.values) {
      colStreams[col]?.close();
      colStreams.remove(col);
      final docs = await storage.collection(col).get();
      if (docs == null) {
        continue;
      }
      debugPrint('clearing $col');
      for (final doc in docs.entries) {
        if (doc.key.length < col.length + 2) {
          continue;
        }
        final key = doc.key.substring(col.length + 2);
        docStreams[key]?.close();
        docStreams.remove(key);
        await storage.collection(col).doc(key).delete();
        debugPrint('Deleted $col/$key');
      }
    }
  }
}
