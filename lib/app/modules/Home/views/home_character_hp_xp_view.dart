import 'package:dungeon_paper/core/services/character_service.dart';
import 'package:dungeon_paper/app/widgets/atoms/hp_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../widgets/atoms/exp_bar.dart';

class HomeCharacterHpExpView extends GetView<CharacterService> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            child: HpBar(),
            borderRadius: BorderRadius.circular(10),
            onTap: () => null,
          ),
        ),
        SizedBox(width: 24),
        Expanded(
          child: InkWell(
            child: ExpBar(),
            borderRadius: BorderRadius.circular(10),
            onTap: () => null,
          ),
        ),
      ],
    );
  }
}
