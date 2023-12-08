import 'package:dungeon_paper/core/utils/string_validator.dart';
import 'package:dungeon_paper/i18n.dart';

class PasswordValidator extends CompoundStringValidator {
  static const minLength = 8;

  @override
  List<Validation> get validators => [
        StringMinLengthValidation(minLength: minLength),
        StringContainsValidation(
          pattern: RegExp('[A-Z]'),
          message: tr.errors.invalidPassword.letter,
        ),
        StringContainsValidation(
          pattern: RegExp('[0-9]'),
          message: tr.errors.invalidPassword.number,
        ),
      ];
}
