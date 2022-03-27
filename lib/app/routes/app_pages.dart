import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/model_utils/character_utils.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/views/add_moves_view.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';

import '../modules/AddRepositoryItems/bindings/add_repository_items_binding.dart';
import '../modules/CharacterListPage/bindings/character_list_page_binding.dart';
import '../modules/CharacterListPage/views/character_list_page_view.dart';
import '../modules/Home/bindings/home_binding.dart';
import '../modules/Home/views/home_view.dart';
import '../modules/UpsertCharacterPages/bindings/create_character_page_binding.dart';
import '../modules/UpsertCharacterPages/views/create_character_page_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final pageController = PageController();

  static final CharacterService characterService = Get.find();

  static const initial = Routes.home;

  static final routes = [
    GetPage(
      name: _Paths.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.characterListPage,
      page: () => const CharacterListPageView(),
      binding: CharacterListPageBinding(),
    ),
    GetPage(
      name: _Paths.createCharacterPage,
      page: () => const CreateCharacterPageView(),
      binding: CreateCharacterPageBinding(),
    ),
    GetPage(
      name: _Paths.addMoves,
      page: () => AddMovesView(
        onAdd: (moves) => characterService.updateCharacter(
          CharacterUtils.updateMoves(characterService.current!, moves),
        ),
        selections: characterService.current!.moves,
        classKeys: [characterService.current!.characterClass.key],
      ),
      binding: AddRepositoryItemsBinding(),
    ),
  ];
}
