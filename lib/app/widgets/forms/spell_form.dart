import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/data/models/ability_scores.dart';
import 'package:dungeon_paper/app/data/services/repository_service.dart';
import 'package:dungeon_paper/app/widgets/atoms/rich_text_field.dart';
import 'package:dungeon_paper/app/widgets/atoms/select_box.dart';
import 'package:dungeon_paper/app/widgets/forms/library_entity_form.dart';
import 'package:dungeon_paper/app/widgets/molecules/dice_list_input.dart';
import 'package:dungeon_paper/app/widgets/molecules/tag_list_input.dart';
import 'package:dungeon_paper/core/utils/math_utils.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;

class SpellForm extends GetView<SpellFormController> with RepositoryServiceMixin {
  const SpellForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LibraryEntityForm<Spell, SpellFormController>(
      children: [
        () => Obx(
              () => TextFormField(
                decoration: InputDecoration(
                  label: Text(S.current.formGeneralNameGeneric(S.current.entity(Spell))),
                ),
                textCapitalization: TextCapitalization.words,
                controller: controller.name,
              ),
            ),
        () => Row(
              children: [
                Expanded(
                  child: Obx(
                    () => SelectBox<String>(
                      value: controller.level.value,
                      label: Text(S.current.entity(S.current.level)),
                      isExpanded: true,
                      items: {'cantrip', 'rote', ...range(9).map((i) => (i + 1).toString())}
                          .map(
                            (lv) => DropdownMenuItem(
                              child: Text(S.current.spellLevel(lv)),
                              value: lv,
                            ),
                          )
                          .toList(),
                      onChanged: (value) => controller.level.value = value!,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Obx(
                    () => SelectBox<dw.EntityReference>(
                      value: controller.classKeys.value.isNotEmpty
                          ? controller.classKeys.value.first
                          : null,
                      onChanged: (value) => controller.classKeys.value = [value!],
                      isExpanded: true,
                      label: Text(S.current.entity(CharacterClass)),
                      items: {...repo.builtIn.classes.values, ...repo.my.classes.values}
                          .map(
                            (cls) => DropdownMenuItem(
                              child: Text(cls.name),
                              value: cls.reference,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
        () => Obx(
              () => RichTextField(
                decoration: InputDecoration(
                  label: Text(S.current.formGeneralDescriptionGeneric(S.current.entity(Spell))),
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
                  label: Text(S.current.formGeneralExplanationGeneric(S.current.entity(Spell))),
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
                abilityScores: controller.args.abilityScores ?? AbilityScores.dungeonWorldAll(10),
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

class SpellFormController extends LibraryEntityFormController<Spell, SpellFormArguments> {
  final _name = TextEditingController().obs;
  final _description = TextEditingController().obs;
  final _explanation = TextEditingController().obs;
  final _dice = ValueNotifier<List<dw.Dice>>([]).obs;
  final _tags = ValueNotifier<List<dw.Tag>>([]).obs;
  final _category = ValueNotifier('').obs;
  final _classKeys = ValueNotifier<List<dw.EntityReference>>([]).obs;

  TextEditingController get name => _name.value;
  TextEditingController get description => _description.value;
  TextEditingController get explanation => _explanation.value;
  ValueNotifier<List<dw.Dice>> get dice => _dice.value;
  ValueNotifier<List<dw.Tag>> get tags => _tags.value;
  ValueNotifier<String> get level => _category.value;
  ValueNotifier<List<dw.EntityReference>> get classKeys => _classKeys.value;

  @override
  List<Rx<ValueNotifier>> get fields =>
      [_name, _description, _explanation, _dice, _tags, _category, _classKeys];

  @override
  void onInit() {
    super.onInit();
    name.text = args.entity?.name ?? '';
    description.text = args.entity?.description ?? '';
    explanation.text = args.entity?.explanation ?? '';
    dice.value = args.entity?.dice ?? [];
    tags.value = args.entity?.tags ?? [];
    level.value = args.entity?.level ?? 'cantrip';
    classKeys.value = args.entity?.classKeys ?? [];
  }

  @override
  void updateFromEntity(Spell entity) {
    super.updateFromEntity(entity);
    name.text = entity.name;
    description.text = entity.description;
    explanation.text = entity.explanation;
    dice.value = entity.dice;
    tags.value = entity.tags;
    level.value = entity.level;
    classKeys.value = entity.classKeys;
  }

  @override
  Spell toEntity() => super.toEntity().copyWithInherited(
        name: name.text,
        description: description.text,
        explanation: explanation.text,
        dice: dice.value,
        tags: tags.value,
        level: level.value,
        classKeys: classKeys.value,
      );

  @override
  Spell empty() => Spell.empty();
}

class SpellFormArguments extends LibraryEntityFormArguments<Spell> {
  final AbilityScores? abilityScores;

  SpellFormArguments({
    required super.entity,
    required this.abilityScores,
    required super.onSave,
    required super.formContext,
  });
}
