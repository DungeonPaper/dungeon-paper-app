import 'dart:math';
import 'dart:ui';

import 'package:dungeon_paper/app/data/models/campaign.dart';
import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/services/auth_service.dart';
import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/data/services/intl_service.dart';
import 'package:dungeon_paper/app/data/services/user_service.dart';
import 'package:dungeon_paper/app/routes/app_pages.dart';
import 'package:dungeon_paper/app/themes/themes.dart';
import 'package:dungeon_paper/app/widgets/atoms/theme_brightness_switch.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../atoms/character_avatar.dart';
import '../atoms/user_avatar.dart';

class UserMenuPopover extends GetView<CharacterService> with AuthServiceMixin, UserServiceMixin {
  UserMenuPopover({super.key});

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
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
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
                            () => ListView(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              shrinkWrap: true,
                              children: [
                                // User details
                                ListTile(
                                  onTap: userService.isLoggedIn ? () => Get.toNamed(Routes.account) : null,
                                  visualDensity: VisualDensity.compact,
                                  title: Text(
                                    '${userService.current.displayName} (@${userService.current.username})',
                                    style: textStyle,
                                  ),
                                  subtitle: Text(
                                    userService.current.email.isNotEmpty
                                        ? userService.current.email
                                        : tr.user.notLoggedIn,
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
                                              label: Text(tr.user.login),
                                            ),
                                            const SizedBox(width: 16),
                                            UserAvatar(user: user),
                                          ],
                                        )
                                      : UserAvatar(user: user),
                                ),
                                const Divider(),
                                // Recent Characters
                                if (controller.charsByLastUsed.isNotEmpty) ...[
                                  const SizedBox(height: 8),
                                  Text(
                                    tr.user.recentCharacters,
                                    style: Theme.of(context).textTheme.bodySmall,
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
                                                  CharacterAvatar.squircle(character: char, size: avatarSize),
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
                                // All Characters
                                ListTile(
                                  visualDensity: VisualDensity.compact,
                                  dense: true,
                                  title: Text(tr.generic.allEntities(tr.entityPlural(Character))),
                                  leading: const Icon(Icons.group),
                                  onTap: () {
                                    Get.back();
                                    Get.toNamed(Routes.characterList);
                                  },
                                ),
                                // Create Character
                                ListTile(
                                  visualDensity: VisualDensity.compact,
                                  title: Text(tr.generic.createEntity(tr.entity(Character))),
                                  leading: const Icon(Icons.person_add),
                                  onTap: () {
                                    Get.back();
                                    Get.toNamed(Routes.createCharacter);
                                  },
                                ),
                                const Divider(),
                                // My Library
                                ListTile(
                                  visualDensity: VisualDensity.compact,
                                  title: Text(tr.playbook.myLibrary),
                                  leading: const Icon(Icons.local_library),
                                  onTap: () {
                                    Get.back();
                                    Get.toNamed(Routes.library);
                                  },
                                ),
                                if (user.isDm)
                                  // My Campaigns
                                  ListTile(
                                    visualDensity: VisualDensity.compact,
                                    title: Text(tr.playbook.myCampaigns),
                                    leading: Icon(Campaign.genericIcon),
                                    onTap: () {
                                      Get.back();
                                      Get.toNamed(Routes.campaigns);
                                    },
                                  ),
                                // Export/Import
                                ListTile(
                                  visualDensity: VisualDensity.compact,
                                  title: Text(tr.settings.importExport),
                                  leading: const Icon(Icons.import_export),
                                  onTap: () {
                                    Get.back();
                                    Get.toNamed(Routes.importExport);
                                  },
                                ),
                                const Divider(),
                                ThemeBrightnessSwitch.listTile(
                                  onChanged: (_) => Get.back(),
                                ),
                                // Settings
                                ListTile(
                                  visualDensity: VisualDensity.compact,
                                  title: Text(tr.settings.title),
                                  leading: const Icon(Icons.settings),
                                  onTap: () {
                                    Get.back();
                                    Get.toNamed(Routes.settings);
                                  },
                                ),
                                // About
                                ListTile(
                                  visualDensity: VisualDensity.compact,
                                  title: Text(tr.about.title),
                                  leading: const Icon(Icons.info),
                                  onTap: () {
                                    Get.back();
                                    Get.toNamed(Routes.about);
                                  },
                                ),
                                // Logout
                                if (!userService.isGuest) ...[
                                  const Divider(),
                                  ListTile(
                                    visualDensity: VisualDensity.compact,
                                    title: Text(tr.user.logout),
                                    leading: const Icon(Icons.logout),
                                    onTap: () {
                                      Get.back();
                                      userService.logout();
                                    },
                                  ),
                                ],
                              ],
                            ),
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
      ),
    );
  }
}
