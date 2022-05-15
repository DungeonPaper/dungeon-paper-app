import 'dart:math';

import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/data/services/user_service.dart';
import 'package:dungeon_paper/app/routes/app_pages.dart';
import 'package:dungeon_paper/app/widgets/atoms/popover_builder.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../atoms/character_avatar.dart';
import '../atoms/user_avatar.dart';

class UserMenuPopover extends GetView<CharacterService> {
  UserMenuPopover({Key? key}) : super(key: key);

  final UserService userService = Get.find();

  @override
  Widget build(BuildContext context) {
    return PopoverBuilder(
      heroTag: 'userMenu',
      padding: const EdgeInsets.all(16),
      builder: () {
        final textStyle = TextStyle(color: Theme.of(context).colorScheme.onSurface);
        final maxW = min(350, MediaQuery.of(context).size.width - 100).toDouble();
        const avatarSize = 64.0;

        return ListTileTheme.merge(
          minLeadingWidth: 10,
          dense: true,
          contentPadding: EdgeInsets.zero,
          child: Stack(
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
                          ListTile(
                            visualDensity: VisualDensity.compact,
                            title: Text(userService.current.username, style: textStyle),
                            subtitle: Text(userService.current.email.isNotEmpty
                                ? userService.current.email
                                : S.current.userUnregistered),
                            trailing: const UserAvatar(),
                          ),
                          const Divider(),
                          const SizedBox(height: 8),
                          Text(
                            S.current.userMenuRecentCharacters,
                            style: Theme.of(context).textTheme.caption,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Wrap(
                              spacing: 4,
                              runSpacing: 4,
                              children: [
                                for (final char in controller.charsByLastUsed.take(4))
                                  InkWell(
                                    borderRadius: BorderRadius.circular(8),
                                    onTap: () {
                                      controller.setCurrent(char.key);
                                      Get.back();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(4),
                                      child: Column(
                                        children: [
                                          CharacterAvatar.squircle(
                                              character: char, size: avatarSize),
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
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Divider(),
                          ListTile(
                            visualDensity: VisualDensity.compact,
                            title: Text(S.current.addGeneric(S.current.entity(Character))),
                            leading: const Icon(Icons.person_add),
                            onTap: () {
                              Get.back();
                              Get.toNamed(Routes.createCharacter);
                            },
                          ),
                          ListTile(
                            visualDensity: VisualDensity.compact,
                            dense: true,
                            title: Text(S.current.allGeneric(S.current.entityPlural(Character))),
                            leading: const Icon(Icons.group),
                            onTap: () {
                              Get.back();
                              Get.toNamed(Routes.characterList);
                            },
                          ),
                          const Divider(),
                          ListTile(
                            visualDensity: VisualDensity.compact,
                            title: Text(S.current.importExportTitle),
                            leading: const Icon(Icons.import_export),
                            onTap: () {
                              Get.back();
                              Get.toNamed(Routes.importExport);
                            },
                          ),
                          ListTile(
                            visualDensity: VisualDensity.compact,
                            title: Text(S.current.settingsTitle),
                            leading: const Icon(Icons.settings),
                            onTap: () {
                              Get.back();
                              Get.toNamed(Routes.settings);
                            },
                          ),
                          ListTile(
                            visualDensity: VisualDensity.compact,
                            title: Text(S.current.aboutTitle),
                            leading: const Icon(Icons.info),
                            onTap: () => null,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
