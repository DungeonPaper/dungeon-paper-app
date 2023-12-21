import 'package:dungeon_paper/app/routes/app_pages.dart';
import 'package:dungeon_paper/app/widgets/atoms/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/services/user_provider.dart';

class UserMenu extends StatelessWidget {
  const UserMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: _buildChild(context),
    );
  }

  Widget _buildChild(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        splashColor: Theme.of(context).splashColor,
        onTap: () => Navigator.of(context).pushNamed(Routes.userMenu),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Consumer<UserProvider>(
            builder: (context, controller, _) =>
                UserAvatar(user: controller.current),
          ),
        ),
      ),
    );
  }
}
