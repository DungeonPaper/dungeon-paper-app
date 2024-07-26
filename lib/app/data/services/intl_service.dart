import 'package:flutter/material.dart';
import 'package:system_date_time_format/system_date_time_format.dart';

import '../../../i18n/messages.i18n.dart';

class IntlService extends ChangeNotifier {
  static final Map<Locale, Messages> _m = {};
  static Locale _locale = const Locale('en');
  static Locale get locale => _locale;

  static Messages get m => _m[locale] ?? _loadMessages(_locale);
  static List<Locale> get supportedLocales => _m.keys.toList();

  static String dateFormat = 'dd/MM/y';
  static String timeFormat = 'H:mm';

  IntlService() {
    debugPrint('[INTL] Initializing IntlService');
    _loadMessages(locale);
    _loadDateTimeFormats();
  }

  static void changeLocale(Locale locale) {
    _loadMessages(locale);
  }

  static void _loadDateTimeFormats() async {
    final fmt = SystemDateTimeFormat();
    final dtFormat = await fmt.getDatePattern();
    final tmFormat = await fmt.getTimePattern();

    if (dtFormat != null) {
      dateFormat = dtFormat;
    }
    if (tmFormat != null) {
      timeFormat = 'H:mm';
    }

    debugPrint('Fetched date formats:\n$dateFormat\n$timeFormat');
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
