import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/widgets/atoms/character_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeCharacterHeaderView extends GetView<CharacterService> {
  const HomeCharacterHeaderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CharacterAvatar.squircle(size: avatarSize),
    );
  }

  static const avatarSize = 176.0;
}
