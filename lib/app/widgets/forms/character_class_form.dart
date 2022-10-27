import 'package:dungeon_paper/app/data/models/ability_scores.dart';
import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/widgets/atoms/number_text_field.dart';
import 'package:dungeon_paper/app/widgets/atoms/rich_text_field.dart';
import 'package:dungeon_paper/app/widgets/forms/library_entity_form.dart';
import 'package:dungeon_paper/app/widgets/molecules/dice_list_input.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CharacterClassForm extends GetView<CharacterClassFormController> {
  const CharacterClassForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LibraryEntityForm<CharacterClass, CharacterClassFormController>(
      children: [
        () => TextFormField(
              controller: controller.name,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                label: Text(S.current.formGeneralNameGeneric(S.current.entity(CharacterClass))),
              ),
            ),
        () => const SizedBox(height: 16),
        () => RichTextField(
              controller: controller.description,
              label: S.current.formGeneralDescriptionGeneric(S.current.entity(CharacterClass)),
              maxLines: 10,
              minLines: 5,
              textCapitalization: TextCapitalization.sentences,
            ),
        () => DiceListInput(
              controller: controller.damageDice,
              label: Text(S.current.formCharacterClassDamage),
              abilityScores: AbilityScores.dungeonWorld(
                cha: 12,
                con: 12,
                dex: 12,
                str: 12,
                wis: 12,
                intl: 12,
              ),
              guessFrom: [controller.description],
              maxCount: 1,
            ),
        () => Row(
              children: [
                Expanded(
                  child: NumberTextField(
                    numberType: NumberType.int,
                    controller: controller.hp,
                    decoration: InputDecoration(
                      label: Text(S.current.formCharacterClassBaseHp),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: NumberTextField(
                    numberType: NumberType.int,
                    controller: controller.load,
                    decoration: InputDecoration(
                      label: Text(S.current.formCharacterClassBaseLoad),
                    ),
                  ),
                ),
              ],
            ),
      ],
    );
  }
}

class CharacterClassFormController
    extends LibraryEntityFormController<CharacterClass, CharacterClassFormArguments> {
  final _name = TextEditingController().obs;
  final _description = TextEditingController().obs;
  final _damageDice = ValueNotifier<List<dw.Dice>>([dw.Dice.d4]).obs;
  final _hp = TextEditingController().obs;
  final _load = TextEditingController().obs;

  @override
  List<Rx<ValueNotifier>> get fields => [_name, _description, _damageDice];

  TextEditingController get name => _name.value;
  TextEditingController get description => _description.value;
  ValueNotifier<List<dw.Dice>> get damageDice => _damageDice.value;
  TextEditingController get hp => _hp.value;
  TextEditingController get load => _load.value;

  @override
  void onInit() {
    super.onInit();
    name.text = args.entity?.name ?? '';
    description.text = args.entity?.description ?? '';
    damageDice.value = asList(args.entity?.damageDice ?? dw.Dice.d4);
    hp.text = args.entity?.hp.toString() ?? '';
    load.text = args.entity?.load.toString() ?? '';
  }

  @override
  void updateFromEntity(CharacterClass entity) {
    super.updateFromEntity(entity);
    name.text = entity.name;
    description.text = entity.description;
    damageDice.value = asList(entity.damageDice);
    hp.text = entity.hp.toString();
    load.text = entity.load.toString();
  }

  @override
  empty() => CharacterClass.empty();

  @override
  CharacterClass toEntity() => super.toEntity().copyWithInherited(
        name: name.text,
        description: description.text,
        damageDice: damageDice.value.single,
        hp: int.tryParse(hp.text) ?? 0,
        load: int.tryParse(load.text) ?? 0,
      );
}

class CharacterClassFormArguments extends LibraryEntityFormArguments<CharacterClass> {
  CharacterClassFormArguments({
    required super.entity,
    required super.onSave,
    required super.formContext,
  });
}
