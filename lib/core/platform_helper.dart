import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../app/model_utils/user_utils.dart';

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
  fuchsia,
}

enum InteractionType {
  touch,
  mouse,
}

class PlatformHelper {
  static const isWeb = kIsWeb;
  static final isAndroid = !kIsWeb && Platform.isAndroid;
  static final isFuchsia = !kIsWeb && Platform.isFuchsia;
  static final isApple = !kIsWeb && (Platform.isMacOS || Platform.isIOS);
  static final isIOS = !kIsWeb && Platform.isIOS;
  static final isMacOS = !kIsWeb && Platform.isMacOS;
  static final isWindows = !kIsWeb && Platform.isWindows;
  static final isLinux = !kIsWeb && Platform.isLinux;

  static final canUseAppleSignIn = isApple;
  static final canUseGoogleSignIn = isAndroid;
  static canUseProvider(ProviderName provider) {
    switch (provider) {
      case ProviderName.google:
        return canUseGoogleSignIn;
      case ProviderName.apple:
        return canUseAppleSignIn;
      default:
        return true;
    }
  }

  static OS get currentOS {
    if (isWeb) {
      return OS.web;
    }
    if (isAndroid) {
      return OS.android;
    }
    if (isFuchsia) {
      return OS.fuchsia;
    }
    if (isApple) {
      if (isIOS) {
        return OS.iOS;
      }
      return OS.mac;
    }
    if (isWindows) {
      return OS.windows;
    }
    if (isLinux) {
      return OS.linux;
    }
    throw UnsupportedError('Unknown OS');
  }

  static InteractionType get currentInteractionType {
    if (isWeb || isWindows || isMacOS || isLinux) {
      return InteractionType.mouse;
    }
    return InteractionType.touch;
  }

  static DeviceType deviceType(BuildContext context) {
    if (isWeb) {
      if (MediaQuery.of(context).size.shortestSide < 800) {
        return DeviceType.mobile;
      }
      if (MediaQuery.of(context).size.shortestSide < 1100) {
        return DeviceType.tablet;
      }
      return DeviceType.desktop;
    }

    if (isWeb || isMacOS || isWindows || isLinux) {
      return DeviceType.desktop;
    }
    if (isAndroid || isFuchsia || isIOS) {
      if (MediaQuery.of(context).size.shortestSide >= 800) {
        return DeviceType.tablet;
      }
      return DeviceType.mobile;
    }
    throw UnsupportedError('Unknown device type');
  }

  static T byDeviceType<T>(
    BuildContext context, {
    T? mobile,
    T? desktop,
    T? tablet,
    DeviceType fallback = DeviceType.mobile,
  }) {
    final fallback0 = _getDeviceTypeFallback<T>(
      mobile: mobile,
      desktop: desktop,
      tablet: tablet,
      fallback: fallback,
    );
    if (isWeb) {
      if (MediaQuery.of(context).size.shortestSide < 800) {
        return mobile ?? fallback0;
      }
      if (MediaQuery.of(context).size.shortestSide < 1100) {
        return tablet ?? fallback0;
      }
      return desktop ?? fallback0;
    }
    if (isAndroid || isIOS || isFuchsia) {
      if (MediaQuery.of(context).size.shortestSide < 800) {
        return mobile ?? fallback0;
      }
      return tablet ?? fallback0;
    }
    return desktop ?? fallback0;
  }

  static T byOS<T>({
    T? android,
    T? iOS,
    T? windows,
    T? linux,
    T? mac,
    T? web,
    OS fallback = OS.android,
  }) {
    final fallback0 = _getOSFallback<T>(
      android: android,
      iOS: iOS,
      windows: windows,
      linux: linux,
      mac: mac,
      web: web,
      fallback: fallback,
    );
    if (isAndroid) {
      return android ?? fallback0;
    }
    if (isIOS) {
      return iOS ?? fallback0;
    }
    if (isWindows) {
      return windows ?? fallback0;
    }
    if (kIsWeb) {
      return web ?? fallback0;
    }
    if (isMacOS) {
      return mac ?? fallback0;
    }
    if (isLinux) {
      return linux ?? fallback0;
    }
    return iOS ?? fallback0;
  }

  static T byInteractionType<T>(
    BuildContext context, {
    T? touch,
    T? mouse,
    InteractionType fallback = InteractionType.touch,
  }) {
    final fallback0 = _getInteractionTypeFallback(
      touch: touch,
      mouse: mouse,
      fallback: fallback,
    );
    if (isWeb) {
      if (MediaQuery.of(context).size.shortestSide < 800) {
        return touch ?? fallback0;
      }
      return mouse ?? fallback0;
    }
    if (isAndroid || isIOS || isFuchsia) {
      return touch ?? fallback0;
    }
    return mouse ?? fallback0;
  }

  static T _getInteractionTypeFallback<T>({
    T? touch,
    T? mouse,
    InteractionType fallback = InteractionType.touch,
  }) {
    if (fallback == DeviceType.desktop) {
      return mouse!;
    }
    return touch!;
  }

  static T _getDeviceTypeFallback<T>({
    T? mobile,
    T? desktop,
    T? tablet,
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

  static T _getOSFallback<T>({
    T? android,
    T? iOS,
    T? windows,
    T? linux,
    T? mac,
    T? web,
    OS fallback = OS.android,
  }) {
    if (fallback == OS.web) {
      return web!;
    }
    if (fallback == OS.iOS) {
      return iOS!;
    }
    if (fallback == OS.windows) {
      return windows!;
    }
    if (fallback == OS.mac) {
      return mac!;
    }
    if (fallback == OS.linux) {
      return linux!;
    }
    return android!;
  }
}
