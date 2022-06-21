import 'package:dungeon_paper/app/data/models/note.dart';
import 'package:dungeon_paper/app/data/services/loading_service.dart';
import 'package:dungeon_paper/app/data/services/user_service.dart';
import 'package:dungeon_paper/app/model_utils/character_utils.dart';
import 'package:dungeon_paper/app/model_utils/model_pages.dart';
import 'package:dungeon_paper/app/modules/Home/views/home_character_actions_view.dart';
import 'package:dungeon_paper/app/modules/Home/views/home_character_journal_view.dart';
import 'package:dungeon_paper/app/modules/Home/views/home_loader_view.dart';
import 'package:dungeon_paper/app/themes/themes.dart';
import 'package:dungeon_paper/app/widgets/atoms/advanced_floating_action_button.dart';
import 'package:dungeon_paper/app/widgets/atoms/user_menu.dart';
import 'package:dungeon_paper/core/dw_icons.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../generated/l10n.dart';
// import '../../../widgets/atoms/debug_menu.dart';
import '../../../data/services/character_service.dart';
import 'home_character_view.dart';

class HomeView extends GetView<CharacterService> with UserServiceMixin, LoadingServiceMixin {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Theme.of(context).brightness == Brightness.light
                  ? Icons.light_mode
                  : Icons.light_mode_outlined,
            ),
            onPressed: toggleTheme,
            tooltip: Theme.of(context).brightness == Brightness.light
                ? S.current.themeTurnDark
                : S.current.themeTurnLight,
          ),
          title: Text(S.current.appName),
          actions: const [
            // DebugMenu(),
            UserMenu(),
          ],
          automaticallyImplyLeading: false,
        ),
        body: loadingService.loadingUser || loadingService.loadingCharacters
            ? const HomeLoaderView()
            : PageView(
                controller: controller.pageController,
                children: const [
                  HomeCharacterActionsView(),
                  HomeCharacterView(),
                  HomeCharacterJournalView(),
                ],
              ),
        floatingActionButton: userService.isLoggedIn
            ? Builder(
                builder: (context) {
                  const pageNum = 2;

                  /// negative = page is going down
                  /// positive = page is going up
                  final direction = controller.page - controller.lastIntPage.toDouble();
                  final distance = direction.abs();
                  final inPageRange = direction >= 0.0
                      ? controller.page <= pageNum &&
                          controller.page > pageNum - 1 &&
                          (distance == 0.0 || distance >= 0.5)
                      : controller.page >= pageNum - 1 && (distance == 0.0 || distance <= 0.5);
                  const duration = Duration(milliseconds: 250);

                  return AnimatedScale(
                    scale: inPageRange ? 1.0 : 0.0,
                    duration: duration,
                    child: AnimatedOpacity(
                      opacity: inPageRange ? 1.0 : 0.0,
                      duration: duration,
                      child: AdvancedFloatingActionButton.extended(
                        label: Text(S.current.createGeneric(Note)),
                        icon: const Icon(Icons.add),
                        onPressed: inPageRange
                            ? ModelPages.openNotePage(
                                note: null,
                                onSave: (note) => controller.updateCharacter(
                                  CharacterUtils.addByType<Note>(controller.current!, [note]),
                                ),
                              )
                            : null,
                      ),
                    ),
                  );
                },
              )
            : null,
        bottomNavigationBar: Obx(
          () => CharacterHomeNavBar(pageController: controller.pageController),
        ),
      ),
    );
  }

  void toggleTheme() {
    var theme = DynamicTheme.of(Get.context!)!;
    theme.setTheme(theme.themeId == AppThemes.dark ? AppThemes.parchment : AppThemes.dark);
  }
}

class CharacterHomeNavBar extends StatefulWidget {
  const CharacterHomeNavBar({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  final PageController pageController;

  @override
  State<CharacterHomeNavBar> createState() => _CharacterHomeNavBarState();
}

class _CharacterHomeNavBarState extends State<CharacterHomeNavBar> {
  @override
  void initState() {
    super.initState();
    widget.pageController.addListener(_refreshState);
  }

  void _refreshState() {
    setState(() {});
  }

  @override
  void dispose() {
    widget.pageController.removeListener(_refreshState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var currentIndex =
        widget.pageController.positions.length == 1 ? widget.pageController.page?.round() ?? 1 : 1;

    final items = <String, Icon>{
      S.current.navActions: const Icon(DwIcons.hand_rock),
      S.current.navCharacter: const Icon(Icons.person),
      S.current.navJournal: const Icon(DwIcons.scroll_quill),
    };

    return Material(
      type: MaterialType.canvas,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: enumerate(items.keys)
            .map(
              (item) => Expanded(
                child: _NavItem(
                  icon: items[item.value]!,
                  label: item.value,
                  selected: currentIndex == item.index,
                  onTap: () => widget.pageController.animateToPage(
                    item.index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOutQuad,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final Widget icon;
  final String label;
  final bool selected;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final selectedColor = colorScheme.secondary;
    final selectedFgColor = theme.colorScheme.onSecondary;
    final unselectedFgColor = theme.colorScheme.onSurface;
    const duration = Duration(milliseconds: 250);

    return Material(
      child: InkWell(
        splashColor: Theme.of(context).colorScheme.secondary,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipPath(
                clipper: const ShapeBorderClipper(shape: StadiumBorder()),
                child: AnimatedContainer(
                  duration: duration,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: IconTheme(
                      child: icon,
                      data: IconThemeData(
                        color: selected ? selectedFgColor : unselectedFgColor,
                      ),
                    ),
                  ),
                  width: selected ? 60 : 40,
                  color: selected ? selectedColor : Colors.transparent,
                ),
              ),
              const SizedBox(height: 2),
              AnimatedDefaultTextStyle(
                duration: duration,
                style: theme.textTheme.caption!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: selected ? selectedColor : null,
                ),
                child: Text(
                  label,
                  textScaleFactor: 1.1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
