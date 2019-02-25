Map<String, dynamic> dbClassMap = {};

abstract class DbBase {
  final Map defaultData;
  Map<String, dynamic> _map = Map();
  Map<String, Function(dynamic any)> propertyMapping = {};
  List<String> listProperties = [];

  bool isListProperty(String key) => listProperties.contains(key);
  bool isMappedProperty(String key) => listProperties.contains(key);

  DbBase(
    Map map, {
    this.defaultData: const {},
    this.propertyMapping: const {},
    this.listProperties: const [],
  }) {
    _map = map != null ? Map.from(map) : Map();

    defaultData.forEach((key, val) {
      if (!_map.containsKey(key) || _map[key] == null) {
        set(key, defaultData[key]);
      }
    });

    propertyMapping.forEach((key, val) {
      if (_map[key].length > 0) {
        set(key, _map[key]);
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
    if (propertyMapping.containsKey(key)) {
      T Function(dynamic obj) mapper = propertyMapping[key];
      if (isListProperty(key)) {
        List<T> mappedList =
            List.from((value as List).map((i) => mapper(i))).toList();
        _map[key] = mappedList;
      } else {
        _map[key] = mapper(value);
      }

      return;
    }

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

  List<T> getList<T extends DbBase>(String key) =>
      List.from(get<List>(key, []));

  get map => Map.from(_map);

  Map toJSON();
}
