import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum DeviceType {
  mobile,
  desktop,
  tablet,
}

enum OS {
  iOS,
  android,
  windows,
  mac,
  linux,
  web,
}

enum InteractionType {
  touch,
  mouse,
}

class PlatformString {
  static String byDeviceType(
    BuildContext context, {
    String? mobile,
    String? desktop,
    String? tablet,
    DeviceType fallback = DeviceType.mobile,
  }) {
    final _fallback = _getDeviceTypeFallback(
      mobile: mobile,
      desktop: desktop,
      tablet: tablet,
      fallback: fallback,
    );
    if (kIsWeb) {
      if (MediaQuery.of(context).size.shortestSide < 800) {
        return mobile ?? _fallback;
      }
      if (MediaQuery.of(context).size.shortestSide < 1100) {
        return tablet ?? _fallback;
      }
      return desktop ?? _fallback;
    }
    if (Platform.isAndroid || Platform.isIOS || Platform.isFuchsia) {
      if (MediaQuery.of(context).size.shortestSide < 800) {
        return mobile ?? _fallback;
      }
      return tablet ?? _fallback;
    } else {
      return desktop ?? _fallback;
    }
  }

  static String byOS({
    String? android,
    String? iOS,
    String? windows,
    String? linux,
    String? mac,
    String? web,
    OS fallback = OS.android,
  }) {
    final _fallback = _getOSFallback(
      android: android,
      iOS: iOS,
      windows: windows,
      linux: linux,
      mac: mac,
      web: web,
      fallback: fallback,
    );
    if (Platform.isAndroid) {
      return android ?? _fallback;
    } else if (Platform.isIOS) {
      return iOS ?? _fallback;
    } else if (Platform.isWindows) {
      return windows ?? _fallback;
    } else if (kIsWeb) {
      return web ?? _fallback;
    } else if (Platform.isMacOS) {
      return mac ?? _fallback;
    } else if (Platform.isLinux) {
      return linux ?? _fallback;
    } else {
      return iOS ?? _fallback;
    }
  }

  static String byInteractionType(
    BuildContext context, {
    String? touch,
    String? mouse,
    InteractionType fallback = InteractionType.touch,
  }) {
    final _fallback = _getInteractionTypeFallback(
      touch: touch,
      mouse: mouse,
      fallback: fallback,
    );
    if (kIsWeb) {
      if (MediaQuery.of(context).size.shortestSide < 800) {
        return touch ?? _fallback;
      }
      return mouse ?? _fallback;
    }
    if (Platform.isAndroid || Platform.isIOS || Platform.isFuchsia) {
      return touch ?? _fallback;
    } else {
      return mouse ?? _fallback;
    }
  }

  static String _getInteractionTypeFallback({
    String? touch,
    String? mouse,
    InteractionType fallback = InteractionType.touch,
  }) {
    if (fallback == DeviceType.desktop) {
      return mouse!;
    } else {
      return touch!;
    }
  }

  static String _getDeviceTypeFallback({
    String? mobile,
    String? desktop,
    String? tablet,
    DeviceType fallback = DeviceType.mobile,
  }) {
    if (fallback == DeviceType.desktop) {
      return desktop!;
    }
    if (fallback == DeviceType.tablet) {
      return tablet!;
    }
    return mobile!;
  }

  static String _getOSFallback({
    String? android,
    String? iOS,
    String? windows,
    String? linux,
    String? mac,
    String? web,
    OS fallback = OS.android,
  }) {
    if (fallback == OS.web) {
      return web!;
    } else if (fallback == OS.iOS) {
      return iOS!;
    } else if (fallback == OS.windows) {
      return windows!;
    } else if (fallback == OS.mac) {
      return mac!;
    } else if (fallback == OS.linux) {
      return linux!;
    } else {
      return android!;
    }
  }
}
