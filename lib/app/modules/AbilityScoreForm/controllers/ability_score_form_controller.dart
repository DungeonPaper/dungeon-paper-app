import 'package:dungeon_paper/app/data/models/ability_scores.dart';
import 'package:dungeon_paper/core/utils/enums.dart';
import 'package:dungeon_paper/core/utils/string_validator.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AbilityScoreFormController extends GetxController {
  final entity = AbilityScore.empty().obs;

  late final Rx<TextEditingController> _key = TextEditingController().obs;
  TextEditingController get key => _key.value;

  late final Rx<TextEditingController> _name = TextEditingController().obs;
  TextEditingController get name => _name.value;

  late final Rx<TextEditingController> _description = TextEditingController().obs;
  TextEditingController get description => _description.value;

  late final Rx<TextEditingController> _debilityName = TextEditingController().obs;
  TextEditingController get debilityName => _debilityName.value;

  late final Rx<TextEditingController> _debilityDescription = TextEditingController().obs;
  TextEditingController get debilityDescription => _debilityDescription.value;

  late final Rx<IconData?> _icon = Rx(null);
  IconData? get icon => _icon.value;

  late final void Function(AbilityScore abilityScore) onSave;

  late final FormContext formContext;

  @override
  void onInit() {
    super.onInit();
    final AbilityScoreFormArguments args = Get.arguments;
    formContext = args.abilityScore != null ? FormContext.edit : FormContext.create;
    if (args.abilityScore != null) {
      entity.value = args.abilityScore!;
    }
    onSave = args.onSave;
    _key.value = TextEditingController(text: entity.value.key)..addListener(_update);
    _name.value = TextEditingController(text: entity.value.name)..addListener(_update);
    _description.value = TextEditingController(text: entity.value.description)
      ..addListener(_update);
    _debilityName.value = TextEditingController(text: entity.value.debilityName)
      ..addListener(_update);
    _debilityDescription.value = TextEditingController(text: entity.value.debilityDescription)
      ..addListener(_update);
    _icon.value = entity.value.customIcon;
  }

  @override
  void onClose() {
    _key.value.dispose();
    _name.value.dispose();
    _description.value.dispose();
    _debilityName.value.dispose();
    _debilityDescription.value.dispose();
    _icon.close();
    super.onClose();
  }

  bool get isValid => [
        key.text.isNotEmpty,
        name.text.isNotEmpty,
        description.text.isNotEmpty,
        debilityName.text.isNotEmpty,
        debilityDescription.text.isNotEmpty,
      ].every((element) => element == true);

  void pickIcon(BuildContext context) async {
    // _icon.value = await FlutterIconPicker.showIconPicker(context);
  }

  String? keyValidator(String? value) => StringValidator(
        exactLength: 3,
        notContainsPattern: RegExp(r'[^a-z]', caseSensitive: false),
        patternMessage: S.current.errorOnlyLetters,
      ).getErrorMessage(value);

  String? requiredValidator(String? value) => StringValidator(minLength: 1).getErrorMessage(value);

  void _update() {
    _key.refresh();
    _name.refresh();
    _description.refresh();
    _debilityName.refresh();
    _debilityDescription.refresh();
    _icon.refresh();
  }

  void save() {
    onSave(
      entity.value.copyWith(
        key: key.text,
        name: name.text,
        description: description.text,
        debilityName: debilityName.text,
        debilityDescription: debilityDescription.text,
        icon: icon,
      ),
    );
    Get.back();
  }
}

class AbilityScoreFormArguments {
  final AbilityScore? abilityScore;
  final void Function(AbilityScore abilityScore) onSave;

  AbilityScoreFormArguments({
    required this.abilityScore,
    required this.onSave,
  });
}
