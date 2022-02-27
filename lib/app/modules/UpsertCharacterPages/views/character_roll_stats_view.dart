import 'package:dungeon_paper/app/data/models/roll_stats.dart';
import 'package:dungeon_paper/app/modules/UpsertCharacterPages/controllers/character_roll_stats_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class CharacterRollStatsView extends GetView<CharacterRollStatsController> {
  final void Function(bool valid, RollStats? rollStats) onValidate;

  const CharacterRollStatsView({
    Key? key,
    required this.onValidate,
  }) : super(key: key);

  updateControllers() {
    debugPrint('validating: ${controller.validate()}');
    debugPrint(controller.textControllers.toString());
    debugPrint(controller.textControllers.values
        .map((v) => [v.text.isEmpty, int.tryParse(v.text)])
        .join(', '));
    onValidate(controller.validate(), controller.isValid ? controller.rollStats.value : null);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // final theme = Theme.of(context);
      return ListView(
        padding: const EdgeInsets.all(16),
        shrinkWrap: true,
        children: [
          Text('Valid: ${controller.isValid}'),
          ...controller.textControllers.keys.map(
            (statKey) {
              final stat =
                  controller.rollStats.value.stats.firstWhere((stat) => stat.key == statKey);
              return Padding(
                padding: const EdgeInsets.all(4),
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
        ],
      );
    });
  }
}
