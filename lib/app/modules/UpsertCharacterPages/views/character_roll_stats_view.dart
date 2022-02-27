import 'package:dungeon_paper/app/data/models/roll_stats.dart';
import 'package:dungeon_paper/app/modules/UpsertCharacterPages/controllers/character_roll_stats_controller.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class CharacterRollStatsView extends GetView<CharacterRollStatsController> {
  final void Function(bool valid, RollStats? rollStats) onValidate;

  const CharacterRollStatsView({
    Key? key,
    required this.onValidate,
  }) : super(key: key);

  updateControllers() {
    onValidate(controller.validate(), controller.isValid ? controller.rollStats.value : null);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // final theme = Theme.of(context);
      return ReorderableListView(
        padding: const EdgeInsets.all(16),
        shrinkWrap: true,
        onReorder: (int oldIndex, int newIndex) {
          controller.rollStats.value = controller.rollStats.value
              .copyWith(stats: reorder(controller.rollStats.value.stats, oldIndex, newIndex));
        },
        children: sortByPredefined(
          controller.textControllers.keys.toList(),
          order: controller.rollStats.value.stats.map((stat) => stat.key).toList(),
        ).map(
          (statKey) {
            final stat = controller.rollStats.value.stats.firstWhere((stat) => stat.key == statKey);
            return Padding(
              key: Key('stat-$statKey'),
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Card(
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(stat.name),
                            Text(stat.description),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: TextFormField(
                          controller: controller.textControllers[stat.key],
                          onChanged: (val) => updateControllers(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ).toList(),
      );
    });
  }
}
