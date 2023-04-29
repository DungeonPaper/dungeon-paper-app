import 'package:dungeon_paper/app/data/services/loading_service.dart';
import 'package:dungeon_paper/app/data/services/user_service.dart';
import 'package:dungeon_paper/app/modules/Migration/controllers/migration_controller.dart';
import 'package:dungeon_paper/app/routes/app_pages.dart';
import 'package:dungeon_paper/app/widgets/atoms/user_menu.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeAppBar extends StatelessWidget with LoadingServiceMixin, UserServiceMixin implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppBar(
        title: Text(S.current.appName),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.search),
          onPressed: () => Get.toNamed(Routes.universalSearch),
        ),
        actions: [
          if (user.flags['su'] == true)
            IconButton(
              icon: const Icon(Icons.bug_report),
              onPressed: () => Get.toNamed(
                Routes.migration,
                arguments: MigrationArguments(email: user.email),
              ),
            ),
          const UserMenu(),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(64);
}
