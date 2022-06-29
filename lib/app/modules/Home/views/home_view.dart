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
import 'home_nav_bar.dart';

class HomeView extends GetView<CharacterService> with UserServiceMixin, LoadingServiceMixin {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: const HomeAppBar(),
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
                  final direction = controller.page - pageNum.toDouble();
                  final distance = direction.abs();
                  final inPageRange = distance <= 0.5;
                  const duration = Duration(milliseconds: 250);

                  return AnimatedScale(
                    scale: inPageRange ? 1.0 : 0.0,
                    duration: duration,
                    child: AnimatedOpacity(
                      opacity: inPageRange ? 1.0 : 0.0,
                      duration: duration,
                      child: AdvancedFloatingActionButton.extended(
                        label: AnimatedScale(
                          scale: inPageRange ? 1.0 : 0.0,
                          duration: duration,
                          child: Text(
                            S.current.createGeneric(Note),
                          ),
                        ),
                        icon: AnimatedScale(
                          scale: inPageRange ? 1.0 : 0.0,
                          duration: duration,
                          child: const Icon(Icons.add),
                        ),
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
          () => HomeNavBar(pageController: controller.pageController),
        ),
      ),
    );
  }
}
