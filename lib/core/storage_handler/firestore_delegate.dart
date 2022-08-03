part of 'storage_handler.dart';

class FirestoreDelegate extends StorageDelegate {
  final storage = FirebaseFirestore.instance;

  String get prefix => _collectionPrefix != null ? _collectionPrefix! + '/' : '';

  @override
  Future<List<DocData>> getCollection(String collection) => storage
      .collection(prefix + collection)
      .get()
      .then((list) => list.docs.map((snap) => snap.data()).toList());

  @override
  Future<DocData?> getDocument(String collection, String document) =>
      storage.collection(prefix + collection).doc(document).get().then((snap) => snap.data());

  @override
  Future<void> create(String collection, String document, DocData value) =>
      storage.collection(prefix + collection).doc(document).set(value, fs.SetOptions(merge: true));

  @override
  Future<void> delete(String collection, String document) =>
      storage.collection(prefix + collection).doc(document).delete();

  @override
  Future<void> update(String collection, String document, DocData value) =>
      storage.collection(prefix + collection).doc(document).update(value);

  @override
  StreamSubscription<List<DocData>> collectionListener(
    String collection,
    void Function(List<DocData> data)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return asCollectionStream(storage.collection(prefix + collection).snapshots()).listen(
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
    return asDocumentStream(storage.collection(prefix + collection).doc(document).snapshots())
        .listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }

  Stream<DocData?> asDocumentStream(Stream<DocumentSnapshot<DocData?>> source) async* {
    try {
      await for (final snap in source) {
        yield snap.data();
      }
    } catch (e) {
      yield null;
    }
  }

  Stream<List<DocData>> asCollectionStream(Stream<QuerySnapshot<DocData>> source) async* {
    try {
      await for (final query in source) {
        yield query.docs.map((doc) => doc.data()).toList();
      }
    } catch (e) {
      yield [];
    }
  }

  @override
  Future<void> clear() async {
    debugPrint('FirestoreDelegate.clear() was attempted.');
  }
}
