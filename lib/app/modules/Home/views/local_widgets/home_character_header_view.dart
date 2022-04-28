import 'package:dungeon_paper/app/widgets/dialogs/character_bio_dialog.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/widgets/atoms/character_avatar.dart';
import 'package:dungeon_paper/app/widgets/atoms/labeled_icon_button.dart';
import 'package:dungeon_paper/app/widgets/atoms/svg_icon.dart';
import 'package:dungeon_paper/core/dw_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeCharacterHeaderView extends GetView<CharacterService> {
  const HomeCharacterHeaderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          CharacterAvatar.squircle(size: 176),
          Positioned(
            right: 0,
            bottom: 0,
            child: PopupMenuButton(
              itemBuilder: (context) => [
                _MenuItem(
                    id: 'bio',
                    text: S.current.characterBioDialogTitle,
                    icon: const Icon(Icons.library_books))
              ]
                  .map((e) => PopupMenuItem(
                      child: Row(
                        children: [
                          e.icon,
                          const SizedBox(width: 12),
                          Expanded(child: Text(e.text)),
                        ],
                      ),
                      value: e.id))
                  .toList(),
              onSelected: (value) {
                switch (value) {
                  case 'bio':
                    Get.dialog(const CharacterBioDialog());
                    return;
                  default:
                    throw UnsupportedError('Menu value: $value not supported');
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuItem {
  final String id;
  final String text;
  final Widget icon;

  _MenuItem({required this.id, required this.text, required this.icon});
}
