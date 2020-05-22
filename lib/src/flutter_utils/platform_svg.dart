import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'web_svg_wrapper.dart';

class PlatformSvg {
  static Widget asset(
    String assetName, {
    double width,
    double height,
    BoxFit fit = BoxFit.contain,
    Color color,
    alignment = Alignment.center,
    String semanticsLabel,
  }) {
    if (kIsWeb) {
      return WebSvgWrapper.network(
        'assets/$assetName',
        width: width,
        height: height,
        color: color,
      );
    }
    return SvgPicture.asset(
      'assets/$assetName',
      width: width,
      height: height,
      fit: fit,
      color: color,
      alignment: alignment,
      semanticsLabel: semanticsLabel,
    );
  }
}
