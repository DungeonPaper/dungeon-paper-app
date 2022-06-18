import 'package:flutter/material.dart';

class AvatarCircularProgress extends StatelessWidget {
  const AvatarCircularProgress({Key? key, required this.size}) : super(key: key);

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).unselectedWidgetColor,
      width: size,
      height: size,
      child: Center(
        child: SizedBox(
          width: size / 2,
          height: size / 2,
          child: CircularProgressIndicator.adaptive(
            strokeWidth: size / 20,
          ),
        ),
      ),
    );
  }
}
