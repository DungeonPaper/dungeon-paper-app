import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../i18n/messages.i18n.dart';

class IntlService extends GetxService {
  static final Map<Locale, Messages> _m = {};
  static late Locale _locale;

  static Messages get m => _m[Get.locale] ?? _loadMessages(_locale);
  List<Locale> get supportedLocales => _m.keys.toList();

  @override
  void onInit() {
    super.onInit();
    _loadMessages(Get.deviceLocale ?? const Locale('en'));
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

