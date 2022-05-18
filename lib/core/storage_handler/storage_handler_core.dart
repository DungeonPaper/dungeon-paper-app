part of 'storage_handler.dart';

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
