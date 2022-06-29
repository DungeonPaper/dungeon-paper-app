import 'package:dungeon_paper/app/routes/app_pages.dart';
import 'package:dungeon_paper/app/themes/themes.dart';
import 'package:dungeon_paper/app/widgets/atoms/user_menu.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () => Get.toNamed(Routes.universalSearch),
        ),
        const UserMenu(),
      ],
      automaticallyImplyLeading: false,
    );
  }

  void toggleTheme() {
    var theme = DynamicTheme.of(Get.context!)!;
    theme.setTheme(theme.themeId == AppThemes.dark ? AppThemes.parchment : AppThemes.dark);
  }

  @override
  Size get preferredSize => const Size.fromHeight(64);
}
