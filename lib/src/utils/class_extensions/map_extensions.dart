extension Inverse<K, V> on Map<K, V> {
  Map<V, K> get inverse => {
        for (var entry in entries) entry.value: entry.key,
      };
}
