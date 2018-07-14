class DbBase {
  final Map defaultData = {};
  Map _map = new Map();

  DbBase([Map map = const {}]) {
    _map = map != null ? map : new Map();

    defaultData.forEach((key, val) {
      if (!_map.containsKey(key) || _map[key] == null) {
        set(key, defaultData[key]);
      }
    });
  }

  operator [](String key) {
    return _map[key];
  }

  operator []=(String key, dynamic value) {
    return _map[key] = value;
  }

  set<T>(String key, T value) {
    _map[key] = value;
  }

  get<T>(String key, [defaultVal]) {
    // if (defaultVal == null) {
    //   defaultVal = defaultData[key];
    // }

    if (_map == null) {
      return defaultVal;
    }

    final T value = _map[key];

    if (value == null) {
      return defaultVal;
    }
    return value;
  }

  get map => _map;
}
