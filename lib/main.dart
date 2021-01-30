import 'dart:async';
import 'package:dungeon_paper/db/db.dart';
import 'package:dungeon_paper/src/controllers/characters_controller.dart';
import 'package:dungeon_paper/src/dialogs/dialogs.dart';
import 'package:dungeon_paper/src/flutter_utils/on_init_caller.dart';
import 'package:dungeon_paper/src/pages/account_view/account_view.dart';
import 'package:dungeon_paper/src/pages/backup_view/backup_view.dart';
import 'package:dungeon_paper/src/pages/custom_classes_view/custom_classes_view.dart';
import 'package:dungeon_paper/src/pages/edit_character/edit_character_view.dart';
import 'package:dungeon_paper/src/pages/scaffold/main_view.dart';
import 'package:dungeon_paper/src/controllers/prefs_controller.dart';
import 'package:dungeon_paper/src/pages/settings_view/settings_view.dart';
import 'package:dungeon_paper/src/scaffolds/add_inventory_item_scaffold.dart';
import 'package:dungeon_paper/src/scaffolds/add_move_scaffold.dart';
import 'package:dungeon_paper/src/scaffolds/add_spell_scaffold.dart';
import 'package:dungeon_paper/src/scaffolds/custom_class_wizard/custom_class_wizard.dart';
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
    prefsController.loadAll();
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
          '/add-move': (ctx) => AddMoveScreen.createForCharacter(
                character: characterController.current,
              ),
          '/add-spell': (ctx) => AddSpellScaffold.createForCharacter(
                character: characterController.current,
              ),
          '/add-item': (ctx) => AddInventoryItemScaffold.createForCharacter(
                character: characterController.current,
              ),
          '/custom-classes': (ctx) => CustomClassesView(),
          '/account': (ctx) => AccountView(),
          '/create-custom-class': (ctx) =>
              CustomClassWizard(mode: DialogMode.create),
          '/create-character': (ctx) => EditCharacterView(
                character: null,
                mode: DialogMode.create,
              ),
          '/settings': (ctx) => SettingsView(),
          '/settings/backup': (ctx) => BackupView(),
        },
        navigatorObservers: [observer],
      ),
    );
  }
}
