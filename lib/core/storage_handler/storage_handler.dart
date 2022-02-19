import 'package:localstorage/localstorage.dart';

class StorageHandler implements StorageDelegate {
  String currentDelegate = 'local';

  final delegates = <String, StorageDelegate>{
    'local': LocalStorageDelegate(),
  };

  StorageDelegate get delegate => delegates[currentDelegate]!;

  @override
  Future<T> getItem<T>(String file, String key) => delegate.getItem(file, key);

  @override
  Future<void> setItem<T>(String file, String key, T value) => delegate.setItem(file, key, value);
}

abstract class StorageDelegate {
  Future<T> getItem<T>(String file, String key);
  Future<void> setItem<T>(String file, String key, T value);
}

class LocalStorageDelegate implements StorageDelegate {
  @override
  Future<T> getItem<T>(String file, String key) => LocalStorage(file).getItem(key);

  @override
  Future<void> setItem<T>(String file, String key, T value) =>
      LocalStorage(file).setItem(key, value);
}

class FirebaseDelegate implements StorageDelegate {
  final dynamic _fb = null;
  String? _pathPrefix;

  void setPathPrefix(String? prefix) => _pathPrefix = prefix;

  @override
  Future<T> getItem<T>(String file, String key) =>
      _fb.doc((_pathPrefix ?? "") + file).get().then((snap) => snap.data());

  @override
  Future<void> setItem<T>(String file, String key, T value) async {
    var doc = await _fb.doc((_pathPrefix ?? "") + file).get();
    if (!doc.exists) {
      return doc.set(value);
    }
    return doc.update(value);
  }
}
