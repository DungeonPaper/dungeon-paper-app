import 'package:dungeon_paper/app/modules/Home/controllers/home_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class CharacterAvatar extends GetView {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      HomeController controller = Get.find();
      return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          controller.current?.avatarUrl.isNotEmpty == true
              ? controller.current!.avatarUrl
              : "https://via.placeholder.com/704.png?text=Avatar",
          width: 176,
          height: 176,
        ),
      );
    });
  }
}
