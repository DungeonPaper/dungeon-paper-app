import 'package:dungeon_paper/app/routes/app_pages.dart';
import 'package:dungeon_paper/app/data/services/services.dart';
import 'package:dungeon_paper/core/multi_platform_scroll_behavior.dart';
import 'package:dungeon_paper/core/pref_keys.dart';
import 'package:dungeon_paper/core/remote_config.dart';
import 'package:dungeon_paper/core/shared_preferences.dart';
import 'package:dungeon_paper/core/utils/secrets_base.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/route_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'app/themes/themes.dart';
import 'firebase_options.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await loadSharedPrefs();
  await initRemoteConfig();
  await initServices();
  if (secrets.sentryDsn.isEmpty) {
    FlutterNativeSplash.remove();
    runApp(const DungeonPaperApp());
    return;
  }
  await SentryFlutter.init(
    (options) {
      options.dsn = secrets.sentryDsn;
      // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
      // We recommend adjusting this value in production.
      options.tracesSampleRate = kDebugMode ? 1.0 : 0.5;
      options.environment = kDebugMode ? 'development' : 'release';
    },
    appRunner: () {
      FlutterNativeSplash.remove();
      runApp(const DungeonPaperApp());
    },
  );
}

class DungeonPaperApp extends StatelessWidget {
  const DungeonPaperApp({super.key});

  @override
  Widget build(BuildContext context) {
    final platformBrightness = getCurrentPlatformBrightness();
    final defaultTheme = platformBrightness == Brightness.light
        ? AppThemes.parchment
        : AppThemes.dark;

    return DynamicTheme(
      themeCollection: themeCollection,
      defaultThemeId: prefs.getInt(PrefKeys.selectedThemeId) ?? defaultTheme,
      builder: (context, value) {
        return GetMaterialApp(
          scrollBehavior: MultiPlatformScrollBehavior(),
          title: tr.app.name,
          theme: value,
          initialRoute: AppPages.initial,
          getPages: AppPages.routes,
        );
      },
    );
  }
}

