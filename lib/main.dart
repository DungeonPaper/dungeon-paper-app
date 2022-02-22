import 'package:dungeon_paper/app/routes/app_pages.dart';
import 'package:dungeon_paper/app/data/services/services.dart';
import 'package:dungeon_paper/core/shared_preferences.dart';
import 'package:dungeon_paper/generated/intl/messages_all.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wakelock/wakelock.dart';

import 'app/themes/themes.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeMessages('en');
  await S.load(const Locale('en', 'US'));
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await loadSharedPrefs();
  Wakelock.toggle(enable: true);
  await initServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      themeCollection: themeCollection,
      defaultThemeId: prefs.getInt('selectedThemeId')!,
      builder: (context, value) {
        // key: Key(DynamicTheme.of(context)?.themeId.toString() ?? 'none'),
        return GetMaterialApp(
          // key: Key(DynamicTheme.of(context)?.themeId.toString() ?? ""),
          title: S.current.appName,
          theme: value,
          initialRoute: AppPages.initial,
          getPages: AppPages.routes,
        );
      },
    );
  }
}
