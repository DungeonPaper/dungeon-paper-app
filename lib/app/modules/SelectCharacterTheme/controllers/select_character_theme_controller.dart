import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/data/services/user_service.dart';
import 'package:dungeon_paper/app/themes/themes.dart';
import 'package:get/get.dart';

class SelectCharacterThemeController extends GetxController
    with CharacterServiceMixin, UserServiceMixin {
  final lightTheme = Rx<int?>(AppThemes.parchment);
  final darkTheme = Rx<int?>(AppThemes.dark);

  @override
  void onReady() {
    super.onReady();
    lightTheme.value = char.settings.lightTheme;
    darkTheme.value = char.settings.darkTheme;
  }

  void save() async {
    await charService.updateCharacter(
      char.copyWith(
        settings: char.settings.copyWithThemes(
          lightTheme: lightTheme.value,
          darkTheme: darkTheme.value,
        ),
      ),
    );
    charService.switchToCharacterTheme(char);
    Get.back();
  }
}
