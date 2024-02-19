part of 'storage_handler.dart';

typedef DocData = Map<String, dynamic>;

class StorageHandler implements StorageDelegate {
  static StorageHandler? _instance;
  static StorageHandler get instance => _instance ??= StorageHandler();
  static const defaultRetryCount = 3;
  static const defaultRetryDelay = Duration(seconds: 2);

  static final _firestore = FirestoreDelegate();
  static final _firestoreGlobal = FirestoreDelegate();
  static final _local = LocalStorageDelegate();

  String currentDelegate = 'local';

  Map<String, StorageDelegate Function()> get delegates => {
        'local': () => local,
        'firestore': () => firestore,
        'firestoreGlobal': () => firestoreGlobal,
      };

  FirestoreDelegate get firestore => _firestore;
  FirestoreDelegate get firestoreGlobal => _firestoreGlobal;
  LocalStorageDelegate get local => _local;

  StorageDelegate get delegate => delegates[currentDelegate]!.call();

  @override
  bool enableRetry(e) => delegate.enableRetry(e);

  @override
  String? _collectionPrefix;

  @override
  String? get collectionPrefix => delegate.collectionPrefix;

  @override
  void setCollectionPrefix(String? prefix) =>
      delegate.setCollectionPrefix(prefix);

  Future<T> withRetry<T>(
    Future<T> Function() action, {
    String? debugLabel,
    int? retryCount,
    Duration? retryDelay,
  }) async {
    retryCount ??= defaultRetryCount;
    retryDelay ??= defaultRetryDelay;
    var count = 0;
    while (true) {
      try {
        return await action();
      } catch (e) {
        debugLabel ??= '$action';
        if (!enableRetry(e) || count >= retryCount) {
          rethrow;
        }
        debugPrint(
            'Failed to execute action: $debugLabel, retrying in: ${retryDelay.inSeconds} seconds, attempt: $count');
        await Future.delayed(retryDelay);
        count++;
      }
    }
  }

  @override
  Future<DocData?> getDocument(
    String collection,
    String document, {
    int? retryCount,
    Duration? retryDelay,
  }) {
    debugPrint('Get document: $collection/$document');
    return withRetry(
      () => delegate.getDocument(collection, document),
      debugLabel: 'Get document: $collection/$document',
      retryCount: retryCount,
      retryDelay: retryDelay,
    );
  }

  @override
  Future<void> create(
    String collection,
    String document,
    DocData value, {
    int? retryCount,
    Duration? retryDelay,
  }) {
    debugPrint('Create document: $collection/$document');
    return withRetry(
      () => delegate.create(collection, document, value),
      debugLabel: 'Create document: $collection/$document',
      retryCount: retryCount,
      retryDelay: retryDelay,
    );
  }

  @override
  Future<List<DocData>> getCollection(
    String collection, {
    int? retryCount,
    Duration? retryDelay,
  }) {
    debugPrint('Get collection: $collection');
    return withRetry(
      () => delegate.getCollection(collection),
      debugLabel: 'Get collection: $collection',
      retryCount: retryCount,
      retryDelay: retryDelay,
    );
  }

  @override
  Future<void> delete(
    String collection,
    String document, {
    int? retryCount,
    Duration? retryDelay,
  }) {
    debugPrint('Delete document: $collection/$document');
    return withRetry(
      () => delegate.delete(collection, document),
      debugLabel: 'Delete document: $collection/$document',
      retryCount: retryCount,
      retryDelay: retryDelay,
    );
  }

  @override
  Future<void> clear() => delegate.clear();

  @override
  Future<void> update(
    String collection,
    String document,
    DocData value, {
    int? retryCount,
    Duration? retryDelay,
  }) {
    debugPrint('Update document: $collection/$document');
    return withRetry(
      () => delegate.update(collection, document, value),
      debugLabel: 'Update document: $collection/$document',
      retryCount: retryCount,
      retryDelay: retryDelay,
    );
  }

  @override
  StreamSubscription<List<DocData>> collectionListener(
    String collection,
    void Function(List<DocData> data)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    debugPrint('Listen to collection: $collection');
    return delegate.collectionListener(collection, onData,
        onError: onError, onDone: onDone, cancelOnError: cancelOnError);
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
    debugPrint('Listen to document: $collection/$document');
    return delegate.documentListener(collection, document, onData,
        onError: onError, onDone: onDone, cancelOnError: cancelOnError);
  }
}

