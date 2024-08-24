import 'package:dungeon_paper/core/shared_preferences.dart';
import 'package:window_manager/window_manager.dart';
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
import 'package:easy_debounce/easy_debounce.dart';

import 'home_character_view.dart';
import 'home_fab.dart';
import 'home_nav_bar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with
        UserProviderMixin,
        LoadingProviderMixin,
        CharacterProviderMixin,
        WindowListener {

  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: Consumer2<CharacterProvider, LoadingProvider>(
        builder: (context, controller, loading, _) {
          return _isLoading
              ? const HomeLoaderView()
              : controller.maybeCurrent != null
                  ? const HomePageView()
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

  bool get _isLoading {
    debugPrint('afterFirstLoad: ${loadingProvider.afterFirstLoad}, '
        'loadingUser: ${loadingProvider.loadingUser}, '
        'loadingCharacters: ${loadingProvider.loadingCharacters}');
    return !loadingProvider.afterFirstLoad &&
        (loadingProvider.loadingUser || loadingProvider.loadingCharacters);
  }

  @override
  onWindowBlur() {
    debugPrint('Window blurred');
  }

  @override
  void onWindowFocus() {
    debugPrint('Window focused');
  }

  @override
  void onWindowMove() {
    EasyDebounce.debounce(
      'windowMove',
      const Duration(milliseconds: 500),
      () async {
        final position = await windowManager.getPosition();
        debugPrint('Window moved to $position');
        prefs.setInt('windowX', position.dx.toInt());
        prefs.setInt('windowY', position.dy.toInt());
      },
    );
  }

  @override
  void onWindowResize() async {
    EasyDebounce.debounce(
      'windowResize',
      const Duration(milliseconds: 500),
      () async {
        final size = await windowManager.getSize();
        debugPrint('Window resized to $size');
        prefs.setInt('windowWidth', size.width.toInt());
        prefs.setInt('windowHeight', size.height.toInt());
      },
    );
  }
}

class HomePageView extends StatelessWidget with LoadingProviderMixin {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<CharacterProvider, LoadingProvider>(
      builder: (context, controller, loading, _) {
        const children = [
          HomeCharacterActionsView(),
          HomeCharacterView(),
          HomeCharacterJournalView(),
        ];

        return PageView(
          controller: controller.pageController,
          children: children.map(_fractionalSizedBox).toList(),
        );
      },
    );
  }

  Widget _fractionalSizedBox(Widget child) => CharacterProvider.consumer(
        (context, controller, _) => PageControllerFractionalBox(
          controller: controller.pageController,
          child: child,
        ),
      );
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
