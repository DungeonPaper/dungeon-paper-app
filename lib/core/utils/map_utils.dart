extension MapUtils<K, V> on Map<K, V> {
  Map<V, K> get inverse => Map.fromEntries(entries.map((ent) => MapEntry(ent.value, ent.key)));
}
