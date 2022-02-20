import 'package:dungeon_paper/app/routes/app_pages.dart';
import 'package:dungeon_paper/app/widgets/atoms/value_notifier_builder.dart';
import 'package:dungeon_paper/generated/intl/messages_all.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'app/themes/parchment_theme.dart';
import 'firebase_options.dart';
import 'core/storage_handler/storage_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeMessages('en');
  await S.load(const Locale("en", "US"));
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final theme = ValueNotifier<ThemeData>(parchmentTheme);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueNotifierBuilder(
      value: theme,
      builder: (context, value) {
        return GetMaterialApp(
          title: S.current.appName,
          theme: value,
          initialRoute: AppPages.initial,
          getPages: AppPages.routes,
        );
      },
    );
  }
}
