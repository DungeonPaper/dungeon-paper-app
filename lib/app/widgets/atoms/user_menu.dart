import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/data/services/user_service.dart';
import 'package:dungeon_paper/app/widgets/atoms/user_avatar.dart';
import 'package:dungeon_paper/app/widgets/molecules/user_menu_popover.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserMenu extends StatelessWidget {
  const UserMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      // child: Hero(
      //   tag: 'userMenu',
      //   child: _buildChild(),
      // ),
      child: _buildChild(),
    );
  }

  Material _buildChild() {
    return Material(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => Get.dialog(
          UserMenuPopover(),
          // opaque: false,
          // transition: Transition.fadeIn,
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: UserAvatar(size: 40),
        ),
      ),
    );
  }
}
