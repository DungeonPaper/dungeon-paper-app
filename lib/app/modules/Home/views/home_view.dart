import 'dart:math';

import 'package:dungeon_paper/app/data/models/note.dart';
import 'package:dungeon_paper/app/data/services/loading_service.dart';
import 'package:dungeon_paper/app/data/services/user_service.dart';
import 'package:dungeon_paper/app/model_utils/character_utils.dart';
import 'package:dungeon_paper/app/model_utils/model_pages.dart';
import 'package:dungeon_paper/app/modules/Home/views/home_app_bar.dart';
import 'package:dungeon_paper/app/modules/Home/views/home_character_actions_view.dart';
import 'package:dungeon_paper/app/modules/Home/views/home_character_journal_view.dart';
import 'package:dungeon_paper/app/modules/Home/views/home_loader_view.dart';
import 'package:dungeon_paper/app/widgets/atoms/advanced_floating_action_button.dart';
import 'package:dungeon_paper/core/dw_icons.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../generated/l10n.dart';
// import '../../../widgets/atoms/debug_menu.dart';
import '../../../data/services/character_service.dart';
import 'home_character_view.dart';
import 'home_fab.dart';
import 'home_nav_bar.dart';

class HomeView extends GetView<CharacterService> with UserServiceMixin, LoadingServiceMixin {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: Obx(
        () => loadingService.loadingUser || loadingService.loadingCharacters
            ? const HomeLoaderView()
            : PageView(
                controller: controller.pageController,
                children: const [
                  HomeCharacterActionsView(),
                  HomeCharacterView(),
                  HomeCharacterJournalView(),
                ],
              ),
      ),
      floatingActionButton: Obx(
        () => userService.isLoggedIn ? const HomeFAB() : Container(),
      ),
      bottomNavigationBar: HomeNavBar(pageController: controller.pageController),
    );
  }
}
