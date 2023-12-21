import 'package:flutter/material.dart';

class PageControllerFractionalBox extends StatelessWidget {
  const PageControllerFractionalBox({
    super.key,
    required this.controller,
    required this.child,
  });

  final PageController controller;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1 / controller.viewportFraction,
      child: child,
    );
  }
}
