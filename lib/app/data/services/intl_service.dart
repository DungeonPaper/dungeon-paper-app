import 'package:dungeon_paper/core/platform_helper.dart';
import 'package:flutter/material.dart';
import 'package:system_date_time_format/system_date_time_format.dart';

import '../../../i18n/messages.i18n.dart';
import '../../../i18n/messages_pt_BR.i18n.dart';

class Locales {
  static const enUS = Locale('en', 'US');
  static const ptBR = Locale('pt', 'BR');
}

class IntlService extends ChangeNotifier {
  static final Map<Locale, Messages> _m = {};
  static Locale _locale = Locales.enUS;
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
    if (PlatformHelper.isWeb) {
      return;
    }
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

  static final map = {
    Locales.enUS: () => const Messages(),
    Locales.ptBR: () => const MessagesPtBR(),
  };

  static Messages _loadMessages(Locale locale) {
    _m[locale] = map[locale]?.call() ?? const Messages();
    _locale = locale;
    return _m[locale]!;
  }
}
