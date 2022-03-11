import 'package:cached_network_image/cached_network_image.dart';
import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class CharacterAvatar extends GetView {
  final Character? character;
  final Widget Function(String avatarUrl, double size) builder;
  final double size;

  const CharacterAvatar._({
    Key? key,
    this.character,
    required this.size,
    required this.builder,
  }) : super(key: key);

  factory CharacterAvatar({
    Key? key,
    Character? character,
    required double size,
    required final Widget Function(String avatarUrl, double size) builder,
  }) =>
      CharacterAvatar._(key: key, character: character, size: size, builder: builder);

  factory CharacterAvatar.roundedRect({
    Key? key,
    Character? character,
    required double size,
  }) =>
      CharacterAvatar._(key: key, character: character, size: size, builder: _rRectBuilder);

  factory CharacterAvatar.circle({
    Key? key,
    Character? character,
    required double size,
  }) =>
      CharacterAvatar._(key: key, character: character, size: size, builder: _circleBuilder);

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

  static Widget _rRectBuilder(String url, double size) => ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: CachedNetworkImage(
          imageUrl: url,
          width: size,
          height: size,
          fit: BoxFit.cover,
        ),
      );

  static Widget _circleBuilder(String url, double size) => CircleAvatar(
        // clipBehavior: Clip.hardEdge,
        foregroundImage: CachedNetworkImageProvider(url),
        radius: size / 2,
      );

  Widget renderForChar(Character? char) {
    return builder(
      char?.avatarUrl.isNotEmpty == true
          ? char!.avatarUrl
          : 'https://placeholder.photo/img/704.png?text=Avatar',
      size,
    );
  }
}
