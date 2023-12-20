import 'package:dungeon_paper/app/data/services/loading_provider.dart';
import 'package:dungeon_paper/app/data/services/user_provider.dart';
import 'package:dungeon_paper/app/routes/app_pages.dart';
import 'package:dungeon_paper/app/widgets/atoms/user_menu.dart';
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
        onPressed: () => Navigator.of(context).pushNamed(Routes.universalSearch),
      ),
      actions: const [
        // if (user.flags['su'] == true)
        //   IconButton(
        //     icon: const Icon(Icons.bug_report),
        //     onPressed: () => Get.toNamed(
        //       Routes.migration,
        //       arguments: MigrationArguments(email: user.email),
        //     ),
        //   ),
        UserMenu(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(64);
}

