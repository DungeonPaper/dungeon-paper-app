import 'dart:async';
import 'package:dungeon_paper/db/db.dart';
import 'package:dungeon_paper/src/pages/scaffold/main_view.dart';
import 'package:dungeon_paper/src/redux/stores.dart';
import 'package:dungeon_paper/src/utils/error_reporting.dart';
import 'package:dungeon_paper/themes/main_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:screen/screen.dart';

void withInit(Function() cb) async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    print('withInit');
    if (!kIsWeb) {
      await initErrorReporting();
      await Screen.keepOn(true);
    }
    runZonedGuarded(cb, reportError);
  } catch (e) {
    print(e);
    rethrow;
  }
}

void main() async {
  initApp(web: kIsWeb);
  withInit(() {
    runApp(DungeonPaper());
    dwStore.dispatch(AppInit());
  });
}

class DungeonPaper extends StatelessWidget {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    const appName = 'Dungeon Paper';

    return StoreProvider<DWStore>(
      store: dwStore,
      child: MaterialApp(
        title: appName,
        theme: mainTheme,
        routes: {
          '/': (ctx) => MainContainer(
                title: appName,
                pageController: _pageController,
              ),
        },
      ),
    );
  }
}
