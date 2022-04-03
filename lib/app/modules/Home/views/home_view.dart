import 'package:dungeon_paper/app/data/models/note.dart';
import 'package:dungeon_paper/app/model_utils/character_utils.dart';
import 'package:dungeon_paper/app/modules/Home/views/home_character_actions_view.dart';
import 'package:dungeon_paper/app/modules/Home/views/home_character_journal_view.dart';
import 'package:dungeon_paper/app/themes/colors.dart';
import 'package:dungeon_paper/app/widgets/atoms/user_menu.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../generated/l10n.dart';
import '../../../widgets/atoms/debug_menu.dart';
import '../../../data/services/character_service.dart';
import 'home_character_view.dart';

class HomeView extends GetView<CharacterService> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.appName),
        actions: const [
          DebugMenu(),
          UserMenu(),
        ],
        automaticallyImplyLeading: false,
      ),
      body: PageView(
        controller: controller.pageController,
        children: const [
          HomeCharacterActionsView(),
          HomeCharacterView(),
          HomeCharacterJournalView(),
        ],
      ),
      floatingActionButton: Obx(
        () {
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
              child: FloatingActionButton.extended(
                label: Text(S.current.createGeneric(Note)),
                icon: const Icon(Icons.add),
                backgroundColor: DwColors.success,
                onPressed: inPageRange
                    ? CharacterUtils.openNotePage(
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
      ),
      bottomNavigationBar: Obx(
        () => CharacterHomeNavBar(pageController: controller.pageController),
      ),
    );
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
    return BottomNavigationBar(
      currentIndex: widget.pageController.positions.length == 1
          ? widget.pageController.page?.round() ?? 1
          : 1,
      onTap: (page) => widget.pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutQuad,
      ),
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.person),
          label: S.current.navActions,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.person),
          label: S.current.navCharacter,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.person),
          label: S.current.navJournal,
        ),
      ],
    );
  }
}
