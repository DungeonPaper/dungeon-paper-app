import 'dart:async';
import 'package:dungeon_paper/db/db.dart';
import 'package:dungeon_paper/src/flutter_utils/on_init_caller.dart';
import 'package:dungeon_paper/src/pages/scaffold/main_view.dart';
import 'package:dungeon_paper/src/redux/stores.dart';
import 'package:dungeon_paper/src/utils/analytics.dart';
import 'package:dungeon_paper/src/utils/error_reporting.dart';
import 'package:dungeon_paper/src/utils/logger.dart';
import 'package:dungeon_paper/themes/main_theme.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pedantic/pedantic.dart';
import 'package:theme_provider/theme_provider.dart';

void withInit(Function() cb) async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
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
    dwStore.dispatch(AppInit());
    runApp(DungeonPaper());
  });
}

class DungeonPaper extends StatelessWidget {
  final PageController _pageController = PageController(initialPage: 0);
  final FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    const appName = 'Dungeon Paper';

    return ThemeProvider(
      defaultThemeId: 'normal',
      themes: [
        AppTheme(id: 'normal', data: mainTheme, description: 'Normal theme'),
        AppTheme(
            id: 'normal_2', data: mainTheme, description: 'Normal theme 2'),
      ],
      child: StoreProvider<DWStore>(
        store: dwStore,
        child: OnInitCaller(
          onInit: () => analytics.logAppOpen(),
          child: ThemeConsumer(
            child: Builder(
              builder: (context) => MaterialApp(
                title: appName,
                theme: ThemeProvider.themeOf(context).data,
                routes: {
                  '/': (ctx) => MainContainer(
                        title: appName,
                        pageController: _pageController,
                      ),
                },
                navigatorObservers: [observer],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
