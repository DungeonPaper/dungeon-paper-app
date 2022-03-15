import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    Key? key,
    this.size,
  }) : super(key: key);

  final double? size;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size != null ? size! / 2 : null,
      child: const Icon(Icons.person),
    );
  }
}
