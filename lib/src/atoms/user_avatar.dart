import 'package:cached_network_image/cached_network_image.dart';
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

    final _initials = Text(
      initials,
      textScaleFactor: textScaleFactor,
    );

    if (user.photoURL?.isEmpty != false) {
      return CircleAvatar(child: _initials, radius: radius);
    }

    return CachedNetworkImage(
      imageUrl: user.photoURL,
      imageBuilder: (context, image) => CircleAvatar(
        backgroundImage: image,
        child: !hasAvatar ? _initials : null,
        radius: radius,
      ),
      placeholder: (context, url) =>
          CircleAvatar(child: _initials, radius: radius),
      errorWidget: (context, url, err) =>
          CircleAvatar(child: _initials, radius: radius),
    );
  }
}
