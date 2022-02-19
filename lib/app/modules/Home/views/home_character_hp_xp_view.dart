import 'package:dungeon_paper/app/modules/Home/controllers/home_controller.dart';
import 'package:dungeon_paper/app/widgets/atoms/hp_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../widgets/atoms/xp_bar.dart';

class HomeCharacterHpXpView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(child: HpBar()),
        SizedBox(width: 24),
        Expanded(child: XpBar()),
      ],
    );
  }
}
