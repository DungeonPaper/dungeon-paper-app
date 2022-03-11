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
      ),
      body: PageView(
        controller: controller.pageController,
        children: const [
          Center(child: Text('Actions')),
          HomeCharacterView(),
          Center(child: Text('Journal')),
        ],
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
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Actions',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Character',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Journal',
        ),
      ],
    );
  }
}
