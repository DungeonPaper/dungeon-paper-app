import 'package:dungeon_paper/app/data/models/ability_scores.dart';
import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/data/services/repository_provider.dart';
import 'package:dungeon_paper/app/widgets/atoms/rich_text_field.dart';
import 'package:dungeon_paper/app/widgets/atoms/select_box.dart';
import 'package:dungeon_paper/app/widgets/forms/library_entity_form.dart';
import 'package:dungeon_paper/app/widgets/molecules/dice_list_input.dart';
import 'package:dungeon_paper/app/widgets/molecules/tag_list_input.dart';
import 'package:dungeon_paper/core/utils/math_utils.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SpellForm extends StatelessWidget with RepositoryProviderMixin {
  const SpellForm({super.key});

  @override
  Widget build(BuildContext context) {
    return LibraryEntityForm<Spell, SpellFormController>(
      children: [
        () => Consumer<SpellFormController>(
              builder: (context, controller, _) => TextFormField(
                decoration: InputDecoration(
                  label: Text(tr.generic.entityName(tr.entity(tn(Spell)))),
                ),
                textCapitalization: TextCapitalization.words,
                controller: controller.name,
              ),
            ),
        () => Row(
              children: [
                Expanded(
                  child: Consumer<SpellFormController>(
                    builder: (context, controller, _) => SelectBox<String>(
                      value: controller.level.value,
                      label: Text(tr.character.data.level),
                      isExpanded: true,
                      items: {
                        'cantrip',
                        'rote',
                        ...range(9).map((i) => (i + 1).toString())
                      }
                          .map(
                            (lv) => DropdownMenuItem(
                              value: lv,
                              child: Text(tr.spells.spellLevel(lv)),
                            ),
                          )
                          .toList(),
                      onChanged: (value) => controller.level.value = value!,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Consumer<SpellFormController>(
                    builder: (context, controller, _) =>
                        SelectBox<dw.EntityReference>(
                      value: controller.classKeys.value.isNotEmpty
                          ? controller.classKeys.value.first
                          : null,
                      onChanged: (value) =>
                          controller.classKeys.value = [value!],
                      isExpanded: true,
                      label: Text(tr.entity(tn(CharacterClass))),
                      items: {
                        ...repo.builtIn.classes.values,
                        ...repo.my.classes.values
                      }
                          .map(
                            (cls) => DropdownMenuItem(
                              value: cls.reference,
                              child: Text(cls.name),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
        () => Consumer<SpellFormController>(
              builder: (context, controller, _) => RichTextField(
                decoration: InputDecoration(
                  label:
                      Text(tr.generic.entityDescription(tr.entity(tn(Spell)))),
                ),
                maxLines: 10,
                minLines: 5,
                rich: true,
                textCapitalization: TextCapitalization.sentences,
                controller: controller.description,
              ),
            ),
        () => Consumer<SpellFormController>(
              builder: (context, controller, _) => RichTextField(
                decoration: InputDecoration(
                  label:
                      Text(tr.generic.entityExplanation(tr.entity(tn(Spell)))),
                ),
                maxLines: 10,
                minLines: 5,
                rich: true,
                textCapitalization: TextCapitalization.sentences,
                controller: controller.explanation,
              ),
            ),
        () => Consumer<SpellFormController>(
              builder: (context, controller, _) => DiceListInput(
                controller: controller.dice,
                abilityScores: controller.args.abilityScores ??
                    AbilityScores.dungeonWorldAll(10),
                guessFrom: [controller.description, controller.explanation],
              ),
            ),
        () => Consumer<SpellFormController>(
              builder: (context, controller, _) => TagListInput(
                controller: controller.tags,
              ),
            ),
      ],
    );
  }
}

class SpellFormController
    extends LibraryEntityFormController<Spell, SpellFormArguments> {
  final _name = TextEditingController();
  final _description = TextEditingController();
  final _explanation = TextEditingController();
  final _dice = ValueNotifier<List<dw.Dice>>([]);
  final _tags = ValueNotifier<List<dw.Tag>>([]);
  final _category = ValueNotifier('');
  final _classKeys = ValueNotifier<List<dw.EntityReference>>([]);

  TextEditingController get name => _name;
  TextEditingController get description => _description;
  TextEditingController get explanation => _explanation;
  ValueNotifier<List<dw.Dice>> get dice => _dice;
  ValueNotifier<List<dw.Tag>> get tags => _tags;
  ValueNotifier<String> get level => _category;
  ValueNotifier<List<dw.EntityReference>> get classKeys => _classKeys;

  @override
  List<ValueNotifier> get fields =>
      [_name, _description, _explanation, _dice, _tags, _category, _classKeys];

  SpellFormController(super.context) {
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

