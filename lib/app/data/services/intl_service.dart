import 'package:dungeon_paper/core/global_keys.dart';
import 'package:dungeon_paper/core/platform_helper.dart';
import 'package:dungeon_paper/core/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:system_date_time_format/system_date_time_format.dart';

import '../../../i18n/messages.i18n.dart';
import '../../../i18n/messages_pt_BR.i18n.dart';

class Locales {
  static const enUS = Locale('en', 'US');
  static const ptBR = Locale('pt', 'BR');
}

class IntlService extends ChangeNotifier {
  static IntlService instance = IntlService();
  static final Map<Locale, Messages> _m = {};
  Locale _locale = Locales.enUS;
  Locale get locale => _locale;
  Locale get currentLocale => _locale;

  Messages get m => _m[locale] ?? _loadMessages(_locale);
  List<Locale> get supportedLocales => messageBuilders.keys.toList();

  String dateFormat = 'dd/MM/y';
  String timeFormat = 'H:mm';

  IntlService() {
    debugPrint('[INTL] Initializing IntlService');
    _loadDateTimeFormats();
  }

  static Consumer<IntlService> consumer(
    Widget Function(BuildContext, IntlService, Widget?) builder,
  ) =>
      Consumer<IntlService>(builder: builder);

  static Locale localeFromString(String locale) {
    final parts = locale.split('_');
    return Locale(parts.first, parts.last);
  }

  void changeLocale(Locale locale) {
    final messages = _loadMessages(locale);
    _locale = localeFromString(messages.locale);
    prefs.setString(PrefKeys.locale, locale.toString());
    final nav = Navigator.of(navigatorKey.currentContext!);
    nav.popUntil((route) => route.isFirst);
    nav.pushReplacementNamed('/');
  }

  void _loadDateTimeFormats() async {
    try {
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
    } catch (e, stack) {
      debugPrint('Error loading date formats: $e');
      Sentry.captureException(e, stackTrace: stack);
    }
  }

  static final messageBuilders = {
    Locales.enUS: () => const Messages(),
    Locales.ptBR: () => const MessagesPtBR(),
  };

  static Messages _loadMessages(Locale locale) {
    _m[locale] = messageBuilders[locale]?.call() ?? const Messages();
    return _m[locale]!;
  }

  loadLocale() {
    try {
      final prefLocale = prefs.getString(PrefKeys.locale);
      if (prefLocale != null) {
        _locale = localeFromString(prefLocale);
      }
    } catch (e, stack) {
      debugPrint('Error loading locale: $e');
      Sentry.captureException(e, stackTrace: stack);
    } finally {
      _loadMessages(_locale);
    }
  }
}
