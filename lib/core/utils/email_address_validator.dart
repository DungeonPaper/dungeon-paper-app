import 'package:dungeon_paper/core/utils/string_validator.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:email_validator/email_validator.dart';

class EmailAddressValidator extends Validation {
  EmailAddressValidator() : super(tr.errors.invalidEmail);

  @override
  bool isValid(String? string) {
    if (string == null) {
      return true;
    }
    return EmailValidator.validate(string);
  }
}
