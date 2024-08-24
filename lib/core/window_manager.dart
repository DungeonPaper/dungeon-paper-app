import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import 'platform_helper.dart';
import 'shared_preferences.dart';

Future<void> windowInit() async {
  if (PlatformHelper.isDesktop) {
    await windowManager.ensureInitialized();

    final w = prefs.getInt('windowWidth') ?? 1000;
    final h = prefs.getInt('windowHeight') ?? 900;
    final x = prefs.getInt('windowX');
    final y = prefs.getInt('windowY');
    final position =
        x != null && y != null ? Offset(x.toDouble(), y.toDouble()) : null;
    final size = Size(w.toDouble(), h.toDouble());

    debugPrint('Restoring window to $size at $position');

    WindowOptions windowOptions = WindowOptions(
      size: size,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
      center: true,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      if (position != null) {
        await windowManager.setPosition(position);
      }
      await windowManager.focus();
    });
  }
}
