import 'package:cached_network_image/cached_network_image.dart';
import 'package:dungeon_paper/app/data/models/user.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    required this.user,
    this.size,
  });

  final double? size;
  final User user;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size != null ? size! / 2 : null,
      foregroundImage: user.photoUrl.isNotEmpty
          ? CachedNetworkImageProvider(
              user.photoUrl,
              scale: 2,
              maxWidth: size?.toInt(),
              maxHeight: size?.toInt(),
            )
          : null,
      child: const Icon(Icons.person),
    );
  }
}
