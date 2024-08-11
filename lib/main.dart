import 'package:dungeon_paper/app/data/services/auth_provider.dart';
import 'package:dungeon_paper/app/data/services/library_provider.dart';
import 'package:dungeon_paper/app/data/services/loading_provider.dart';
import 'package:dungeon_paper/app/data/services/repository_provider.dart';
import 'package:dungeon_paper/app/data/services/user_provider.dart';
import 'package:dungeon_paper/app/routes/app_pages.dart';
import 'package:dungeon_paper/core/global_keys.dart';
import 'package:dungeon_paper/core/multi_platform_scroll_behavior.dart';
import 'package:dungeon_paper/core/pref_keys.dart';
import 'package:dungeon_paper/core/remote_config.dart';
import 'package:dungeon_paper/core/shared_preferences.dart';
import 'package:dungeon_paper/core/window_manager.dart';
import 'package:dungeon_paper/core/utils/secrets_base.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:dungeon_world_data/base.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'app/data/services/character_provider.dart';
import 'app/data/services/intl_service.dart';
import 'app/themes/themes.dart';
import 'core/platform_helper.dart';
import 'firebase_options.dart';

void main() async {
  registerEntityTypeResolver(tn);
  if (secrets.sentryDsn.isEmpty) {
    await _init();
    return;
  }
  await SentryFlutter.init(
    (options) {
      options.dsn = secrets.sentryDsn;
      options.tracesSampleRate = kDebugMode ? 1.0 : 0.0;
      options.environment = kDebugMode ? 'development' : 'release';
    },
    appRunner: _init,
  );
}

Future<void> _init() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await loadSharedPrefs();
  await initRemoteConfig();
  if (!PlatformHelper.isWeb && PlatformHelper.isDesktop) {
    await windowInit();
  }
  FlutterNativeSplash.remove();
  runApp(const DungeonPaperApp());
}

final _loadingProvider = LoadingProvider();
final _authProvider = AuthProvider();
final _characterProvider = CharacterProvider();
final _userProvider = UserProvider();
final _repositoryProvider = RepositoryProvider();
final _libraryProvider = LibraryProvider();
final _intlService = IntlService();

class DungeonPaperApp extends StatelessWidget {
  const DungeonPaperApp({super.key});

  @override
  Widget build(BuildContext context) {
    final platformBrightness = getCurrentPlatformBrightness();
    final defaultTheme = platformBrightness == Brightness.light
        ? AppThemes.parchment
        : AppThemes.dark;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _intlService),
        ChangeNotifierProvider.value(value: _loadingProvider),
        ChangeNotifierProvider.value(value: _authProvider),
        ChangeNotifierProvider.value(value: _characterProvider),
        ChangeNotifierProvider.value(value: _userProvider),
        ChangeNotifierProvider.value(value: _repositoryProvider),
        ChangeNotifierProvider.value(value: _libraryProvider),
      ],
      child: DynamicTheme(
        themeCollection: themeCollection,
        defaultThemeId: prefs.getInt(PrefKeys.selectedThemeId) ?? defaultTheme,
        builder: (context, theme) => MaterialApp(
          scrollBehavior: MultiPlatformScrollBehavior(),
          title: tr.app.name,
          theme: theme,
          key: appGlobalKey,
          onGenerateRoute: AppPages.onGenerateRoute,
          initialRoute: AppPages.initial,
          navigatorKey: navigatorKey,
          scaffoldMessengerKey: scaffoldMessengerKey,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
