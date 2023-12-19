import 'package:dungeon_paper/app/data/models/ability_scores.dart';
import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/race.dart';
import 'package:dungeon_paper/app/data/services/repository_service.dart';
import 'package:dungeon_paper/app/widgets/atoms/rich_text_field.dart';
import 'package:dungeon_paper/app/widgets/atoms/select_box.dart';
import 'package:dungeon_paper/app/widgets/forms/library_entity_form.dart';
import 'package:dungeon_paper/app/widgets/molecules/dice_list_input.dart';
import 'package:dungeon_paper/app/widgets/molecules/tag_list_input.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RaceForm extends GetView<RaceFormController> with RepositoryServiceMixin {
  const RaceForm({super.key});

  @override
  Widget build(BuildContext context) {
    return LibraryEntityForm<Race, RaceFormController>(
      children: [
        () => Obx(
              () => TextFormField(
                decoration: InputDecoration(
                  label: Text(tr.generic.entityName(tr.entity(tn(Race)))),
                ),
                textCapitalization: TextCapitalization.words,
                controller: controller.name,
              ),
            ),
        () => Obx(
              () => SelectBox<dw.EntityReference>(
                value: controller.classKeys.value.isNotEmpty
                    ? controller.classKeys.value.first
                    : null,
                onChanged: (value) => controller.classKeys.value = [value!],
                isExpanded: true,
                label: Text(tr.entity(tn(CharacterClass))),
                items:
                    {...repo.builtIn.classes.values, ...repo.my.classes.values}
                        .map(
                          (cls) => DropdownMenuItem(
                            value: cls.reference,
                            child: Text(cls.name),
                          ),
                        )
                        .toList(),
              ),
            ),
        () => Obx(
              () => RichTextField(
                decoration: InputDecoration(
                  label:
                      Text(tr.generic.entityDescription(tr.entity(tn(Race)))),
                ),
                maxLines: 10,
                minLines: 5,
                rich: true,
                textCapitalization: TextCapitalization.sentences,
                controller: controller.description,
              ),
            ),
        () => Obx(
              () => RichTextField(
                decoration: InputDecoration(
                  label:
                      Text(tr.generic.entityExplanation(tr.entity(tn(Race)))),
                ),
                maxLines: 10,
                minLines: 5,
                rich: true,
                textCapitalization: TextCapitalization.sentences,
                controller: controller.explanation,
              ),
            ),
        () => Obx(
              () => DiceListInput(
                controller: controller.dice,
                abilityScores: controller.args.abilityScores ??
                    AbilityScores.dungeonWorldAll(10),
                guessFrom: [controller.description, controller.explanation],
              ),
            ),
        () => Obx(
              () => TagListInput(
                controller: controller.tags,
              ),
            ),
      ],
    );
  }
}

class RaceFormController
    extends LibraryEntityFormController<Race, RaceFormArguments> {
  final _name = TextEditingController();
  final _description = TextEditingController();
  final _explanation = TextEditingController();
  final _dice = ValueNotifier<List<dw.Dice>>([]);
  final _tags = ValueNotifier<List<dw.Tag>>([]);
  final _classKeys = ValueNotifier<List<dw.EntityReference>>([]);

  TextEditingController get name => _name;
  TextEditingController get description => _description;
  TextEditingController get explanation => _explanation;
  ValueNotifier<List<dw.Dice>> get dice => _dice;
  ValueNotifier<List<dw.Tag>> get tags => _tags;
  ValueNotifier<List<dw.EntityReference>> get classKeys => _classKeys;

  @override
  List<ValueNotifier> get fields =>
      [_name, _description, _explanation, _dice, _tags, _classKeys];

RaceFormController(super.context) {
    name.text = args.entity?.name ?? '';
    description.text = args.entity?.description ?? '';
    explanation.text = args.entity?.explanation ?? '';
    dice.value = args.entity?.dice ?? [];
    tags.value = args.entity?.tags ?? [];
    classKeys.value = args.entity?.classKeys ?? [];
  }

  @override
  void updateFromEntity(Race entity) {
    super.updateFromEntity(entity);
    name.text = entity.name;
    description.text = entity.description;
    explanation.text = entity.explanation;
    dice.value = entity.dice;
    tags.value = entity.tags;
    classKeys.value = entity.classKeys;
  }

  @override
  Race toEntity() => super.toEntity().copyWithInherited(
        name: name.text,
        description: description.text,
        explanation: explanation.text,
        dice: dice.value,
        tags: tags.value,
        classKeys: classKeys.value,
      );

  @override
  Race empty() => Race.empty();
}

class RaceFormArguments extends LibraryEntityFormArguments<Race> {
  final AbilityScores? abilityScores;

  RaceFormArguments({
    required super.entity,
    required this.abilityScores,
    required super.onSave,
    required super.formContext,
  });
}
