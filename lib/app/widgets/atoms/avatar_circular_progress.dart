import 'package:flutter/material.dart';

class AvatarCircularProgress extends StatelessWidget {
  const AvatarCircularProgress({super.key, required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).unselectedWidgetColor,
      width: size,
      height: size,
      child: Center(
        child: SizedBox.square(
          dimension: size / 2,
          child: CircularProgressIndicator.adaptive(
            strokeWidth: size / 20,
          ),
        ),
      ),
    );
  }
}
