import 'package:dungeon_paper/app/data/services/loading_provider.dart';
import 'package:dungeon_paper/app/data/services/user_provider.dart';
import 'package:dungeon_paper/app/routes/app_pages.dart';
import 'package:dungeon_paper/app/widgets/molecules/user_menu_popover.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget
    with LoadingProviderMixin, UserProviderMixin
    implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(tr.app.name),
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: const Icon(Icons.search),
        onPressed: () =>
            Navigator.of(context).pushNamed(Routes.universalSearch),
      ),
      actions: const [UserMenu()],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(64);
}
