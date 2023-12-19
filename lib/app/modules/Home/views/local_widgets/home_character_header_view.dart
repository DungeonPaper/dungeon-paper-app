import 'package:dungeon_paper/app/widgets/atoms/character_avatar.dart';
import 'package:flutter/material.dart';

class HomeCharacterHeaderView extends StatelessWidget {
  const HomeCharacterHeaderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CharacterAvatar.squircle(size: avatarSize),
    );
  }

  static const avatarSize = 176.0;
}
