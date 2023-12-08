typedef Locale = String;

class LocalizedRepository<T> {
  final collections = <String, LocalizedCollection<T>>{};
  Locale currentLocale;

  LocalizedRepository([this.currentLocale = 'en']);

  setLocale(Locale locale) => currentLocale = locale;

  LocalizedItem<T> operator [](String key) => forLocale(currentLocale, key);

  LocalizedItem<T> forLocale(Locale locale, String key,
      {bool throwOnMissing = false}) {
    if (throwOnMissing && collections[key] == null) {
      throw StateError('Key $key not found');
    }

    final coll = collections[key] ??= LocalizedCollection<T>();

    if (throwOnMissing && !coll.localeExists(locale)) {
      throw StateError('Locale $locale not found for key $key');
    }

    return coll[locale];
  }

  void operator []=(String key, T item) {
    final coll = collections[key] ??= LocalizedCollection<T>();
    coll[currentLocale].data = item;
  }

  void loadData(Map<String, Map<String, T>> localeToValueMapping) {
    for (final locale in localeToValueMapping.entries) {
      for (final list in locale.value.entries) {
        final repo = forLocale(locale.key, list.key);
        repo.data = list.value;
      }
    }
  }
}

class LocalizedCollection<T> {
  final locales = <String, LocalizedItem<T>>{};
  LocalizedItem<T> operator [](Locale locale) =>
      locales[locale] ??= LocalizedItem<T>();
  void operator []=(String key, T item) => locales[key] ??= LocalizedItem<T>();

  bool localeExists(Locale locale) => locales.containsKey(locale);
}

class LocalizedItem<T> {
  late T data;
}
