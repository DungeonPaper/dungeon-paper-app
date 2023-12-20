import 'package:flutter/material.dart';

class ExpandedCardDialogView<T> extends StatelessWidget {
  const ExpandedCardDialogView({
    super.key,
    required this.builder,
    required this.heroTag,
  });

  final Widget Function(BuildContext context) builder;
  final String? heroTag;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Container(
          // color: Colors.black.withOpacity(0.75),
          padding: const EdgeInsets.all(32),
          child: Center(
            child: SizedBox(
              width: 600,
              child: heroTag != null
                  ? Hero(
                      tag: heroTag!,
                      child: Material(
                        type: MaterialType.transparency,
                        child: builder(context),
                      ),
                    )
                  : builder(context),
            ),
          ),
        ),
      ),
    );
  }
}

