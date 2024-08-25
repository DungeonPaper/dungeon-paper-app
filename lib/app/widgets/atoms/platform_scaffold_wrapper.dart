import 'package:dungeon_paper/core/platform_helper.dart';
import 'package:flutter/material.dart';

import 'package:dungeon_paper/app/data/services/user_provider.dart';
import 'package:dungeon_paper/app/data/services/character_provider.dart';

class PlatformScaffoldWrapper extends StatelessWidget
    with UserProviderMixin, CharacterProviderMixin {
  final Widget child;

  const PlatformScaffoldWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    if (!PlatformHelper.isDesktop) {
      return child;
    }
    final double top = switch (PlatformHelper.currentOS) {
      OS.mac => 16,
      _ => 0,
    };
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Padding(
        padding: EdgeInsets.only(top: top),
        child: child,
      ),
    );
  }
}
