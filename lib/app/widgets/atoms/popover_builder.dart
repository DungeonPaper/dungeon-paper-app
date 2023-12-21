import 'package:flutter/material.dart';

class PopoverBuilder extends StatelessWidget {
  const PopoverBuilder({
    super.key,
    required this.builder,
    required this.heroTag,
    this.padding = const EdgeInsets.all(32),
  });

  final Widget Function() builder;
  final String heroTag;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        behavior: HitTestBehavior.opaque,
        child: Container(
          color: Colors.black.withOpacity(0.75),
          padding: padding,
          child: AbsorbPointer(
            child: Hero(
              tag: heroTag,
              child: Material(
                type: MaterialType.transparency,
                child: builder(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
