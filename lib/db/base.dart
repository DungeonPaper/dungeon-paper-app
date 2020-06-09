abstract class Serializer<K extends dynamic> {
  Map<String, dynamic> toJSON();
  Map<K, Function(dynamic value)> serializeMap;

  dynamic serialize(K key, [dynamic value]) {
    if (serializeMap.containsKey(key)) {
      serializeMap[key](value);
    } else {
      throw ('No serializeMap key for corresponding key.');
    }
  }

  dynamic serializeAll([Map map]) {
    (map ?? serializeMap).forEach((k, v) {
      serialize(k, map[k]);
    });
  }

  /// When overriding this method, you must also call it in your constructor */
  void initSerializeMap([Map map]);
}
