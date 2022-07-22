import 'package:flutter/material.dart';

class PageControllerFractionalBox extends StatelessWidget {
  const PageControllerFractionalBox({
    Key? key,
    required this.controller,
    required this.child,
  }) : super(key: key);

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
