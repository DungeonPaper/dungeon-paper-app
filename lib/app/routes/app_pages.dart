import 'package:get/get.dart';

import '../modules/CharacterListPage/bindings/character_list_page_binding.dart';
import '../modules/CharacterListPage/views/character_list_page_view.dart';
import '../modules/CreateCharacterPage/bindings/create_character_page_binding.dart';
import '../modules/CreateCharacterPage/views/create_character_page_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.characterListPage;

  static final routes = [
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
  ];
}
