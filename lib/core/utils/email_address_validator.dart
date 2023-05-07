import 'package:dungeon_paper/core/utils/string_validator.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:email_validator/email_validator.dart';

class EmailAddressValidator extends Validation {
  EmailAddressValidator() : super(S.current.errorInvalidEmail);

  @override
  bool isValid(String? string) {
    if (string == null) {
      return true;
    }
    return EmailValidator.validate(string);
  }
}
