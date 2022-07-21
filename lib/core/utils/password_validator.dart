import 'package:dungeon_paper/core/utils/string_validator.dart';
import 'package:dungeon_paper/generated/l10n.dart';

class PasswordValidator extends CompoundStringValidator {
  static const minLength = 8;

  @override
  List<Validation> get validators => [
        StringMinLengthValidation(minLength: minLength),
        StringContainsValidation(
          pattern: RegExp('[A-Z]'),
          message: S.current.signupPasswordValidationPatternLetter,
        ),
        StringContainsValidation(
          pattern: RegExp('[0-9]'),
          message: S.current.signupPasswordValidationPatternNumber,
        ),
      ];
}
