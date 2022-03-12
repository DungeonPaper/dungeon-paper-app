import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ExpandedCardDialogView extends GetView {
  const ExpandedCardDialogView({
    Key? key,
    required this.builder,
    required this.heroTag,
  }) : super(key: key);

  final Widget Function() builder;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => Get.back(),
        child: Container(
          color: Colors.black.withOpacity(0.75),
          padding: const EdgeInsets.all(32),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  // minHeight: 200,
                  // maxHeight: MediaQuery.of(context).size.height / 2,
                  // minWidth: MediaQuery.of(context).size.width,
                  // maxWidth: MediaQuery.of(context).size.width,
                  ),
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
      ),
    );
  }
}
