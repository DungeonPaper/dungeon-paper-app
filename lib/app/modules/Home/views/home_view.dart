import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/services/loading_service.dart';
import 'package:dungeon_paper/app/data/services/user_service.dart';
import 'package:dungeon_paper/app/modules/Home/views/home_app_bar.dart';
import 'package:dungeon_paper/app/modules/Home/views/home_character_actions_view.dart';
import 'package:dungeon_paper/app/modules/Home/views/home_character_journal_view.dart';
import 'package:dungeon_paper/app/modules/Home/views/home_loader_view.dart';
import 'package:dungeon_paper/app/routes/app_pages.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

// import '../../../widgets/atoms/debug_menu.dart';
import '../../../data/services/character_service.dart';
import 'home_character_view.dart';
import 'home_fab.dart';
import 'home_nav_bar.dart';

class HomeView extends GetView<CharacterService>
    with UserServiceMixin, LoadingServiceMixin, CharacterServiceMixin {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: Obx(
        () => isLoading
            ? const HomeLoaderView()
            : maybeChar != null
                ? PageView(
                    controller: controller.pageController,
                    children: const [
                      HomeCharacterActionsView(),
                      HomeCharacterView(),
                      HomeCharacterJournalView(),
                    ],
                  )
                : const HomeEmptyState(),
      ),
      floatingActionButton: Obx(
        () => userService.isLoggedIn ? const HomeFAB() : Container(),
      ),
      bottomNavigationBar: HomeNavBar(pageController: controller.pageController),
    );
  }

  bool get isLoading {
    debugPrint('afterFirstLoad: ${loadingService.afterFirstLoad}, '
        'loadingUser: ${loadingService.loadingUser}, '
        'loadingCharacters: ${loadingService.loadingCharacters}');
    return !loadingService.afterFirstLoad &&
        (loadingService.loadingUser || loadingService.loadingCharacters);
  }
}

class HomeEmptyState extends StatelessWidget {
  const HomeEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(S.current.homeEmptyStateTitle, style: textTheme.headline6),
          const SizedBox(height: 16),
          Text(S.current.homeEmptyStateSubtitle, style: textTheme.subtitle1),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            label: Text(S.current.createGeneric(S.current.entity(Character))),
            icon: const Icon(Icons.person_add),
            onPressed: () => Get.toNamed(Routes.createCharacter),
          ),
        ],
      ),
    );
  }
}
