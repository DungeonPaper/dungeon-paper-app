import 'package:flutter/material.dart';

import 'package:get/get.dart';

class PopoverBuilder extends GetView {
  const PopoverBuilder({
    Key? key,
    required this.builder,
    required this.heroTag,
    this.padding = const EdgeInsets.all(32),
  }) : super(key: key);

  final Widget Function() builder;
  final String heroTag;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => Get.back(),
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
