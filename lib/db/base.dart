class DbBase {
  final Map defaultData = {};
  Map _map = Map();

  DbBase([Map map = const {}]) {
    _map = map != null ? map : Map();

    defaultData.forEach((key, val) {
      if (!_map.containsKey(key) || _map[key] == null) {
        set(key, defaultData[key]);
      }
    });
  }

  operator [](String key) {
    return get(key);
  }

  operator []=(String key, dynamic value) {
    return set(key, value);
  }

  void set<T>(String key, T value) {
    _map[key] = value;
  }

  get<T>(String key, [defaultVal]) {
    // if (defaultVal == null) {
    //   defaultVal = defaultData[key];
    // }

    if (_map == null) {
      return defaultVal;
    }

    var value = _map[key];

    if (value == null) {
      return defaultVal;
    }

    return value;
  }

  get map => _map;
}
