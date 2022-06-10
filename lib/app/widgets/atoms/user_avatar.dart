import 'package:cached_network_image/cached_network_image.dart';
import 'package:dungeon_paper/app/data/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserAvatar extends GetView<UserService> {
  const UserAvatar({
    Key? key,
    this.size,
  }) : super(key: key);

  final double? size;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CircleAvatar(
        radius: size != null ? size! / 2 : null,
        child: const Icon(Icons.person),
        foregroundImage: controller.current.photoUrl.isNotEmpty
            ? CachedNetworkImageProvider(
                controller.current.photoUrl,
                maxWidth: size?.toInt(),
                maxHeight: size?.toInt(),
              )
            : null,
      ),
    );
  }
}
