import 'package:flutter/material.dart';

const BOTTOM_SPACER = const SizedBox(height: 64);

class PageLoader extends StatelessWidget {
  final Color color;
  final Color backgroundColor;
  final Size size;
  final double strokeWidth;

  const PageLoader({
    Key key,
    this.color,
    this.backgroundColor,
    this.strokeWidth,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CircularProgressIndicator loader = CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(color ?? Theme.of(context).primaryColor),
      backgroundColor: backgroundColor,
      strokeWidth: strokeWidth ?? 4.0,
    );
    if (size != null) {
      return Container(
        width: size.width,
        height: size.height,
        child: loader,
      );
    }
    return loader;
  }
}

