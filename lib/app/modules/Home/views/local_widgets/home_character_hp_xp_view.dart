import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/widgets/atoms/exp_bar.dart';
import 'package:dungeon_paper/app/widgets/atoms/hp_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class HomeCharacterHpExpView extends GetView<CharacterService> {
  const HomeCharacterHpExpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            child: const HpBar(),
            borderRadius: BorderRadius.circular(10),
            onTap: () => null,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: InkWell(
            child: const ExpBar(),
            borderRadius: BorderRadius.circular(10),
            onTap: () => null,
          ),
        ),
      ],
    );
  }
}
