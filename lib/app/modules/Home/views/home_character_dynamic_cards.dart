import 'package:dungeon_paper/app/utils/list_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../../generated/l10n.dart';
import '../../../data/models/move.dart';
import '../../../widgets/cards/move_card_mini.dart';
import '../controllers/home_controller.dart';

class HomeCharacterDynamicCards extends GetView<HomeController> {
  const HomeCharacterDynamicCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      print("moves: ${controller.current?.moves}");
      var moves = (controller.current?.moves ?? <Move>[]).where((m) => m.favorited);
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(S.current.dynamicCategoriesMoves),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 139,
            width: double.infinity,
            // width: 200,
            child: ListView(
              // shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              // itemExtent: 2,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                for (final move in Enumerated.listFrom(moves))
                  Padding(
                    padding: EdgeInsets.only(right: move.index == moves.length - 1 ? 0 : 8),
                    child: SizedBox(
                      width: 210,
                      child: MoveCardMini(move: move.value),
                    ),
                  ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
