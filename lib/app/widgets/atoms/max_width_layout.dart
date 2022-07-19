import 'dart:math';

import 'package:flutter/material.dart';

class MaxWidthLayout extends StatelessWidget {
  final double maxWidth;
  final Widget child;

  const MaxWidthLayout({
    super.key,
    required this.maxWidth,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return child;
    // return LayoutBuilder(
    //   builder: (context, layout) {
    //     final _maxWidth = min(maxWidth, layout.maxWidth);
    //     debugPrint('maxWidth: $_maxWidth');
    //     return SizedBox.shrink(
    //       child: ConstrainedBox(
    //         constraints: BoxConstraints(maxWidth: _maxWidth, minWidth: 400, minHeight: 100),
    //         child: Container(color: Colors.green, child: child),
    //       ),
    //     );
    //   },
    // );
  }
}
