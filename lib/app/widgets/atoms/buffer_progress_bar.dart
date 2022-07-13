import 'package:dungeon_paper/core/utils/math_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class BufferProgressBar extends StatelessWidget {
  const BufferProgressBar({
    super.key,
    required this.value,
    this.color,
    this.backgroundColor,
    this.height,
    this.bufferValue,
    this.bufferColor,
  });

  final double value;
  final Color? color;
  final Color? backgroundColor;
  final double? height;
  final double? bufferValue;
  final Color? bufferColor;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        child: LayoutBuilder(builder: (context, constraints) {
          return Stack(
            children: [
              Container(
                height: height,
                width: constraints.maxWidth,
                color: backgroundColor ?? Theme.of(context).colorScheme.primaryContainer,
              ),
              if (bufferValue != null)
                Container(
                  height: height,
                  width: constraints.maxWidth * clamp(bufferValue!, 0, 1),
                  color: bufferColor ?? Theme.of(context).colorScheme.primary.withOpacity(0.3),
                ),
              Container(
                height: height,
                width: constraints.maxWidth * value,
                color: color ?? Theme.of(context).primaryColor,
              ),
            ],
          );
        }),
      ),
    );
  }
}
