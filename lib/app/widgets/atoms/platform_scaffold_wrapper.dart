import 'package:dungeon_paper/app/routes/app_pages.dart';
import 'package:dungeon_paper/core/platform_helper.dart';
import 'package:flutter/material.dart';

import 'package:dungeon_paper/app/data/services/user_provider.dart';
import 'package:dungeon_paper/app/data/services/character_provider.dart';

class PlatformScaffoldWrapper extends StatelessWidget
    with UserProviderMixin, CharacterProviderMixin {
  final Widget child;
  final bool fullscreenDialog;

  const PlatformScaffoldWrapper(
      {super.key, required this.child, this.fullscreenDialog = false});

  static final double top = switch (PlatformHelper.currentOS) {
    OS.mac => 16,
    _ => 0,
  };

  @override
  Widget build(BuildContext context) {
    if (!PlatformHelper.isDesktop) {
      return child;
    }
    final padding = Padding(
      padding: EdgeInsets.only(top: top),
      child: child,
    );

    final bg = !fullscreenDialog
        ? Theme.of(context).scaffoldBackgroundColor
        : AppPages.fullscreenDialogBackgroundColor;

    return Material(
      color: bg,
      child: padding,
    );
  }
}
