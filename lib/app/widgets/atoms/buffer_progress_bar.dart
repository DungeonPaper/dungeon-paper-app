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
    this.duration,
  });

  final double value;
  final Color? color;
  final Color? backgroundColor;
  final double? height;
  final double? bufferValue;
  final Color? bufferColor;
  final Duration? duration;

  @override
  Widget build(BuildContext context) {
    final _duration = duration ?? const Duration(milliseconds: 250);
    return SizedBox(
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: LayoutBuilder(builder: (context, constraints) {
          return Stack(
            children: [
              AnimatedContainer(
                duration: _duration,
                height: height,
                width: constraints.maxWidth,
                color: backgroundColor ?? Theme.of(context).colorScheme.primaryContainer,
              ),
              if (bufferValue != null)
                AnimatedContainer(
                  duration: _duration,
                  height: height,
                  width: constraints.maxWidth * clamp(bufferValue!, 0, 1),
                  color: bufferColor ?? Theme.of(context).colorScheme.primary.withOpacity(0.3),
                ),
              AnimatedContainer(
                duration: _duration,
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
