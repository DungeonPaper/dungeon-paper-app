import 'package:dungeon_paper/generated/l10n.dart';
import 'package:get/get.dart';

abstract class PasswordValidation {
  PasswordValidation(this.message);

  bool validate(String? password);
  final String message;
}

class PasswordLengthValidation extends PasswordValidation {
  final int minLength;

  PasswordLengthValidation({
    required this.minLength,
  }) : super(S.current.signupPasswordValidationLength(minLength));

  @override
  bool validate(String? password) => password == null || password.length >= minLength;
}

class PasswordContainsValidation extends PasswordValidation {
  final Pattern pattern;

  PasswordContainsValidation({
    required this.pattern,
    String? message,
  }) : super(message ?? S.current.signupPasswordValidationPatternGeneric(pattern));

  @override
  bool validate(String? password) => password == null || password.contains(pattern);
}

class PasswordValidator {
  static const minLength = 8;

  static final Iterable<PasswordValidation> _validators = [
    PasswordLengthValidation(minLength: minLength),
    PasswordContainsValidation(
      pattern: RegExp('[A-Z]'),
      message: S.current.signupPasswordValidationPatternLetter,
    ),
    PasswordContainsValidation(
      pattern: RegExp('[0-9]'),
      message: S.current.signupPasswordValidationPatternNumber,
    ),
  ];

  static PasswordValidation? getError(String? password) =>
      (_validators.cast<PasswordValidation?>()).toList().firstWhereOrNull(
            (vl) => vl?.validate(password) == false,
          );

  static bool validate(String? password) => getError(password) == null;

  static String? getMessage(String? password) =>
      !validate(password) ? getError(password)?.message : null;
}
