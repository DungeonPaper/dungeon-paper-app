import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/services/loading_service.dart';
import 'package:dungeon_paper/app/data/services/user_service.dart';
import 'package:dungeon_paper/app/modules/Home/views/home_app_bar.dart';
import 'package:dungeon_paper/app/modules/Home/views/home_character_actions_view.dart';
import 'package:dungeon_paper/app/modules/Home/views/home_character_journal_view.dart';
import 'package:dungeon_paper/app/modules/Home/views/home_loader_view.dart';
import 'package:dungeon_paper/app/routes/app_pages.dart';
import 'package:dungeon_paper/app/themes/button_themes.dart';
import 'package:dungeon_paper/app/widgets/atoms/icon_span.dart';
import 'package:dungeon_paper/app/widgets/atoms/page_controller_fractional_box.dart';
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
        () {
          const children = [
            HomeCharacterActionsView(),
            HomeCharacterView(),
            HomeCharacterJournalView(),
          ];

          return isLoading
              ? const HomeLoaderView()
              : maybeChar != null
                  ? PageView(
                      controller: controller.pageController,
                      children: children.map(_fractionalSizedBox).toList(),
                    )
                  : const HomeEmptyState();
        },
      ),
      floatingActionButton: Obx(
        () =>
            userService.isLoggedIn && maybeChar != null ? const HomeFAB() : const SizedBox.shrink(),
      ),
      bottomNavigationBar: Obx(
        () => maybeChar != null
            ? HomeNavBar(pageController: controller.pageController)
            : const SizedBox.shrink(),
      ),
    );
  }

  PageControllerFractionalBox _fractionalSizedBox(Widget child) => PageControllerFractionalBox(
        controller: controller.pageController,
        child: child,
      );

  bool get isLoading {
    debugPrint('afterFirstLoad: ${loadingService.afterFirstLoad}, '
        'loadingUser: ${loadingService.loadingUser}, '
        'loadingCharacters: ${loadingService.loadingCharacters}');
    return !loadingService.afterFirstLoad &&
        (loadingService.loadingUser || loadingService.loadingCharacters);
  }
}

class HomeEmptyState extends StatelessWidget with UserServiceMixin {
  const HomeEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (user.isGuest) ...[
              SizedBox(
                width: 500,
                child: Card(
                  margin: const EdgeInsets.all(32),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                    child: Column(
                      children: [
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              IconSpan(context, icon: Icons.person, size: 24),
                              TextSpan(text: ' ' + S.current.homeEmptyStateLoginTitle),
                            ],
                            style: textTheme.titleLarge,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          S.current.homeEmptyStateLoginSubtitle,
                          style: textTheme.titleMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          label: Text(S.current.signinButton),
                          icon: const Icon(Icons.login),
                          onPressed: () => Get.toNamed(Routes.login),
                          style: ButtonThemes.primaryElevated(context),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Divider(height: 32),
              const SizedBox(height: 16),
            ],
            Text(
              S.current.homeEmptyStateTitle,
              style: textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              S.current.homeEmptyStateSubtitle,
              style: textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              label: Text(S.current.createGeneric(S.current.entity(Character))),
              icon: const Icon(Icons.person_add),
              onPressed: () => Get.toNamed(Routes.createCharacter),
            ),
          ],
        ),
      ),
    );
  }
}
