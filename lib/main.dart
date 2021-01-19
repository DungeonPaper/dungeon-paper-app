import 'dart:async';
import 'package:dungeon_paper/db/db.dart';
import 'package:dungeon_paper/src/flutter_utils/on_init_caller.dart';
import 'package:dungeon_paper/src/pages/scaffold/main_view.dart';
import 'package:dungeon_paper/src/utils/analytics.dart';
import 'package:dungeon_paper/src/utils/error_reporting.dart';
import 'package:dungeon_paper/src/utils/logger.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pedantic/pedantic.dart';

import 'themes/themes.dart';

void withInit(Function() cb) async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    Themes.init();
    if (!kIsWeb) {
      unawaited(initErrorReporting());
    }
    runZonedGuarded(cb, reportError);
  } catch (e) {
    logger.e(e);
    rethrow;
  }
}

void main() async {
  await initApp(web: kIsWeb);
  withInit(() {
    // TODO AppInit
    runApp(DungeonPaper());
  });
}

class DungeonPaper extends StatelessWidget {
  final PageController _pageController = PageController(initialPage: 0);
  final FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return OnInitCaller(
      onInit: () => analytics.logAppOpen(),
      child: GetMaterialApp(
        title: 'Dungeon Paper',
        theme: Themes.currentTheme,
        routes: {
          '/': (ctx) => MainContainer(pageController: _pageController),
        },
        navigatorObservers: [observer],
      ),
    );
  }
}
