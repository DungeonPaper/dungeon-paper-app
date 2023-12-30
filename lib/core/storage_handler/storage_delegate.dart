part of 'storage_handler.dart';

abstract class StorageDelegate {
  String? _collectionPrefix;
  String? get collectionPrefix => _collectionPrefix;
  bool enableRetry(_) => false;

  void setCollectionPrefix(String? prefix) {
    debugPrint('Set collection prefix: $prefix for $this');
    _collectionPrefix = prefix;
  }

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
  Future<void> clear();
}
