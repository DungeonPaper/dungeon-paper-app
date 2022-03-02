import 'package:cached_network_image/cached_network_image.dart';
import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class CharacterAvatar extends GetView {
  final Character? character;

  const CharacterAvatar({Key? key, this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (character != null) {
      return renderForChar(character);
    }
    return Obx(() {
      final ctrl = Get.find<CharacterService>();
      return renderForChar(ctrl.current);
    });
  }

  Widget renderForChar(Character? char) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      // clipBehavior: Clip.hardEdge,
      child: CachedNetworkImage(
        imageUrl: char?.avatarUrl.isNotEmpty == true
            ? char!.avatarUrl
            : 'https://placeholder.photo/img/704.png?text=Avatar',
        width: 176,
        height: 176,
        fit: BoxFit.cover,
      ),
    );
  }
}
