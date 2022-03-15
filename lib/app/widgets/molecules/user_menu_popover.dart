import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/routes/app_pages.dart';
import 'package:dungeon_paper/app/widgets/atoms/popover_builder.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../atoms/character_avatar.dart';
import '../atoms/user_avatar.dart';

class UserMenuPopover extends GetView<CharacterService> {
  const UserMenuPopover({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopoverBuilder(
      heroTag: 'userMenu',
      padding: const EdgeInsets.all(16),
      builder: () {
        final textStyle = TextStyle(color: Theme.of(context).colorScheme.onSurface);
        final maxW = MediaQuery.of(context).size.width - 100;
        const avatarSize = 64.0;

        return Stack(
          children: [
            Positioned(
              right: 0,
              top: 0,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: maxW,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Expanded(child: Text('User', style: textStyle)),
                            const SizedBox(width: 16),
                            const UserAvatar(),
                          ],
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: GridView.count(
                            crossAxisCount: 4,
                            childAspectRatio: (maxW / 4) / (maxW / 4 + 10),
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            mainAxisSpacing: 4,
                            crossAxisSpacing: 4,
                            children: [
                              for (final char in controller.charsByLastUsed.take(5))
                                InkWell(
                                  borderRadius: BorderRadius.circular(8),
                                  onTap: () {
                                    controller.setCurrent(char.key);
                                    Get.back();
                                  },
                                  child: Column(
                                    children: [
                                      CharacterAvatar.circle(character: char, size: avatarSize),
                                      const SizedBox(height: 4),
                                      Text(
                                        char.displayName,
                                        overflow: TextOverflow.ellipsis,
                                        textScaleFactor: 0.8,
                                        textAlign: TextAlign.center,
                                        style: textStyle,
                                      ),
                                    ],
                                  ),
                                ),
                              InkWell(
                                borderRadius: BorderRadius.circular(8),
                                onTap: () => Get.toNamed(Routes.characterListPage),
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      child: const Icon(Icons.more_horiz),
                                      radius: avatarSize / 2,
                                      backgroundColor: Theme.of(context).colorScheme.background,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      S.current.userMenuMoreChars,
                                      overflow: TextOverflow.ellipsis,
                                      textScaleFactor: 0.8,
                                      textAlign: TextAlign.center,
                                      style: textStyle,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Divider(),
                        ListTileTheme.merge(
                          minLeadingWidth: 10,
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                          child: ListTile(
                            title: const Text('Add Character'),
                            leading: const Icon(Icons.add),
                            onTap: () => Get.toNamed(Routes.createCharacterPage),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
