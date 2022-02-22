import 'package:cached_network_image/cached_network_image.dart';
import 'package:dungeon_paper/core/services/character_service.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class CharacterAvatar extends GetView {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      CharacterService controller = Get.find();
      return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: CachedNetworkImage(
          imageUrl: controller.current?.avatarUrl.isNotEmpty == true
              ? controller.current!.avatarUrl
              : "https://via.placeholder.com/704.png?text=Avatar",
          width: 176,
          height: 176,
        ),
      );
    });
  }
}
