import 'package:flutter/material.dart';

import '../../../i18n/messages.i18n.dart';

class IntlService extends ChangeNotifier {
  static final Map<Locale, Messages> _m = {};
  static Locale _locale = const Locale('en');
  static Locale get locale => _locale;

  static Messages get m => _m[locale] ?? _loadMessages(_locale);
  List<Locale> get supportedLocales => _m.keys.toList();

  IntlService() {
    _loadMessages(locale);
  }

  static void changeLocale(Locale locale) {
    _loadMessages(locale);
  }

  static Messages _loadMessages(Locale locale) {
    final map = {
      const Locale('en'): () => const Messages(),
    };

    _m[locale] = map[locale]?.call() ?? const Messages();
    _locale = locale;
    return _m[locale]!;
  }
}
