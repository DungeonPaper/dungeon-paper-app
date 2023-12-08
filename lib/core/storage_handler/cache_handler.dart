part of 'storage_handler.dart';

class CacheHandler extends StorageHandler {
  static LocalStorageDelegate? _instance;
  static LocalStorageDelegate get instance =>
      _instance ??= LocalStorageDelegate();

  @override
  String get currentDelegate => 'local';
}
