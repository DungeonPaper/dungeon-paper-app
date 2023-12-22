import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/services/character_provider.dart';
import 'package:dungeon_paper/app/data/services/loading_provider.dart';
import 'package:dungeon_paper/app/data/services/user_provider.dart';
import 'package:dungeon_paper/app/modules/Home/views/home_app_bar.dart';
import 'package:dungeon_paper/app/modules/Home/views/home_character_actions_view.dart';
import 'package:dungeon_paper/app/modules/Home/views/home_character_journal_view.dart';
import 'package:dungeon_paper/app/modules/Home/views/home_loader_view.dart';
import 'package:dungeon_paper/app/routes/app_pages.dart';
import 'package:dungeon_paper/app/themes/button_themes.dart';
import 'package:dungeon_paper/app/widgets/atoms/icon_span.dart';
import 'package:dungeon_paper/app/widgets/atoms/page_controller_fractional_box.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_character_view.dart';
import 'home_fab.dart';
import 'home_nav_bar.dart';

class HomeView extends StatelessWidget
    with UserProviderMixin, LoadingProviderMixin, CharacterProviderMixin {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: Consumer2<CharacterProvider, LoadingProvider>(
        builder: (context, controller, loading, _) {
          const children = [
            HomeCharacterActionsView(),
            HomeCharacterView(),
            HomeCharacterJournalView(),
          ];

          return isLoading
              ? const HomeLoaderView()
              : controller.maybeCurrent != null
                  ? PageView(
                      controller: controller.pageController,
                      children: children.map(_fractionalSizedBox).toList(),
                    )
                  : const HomeEmptyState();
        },
      ),
      floatingActionButton: CharacterProvider.consumer(
        (context, controller, _) =>
            maybeChar != null ? const HomeFAB() : const SizedBox.shrink(),
      ),
      bottomNavigationBar: CharacterProvider.consumer(
        (context, controller, _) => maybeChar != null
            ? CharacterProvider.consumer((context, controller, _) =>
                HomeNavBar(pageController: controller.pageController))
            : const SizedBox.shrink(),
      ),
    );
  }

  Widget _fractionalSizedBox(Widget child) => CharacterProvider.consumer(
        (context, controller, _) => PageControllerFractionalBox(
          controller: controller.pageController,
          child: child,
        ),
      );

  bool get isLoading {
    debugPrint('afterFirstLoad: ${loadingProvider.afterFirstLoad}, '
        'loadingUser: ${loadingProvider.loadingUser}, '
        'loadingCharacters: ${loadingProvider.loadingCharacters}');
    return !loadingProvider.afterFirstLoad &&
        (loadingProvider.loadingUser || loadingProvider.loadingCharacters);
  }
}

class HomeEmptyState extends StatelessWidget with UserProviderMixin {
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 24, horizontal: 16),
                    child: Column(
                      children: [
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              IconSpan(context, icon: Icons.person, size: 24),
                              TextSpan(
                                  text: ' ${tr.home.emptyState.guest.title}'),
                            ],
                            style: textTheme.titleLarge,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          tr.home.emptyState.guest.subtitle,
                          style: textTheme.titleMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          label: Text(tr.auth.login.button),
                          icon: const Icon(Icons.login),
                          onPressed: () =>
                              Navigator.of(context).pushNamed(Routes.login),
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
              tr.home.emptyState.title,
              style: textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              tr.home.emptyState.subtitle,
              style: textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              label: Text(tr.generic.createEntity(tr.entity(tn(Character)))),
              icon: const Icon(Icons.person_add),
              onPressed: () =>
                  Navigator.of(context).pushNamed(Routes.createCharacter),
            ),
          ],
        ),
      ),
    );
  }
}
