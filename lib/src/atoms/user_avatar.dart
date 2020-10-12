import 'package:dungeon_paper/db/models/user.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final User user;
  final double radius;
  final double textScaleFactor;

  const UserAvatar({
    Key key,
    @required this.user,
    this.radius = 50,
    this.textScaleFactor = 2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hasAvatar = user.photoURL?.isNotEmpty == true;
    final initials = (user.displayName.length > 2
            ? user.displayName
            : user.email)
        .split(RegExp(r'[\.\s]+'))
        .take(2)
        .map((word) => word?.isNotEmpty == true ? word[0].toUpperCase() : '')
        .join('');

    return CircleAvatar(
      backgroundImage: hasAvatar ? NetworkImage(user.photoURL) : null,
      child: !hasAvatar
          ? Text(
              initials,
              textScaleFactor: textScaleFactor,
            )
          : null,
      radius: radius,
    );
  }
}
