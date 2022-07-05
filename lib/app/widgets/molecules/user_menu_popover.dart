import 'dart:math';

import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/services/auth_service.dart';
import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/data/services/user_service.dart';
import 'package:dungeon_paper/app/routes/app_pages.dart';
import 'package:dungeon_paper/app/themes/themes.dart';
import 'package:dungeon_paper/app/widgets/atoms/theme_brightness_switch.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../atoms/character_avatar.dart';
import '../atoms/user_avatar.dart';

class UserMenuPopover extends GetView<CharacterService> with AuthServiceMixin {
  UserMenuPopover({super.key});

  final UserService userService = Get.find();

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(color: Theme.of(context).colorScheme.onSurface);
    final maxW = min(332.0, MediaQuery.of(context).size.width - 32);
    final maxH = MediaQuery.of(context).size.height - 72;
    const avatarSize = 64.0;
    const padding = 8.0;

    return ListTileTheme.merge(
      minLeadingWidth: 10,
      dense: true,
      contentPadding: EdgeInsets.zero,
      child: GestureDetector(
        onTap: () => Get.back(),
        child: Material(
          color: Colors.black54,
          child: Stack(
            children: [
              Positioned(
                right: padding,
                top: padding,
                child: SafeArea(
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: maxW, maxHeight: maxH),
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        // ignore: avoid_returning_null_for_void
                        onTap: () => null,
                        child: Obx(
                          () {
                            var brightness = Theme.of(context).brightness;
                            return ListView(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              shrinkWrap: true,
                              children: [
                                // User details
                                ListTile(
                                  visualDensity: VisualDensity.compact,
                                  title: Text(
                                    '${userService.current.displayName} (@${userService.current.username})',
                                    style: textStyle,
                                  ),
                                  subtitle: Text(
                                    userService.current.email.isNotEmpty
                                        ? userService.current.email
                                        : S.current.userUnregistered,
                                  ),
                                  trailing: userService.isGuest
                                      ? Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            ElevatedButton.icon(
                                              onPressed: () {
                                                Get.back();
                                                Get.toNamed(Routes.login);
                                              },
                                              icon: const Icon(Icons.login),
                                              label: Text(S.current.userLoginButton),
                                            ),
                                            const SizedBox(width: 16),
                                            const UserAvatar(),
                                          ],
                                        )
                                      : const UserAvatar(),
                                ),
                                const Divider(),
                                // Recent Characters
                                if (controller.charsByLastUsed.isNotEmpty) ...[
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
                                            splashColor: Theme.of(context).splashColor,
                                            borderRadius: borderRadius,
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
                                                  SizedBox(
                                                    width: 60,
                                                    child: Text(
                                                      char.displayName,
                                                      overflow: TextOverflow.ellipsis,
                                                      textScaleFactor: 0.8,
                                                      textAlign: TextAlign.center,
                                                      style: textStyle,
                                                    ),
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
                                ],
                                // My Library
                                ListTile(
                                  visualDensity: VisualDensity.compact,
                                  title: Text(S.current.libraryCollectionTitle),
                                  leading: const Icon(Icons.local_library),
                                  onTap: () {
                                    Get.back();
                                    Get.toNamed(Routes.library);
                                  },
                                ),
                                const Divider(),
                                // Create Character
                                ListTile(
                                  visualDensity: VisualDensity.compact,
                                  title: Text(S.current.createGeneric(S.current.entity(Character))),
                                  leading: const Icon(Icons.person_add),
                                  onTap: () {
                                    Get.back();
                                    Get.toNamed(Routes.createCharacter);
                                  },
                                ),
                                // All Characters
                                ListTile(
                                  visualDensity: VisualDensity.compact,
                                  dense: true,
                                  title:
                                      Text(S.current.allGeneric(S.current.entityPlural(Character))),
                                  leading: const Icon(Icons.group),
                                  onTap: () {
                                    Get.back();
                                    Get.toNamed(Routes.characterList);
                                  },
                                ),
                                const Divider(),
                                ThemeBrightnessSwitch.listTile(
                                  onChanged: (_) => Get.back(),
                                ),
                                // Export/Import
                                ListTile(
                                  visualDensity: VisualDensity.compact,
                                  title: Text(S.current.importExportTitle),
                                  leading: const Icon(Icons.import_export),
                                  onTap: () {
                                    Get.back();
                                    Get.toNamed(Routes.importExport);
                                  },
                                ),
                                // Settings
                                ListTile(
                                  visualDensity: VisualDensity.compact,
                                  title: Text(S.current.settingsTitle),
                                  leading: const Icon(Icons.settings),
                                  onTap: () {
                                    Get.back();
                                    Get.toNamed(Routes.settings);
                                  },
                                ),
                                // About
                                ListTile(
                                  visualDensity: VisualDensity.compact,
                                  title: Text(S.current.aboutTitle),
                                  leading: const Icon(Icons.info),
                                  onTap: () => null,
                                ),
                                // Logout
                                if (!userService.isGuest) ...[
                                  const Divider(),
                                  ListTile(
                                    visualDensity: VisualDensity.compact,
                                    title: Text(S.current.userLogoutButton),
                                    leading: const Icon(Icons.logout),
                                    onTap: () {
                                      Get.back();
                                      userService.logout();
                                    },
                                  ),
                                ],
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
