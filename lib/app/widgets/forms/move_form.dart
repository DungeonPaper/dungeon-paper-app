import 'package:dungeon_paper/app/data/models/ability_scores.dart';
import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/move_templates.dart';
import 'package:dungeon_paper/app/data/services/repository_provider.dart';
import 'package:dungeon_paper/app/widgets/atoms/rich_text_field.dart';
import 'package:dungeon_paper/app/widgets/atoms/select_box.dart';
import 'package:dungeon_paper/app/widgets/forms/library_entity_form.dart';
import 'package:dungeon_paper/app/widgets/molecules/dice_list_input.dart';
import 'package:dungeon_paper/app/widgets/molecules/tag_list_input.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MoveForm extends StatelessWidget with RepositoryProviderMixin {
  const MoveForm({super.key});

  @override
  Widget build(BuildContext context) {
    return LibraryEntityForm<Move, MoveFormController>(
      children: [
        () => Consumer<MoveFormController>(
              builder: (context, controller, _) => TextFormField(
                decoration: InputDecoration(
                  label: Text(tr.generic.entityName(tr.entity(tn(Move)))),
                ),
                textCapitalization: TextCapitalization.words,
                controller: controller.name,
              ),
            ),
        () => Consumer<MoveFormController>(
              builder: (context, controller, _) => Row(
                children: [
                  Expanded(
                    child: SelectBox<MoveCategory>(
                      value: controller.category.value,
                      label: Text(tr.entity(tn(MoveCategory))),
                      isExpanded: true,
                      items: MoveCategory.values
                          .map(
                            (cat) => DropdownMenuItem(
                              value: cat,
                              child:
                                  Text(tr.moves.category.shortName(cat.name)),
                            ),
                          )
                          .toList(),
                      onChanged: (value) => controller.category.value = value!,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: SelectBox<dw.EntityReference>(
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
                ],
              ),
            ),
        () => Consumer<MoveFormController>(
              builder: (context, controller, _) => RichTextField(
                decoration: InputDecoration(
                  label: Text(
                    tr.generic.entityDescription(tr.entity(tn(Move))),
                  ),
                ),
                maxLines: 10,
                minLines: 5,
                textCapitalization: TextCapitalization.sentences,
                controller: controller.description,
                customButtons: [
                  RichButton.dropdown(
                    icon: Icons.list_alt,
                    // TODO intl
                    tooltip: 'Move Templates',
                    actions: [
                      ...MoveTemplateList.templates.map(
                        (template) => RichButtonAction.dropdownItem(
                          text: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(template.shortLabel),
                              Text(
                                template.longLabel,
                                textScaleFactor: 0.8,
                              ),
                            ],
                          ),
                          defaultContent: () => template.text,
                          prefix: () => template.text,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
        () => Consumer<MoveFormController>(
              builder: (context, controller, _) => RichTextField(
                decoration: InputDecoration(
                  label: Text(
                    tr.generic.entityExplanation(tr.entity(tn(Move))),
                  ),
                ),
                maxLines: 10,
                minLines: 5,
                rich: true,
                textCapitalization: TextCapitalization.sentences,
                controller: controller.explanation,
              ),
            ),
        () => Consumer<MoveFormController>(
              builder: (context, controller, _) => DiceListInput(
                controller: controller.dice,
                abilityScores: controller.args.abilityScores ??
                    AbilityScores.dungeonWorldAll(10),
                guessFrom: [controller.description, controller.explanation],
              ),
            ),
        () => Consumer<MoveFormController>(
              builder: (context, controller, _) => TagListInput(
                controller: controller.tags,
              ),
            ),
      ],
    );
  }
}

class MoveFormController
    extends LibraryEntityFormController<Move, MoveFormArguments> {
  final _name = TextEditingController();
  final _description = TextEditingController();
  final _explanation = TextEditingController();
  final _dice = ValueNotifier<List<dw.Dice>>([]);
  final _tags = ValueNotifier<List<dw.Tag>>([]);
  final _category = ValueNotifier(MoveCategory.basic);
  final _classKeys = ValueNotifier<List<dw.EntityReference>>([]);

  TextEditingController get name => _name;
  TextEditingController get description => _description;
  TextEditingController get explanation => _explanation;
  ValueNotifier<List<dw.Dice>> get dice => _dice;
  ValueNotifier<List<dw.Tag>> get tags => _tags;
  ValueNotifier<MoveCategory> get category => _category;
  ValueNotifier<List<dw.EntityReference>> get classKeys => _classKeys;

  @override
  List<ValueNotifier> get fields =>
      [_name, _description, _explanation, _dice, _tags, _category, _classKeys];

  MoveFormController(super.context) {
    name.text = args.entity?.name ?? '';
    description.text = args.entity?.description ?? '';
    explanation.text = args.entity?.explanation ?? '';
    dice.value = args.entity?.dice ?? [];
    tags.value = args.entity?.tags ?? [];
    category.value = args.entity?.category ?? MoveCategory.basic;
    classKeys.value = args.entity?.classKeys ?? [];
  }

  @override
  void updateFromEntity(Move entity) {
    super.updateFromEntity(entity);
    name.text = entity.name;
    description.text = entity.description;
    explanation.text = entity.explanation;
    dice.value = entity.dice;
    tags.value = entity.tags;
    category.value = entity.category;
    classKeys.value = entity.classKeys;
  }

  @override
  Move toEntity() => super.toEntity().copyWithInherited(
        name: name.text,
        description: description.text,
        explanation: explanation.text,
        dice: dice.value,
        tags: tags.value,
        category: category.value,
        classKeys: classKeys.value,
      );

  @override
  Move empty() => Move.empty();
}

class MoveFormArguments extends LibraryEntityFormArguments<Move> {
  final AbilityScores? abilityScores;

  MoveFormArguments({
    required super.entity,
    required this.abilityScores,
    required super.onSave,
    required super.formContext,
  });
}
