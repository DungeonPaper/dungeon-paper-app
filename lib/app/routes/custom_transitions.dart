import 'dart:math' show sqrt, max;
import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/custom_transition.dart';

class CustomCircularRevealClipper extends CustomClipper<Path> {
  final double fraction;
  final Alignment? centerAlignment;
  final Offset? centerOffset;
  final double? minRadius;
  final double? maxRadius;

  CustomCircularRevealClipper({
    required this.fraction,
    this.centerAlignment,
    this.centerOffset,
    this.minRadius,
    this.maxRadius,
  });

  @override
  Path getClip(Size size) {
    final center =
        centerAlignment?.alongSize(size) ?? centerOffset ?? Offset(size.width / 2, size.height / 2);
    final minRadius = this.minRadius ?? 0;
    final maxRadius = this.maxRadius ?? calcMaxRadius(size, center);

    return Path()
      ..addOval(
        Rect.fromCircle(
          center: center + (centerOffset ?? Offset.zero),
          radius: lerpDouble(minRadius, maxRadius, fraction)!,
        ),
      );
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;

  static double calcMaxRadius(Size size, Offset center) {
    final w = max(center.dx, size.width - center.dx);
    final h = max(center.dy, size.height - center.dy);
    return sqrt(w * w + h * h);
  }
}

class CustomCircularRevealTransition extends CustomTransition {
  CustomCircularRevealTransition({
    this.alignment,
    this.offset,
  });

  final Alignment? alignment;
  final Offset? offset;

  @override
  Widget buildTransition(BuildContext context, Curve? curve, Alignment? alignment,
      Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return ClipPath(
      clipper: CustomCircularRevealClipper(
        fraction: animation.value,
        centerAlignment: this.alignment ?? Alignment.center,
        centerOffset: offset ?? Offset.zero,
        minRadius: 0,
        maxRadius: MediaQuery.of(context).size.longestSide * 2,
      ),
      child: child,
    );
  }
}
