import 'dart:math';
import 'dart:ui';

import 'package:dungeon_paper/app/data/models/campaign.dart';
import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/services/character_provider.dart';
import 'package:dungeon_paper/app/data/services/user_provider.dart';
import 'package:dungeon_paper/app/routes/app_pages.dart';
import 'package:dungeon_paper/app/themes/themes.dart';
import 'package:dungeon_paper/app/widgets/atoms/theme_brightness_switch.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../atoms/character_avatar.dart';
import '../atoms/user_avatar.dart';

class UserMenuPopover extends StatelessWidget
    with CharacterProviderMixin, UserProviderMixin {
  const UserMenuPopover({super.key});

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
      contentPadding: const EdgeInsets.symmetric(vertical: 4),
      child: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
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
                        constraints:
                            BoxConstraints(maxWidth: maxW, maxHeight: maxH),
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          // ignore: avoid_returning_null_for_void
                          onTap: () => null,
                          child: Consumer<UserProvider>(
                            builder: (context, userProvider, _) {
                              return ListView(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                shrinkWrap: true,
                                children: [
                                  // User details
                                  ListTile(
                                    onTap: userProvider.isLoggedIn
                                        ? () => Navigator.of(context)
                                            .pushNamed(Routes.account)
                                        : null,
                                    visualDensity: VisualDensity.compact,
                                    title: Text(
                                      '${userProvider.current.displayName} (@${userProvider.current.username})',
                                      style: textStyle,
                                    ),
                                    subtitle: Text(
                                      userProvider.current.email.isNotEmpty
                                          ? userProvider.current.email
                                          : tr.auth.signup.notLoggedIn.label,
                                    ),
                                    trailing: userProvider.isGuest
                                        ? Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              ElevatedButton.icon(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  Navigator.of(context)
                                                      .pushNamed(Routes.login);
                                                },
                                                icon: const Icon(Icons.login),
                                                label:
                                                    Text(tr.auth.login.button),
                                              ),
                                              const SizedBox(width: 16),
                                              UserAvatar(user: user),
                                            ],
                                          )
                                        : UserAvatar(user: user),
                                  ),
                                  const Divider(),
                                  // Recent Characters
                                  if (charProvider
                                      .charsByLastUsed.isNotEmpty) ...[
                                    const SizedBox(height: 8),
                                    Text(
                                      tr.user.recentCharacters,
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: Wrap(
                                        spacing: 4,
                                        runSpacing: 4,
                                        children: [
                                          for (final char in charProvider
                                              .charsByLastUsed
                                              .take(4))
                                            InkWell(
                                              splashColor:
                                                  Theme.of(context).splashColor,
                                              borderRadius: borderRadius,
                                              onTap: () {
                                                charProvider
                                                    .setCurrent(char.key);
                                                Navigator.of(context).pop();
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4),
                                                child: Column(
                                                  children: [
                                                    CharacterAvatar.squircle(
                                                        character: char,
                                                        size: avatarSize),
                                                    const SizedBox(height: 4),
                                                    SizedBox(
                                                      width: 60,
                                                      child: Text(
                                                        char.displayName,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textScaler:
                                                            const TextScaler
                                                                .linear(0.8),
                                                        textAlign:
                                                            TextAlign.center,
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
                                    title: Text(tr.generic.allEntities(
                                        tr.entityPlural(tn(Character)))),
                                    leading: const Icon(Icons.group),
                                    onTap: () {
                                      Navigator.of(context).pop();
                                      Navigator.of(context)
                                          .pushNamed(Routes.characterList);
                                    },
                                  ),
                                  // Create Character
                                  ListTile(
                                    visualDensity: VisualDensity.compact,
                                    title: Text(tr.generic.createEntity(
                                        tr.entity(tn(Character)))),
                                    leading: const Icon(Icons.person_add),
                                    onTap: () {
                                      Navigator.of(context).pop();
                                      Navigator.of(context)
                                          .pushNamed(Routes.createCharacter);
                                    },
                                  ),
                                  const Divider(),
                                  // My Library
                                  ListTile(
                                    visualDensity: VisualDensity.compact,
                                    title: Text(tr.playbook.myLibrary),
                                    leading: const Icon(Icons.local_library),
                                    onTap: () {
                                      Navigator.of(context).pop();
                                      Navigator.of(context)
                                          .pushNamed(Routes.library);
                                    },
                                  ),
                                  if (user.isDm)
                                    // My Campaigns
                                    ListTile(
                                      visualDensity: VisualDensity.compact,
                                      title: Text(tr.playbook.myCampaigns),
                                      leading: Icon(Campaign.genericIcon),
                                      onTap: () {
                                        Navigator.of(context).pop();
                                        Navigator.of(context)
                                            .pushNamed(Routes.campaigns);
                                      },
                                    ),
                                  // Export/Import
                                  ListTile(
                                    visualDensity: VisualDensity.compact,
                                    title: Text(tr.settings.importExport),
                                    leading: const Icon(Icons.import_export),
                                    onTap: () {
                                      Navigator.of(context).pop();
                                      Navigator.of(context)
                                          .pushNamed(Routes.importExport);
                                    },
                                  ),
                                  const Divider(),
                                  ThemeBrightnessSwitch.listTile(
                                    onChanged: (_) =>
                                        Navigator.of(context).pop(),
                                  ),
                                  // Settings
                                  ListTile(
                                    visualDensity: VisualDensity.compact,
                                    title: Text(tr.settings.title),
                                    leading: const Icon(Icons.settings),
                                    onTap: () {
                                      Navigator.of(context).pop();
                                      Navigator.of(context)
                                          .pushNamed(Routes.settings);
                                    },
                                  ),
                                  // About
                                  ListTile(
                                    visualDensity: VisualDensity.compact,
                                    title: Text(tr.about.title),
                                    leading: const Icon(Icons.info),
                                    onTap: () {
                                      Navigator.of(context).pop();
                                      Navigator.of(context)
                                          .pushNamed(Routes.about);
                                    },
                                  ),
                                  // Logout
                                  if (!userProvider.isGuest) ...[
                                    const Divider(),
                                    ListTile(
                                      visualDensity: VisualDensity.compact,
                                      title: Text(tr.auth.logout.button),
                                      leading: const Icon(Icons.logout),
                                      onTap: () {
                                        Navigator.of(context).pop();
                                        userProvider.logout();
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
      ),
    );
  }
}
