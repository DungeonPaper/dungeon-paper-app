import 'package:dungeon_paper/app/data/models/ability_scores.dart';
import 'package:dungeon_paper/core/route_arguments.dart';
import 'package:dungeon_paper/core/utils/enums.dart';
import 'package:dungeon_paper/core/utils/string_validator.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';

class AbilityScoreFormController extends ChangeNotifier {
  late final AbilityScore entity;

  late final TextEditingController _key;
  TextEditingController get key => _key;

  late final TextEditingController _name;
  TextEditingController get name => _name;

  late final TextEditingController _description;
  TextEditingController get description => _description;

  late final TextEditingController _debilityName;
  TextEditingController get debilityName => _debilityName;

  late final TextEditingController _debilityDescription;
  TextEditingController get debilityDescription => _debilityDescription;

  late final IconData? _icon;
  IconData? get icon => _icon;

  late final void Function(AbilityScore abilityScore) onSave;

  late final FormContext formContext;

  AbilityScoreFormController(BuildContext context) {
    final AbilityScoreFormArguments args = getArgs(context);
    formContext =
        args.abilityScore != null ? FormContext.edit : FormContext.create;
    if (args.abilityScore != null) {
      entity = args.abilityScore!;
    } else {
      entity = AbilityScore.empty();
    }
    onSave = args.onSave;
    _key = TextEditingController(text: entity.key);
    _name = TextEditingController(text: entity.name);
    _description = TextEditingController(text: entity.description);
    _debilityName = TextEditingController(text: entity.debilityName);
    _debilityDescription =
        TextEditingController(text: entity.debilityDescription);
    _icon = entity.customIcon;
  }

  @override
  void dispose() {
    super.dispose();
    _key.dispose();
    _name.dispose();
    _description.dispose();
    _debilityName.dispose();
    _debilityDescription.dispose();
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
        patternMessage: tr.errors.onlyLetters,
      ).validator(value);

  String? requiredValidator(String? value) =>
      StringValidator(minLength: 1).validator(value);

  void save(BuildContext context) {
    onSave(
      entity.copyWith(
        key: key.text,
        name: name.text,
        description: description.text,
        debilityName: debilityName.text,
        debilityDescription: debilityDescription.text,
        icon: icon,
      ),
    );
    Navigator.of(context).pop();
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