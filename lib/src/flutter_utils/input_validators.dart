import 'package:flutter/foundation.dart';

abstract class PasswordValidation {
  PasswordValidation(this.message);

  bool validate(String password);
  final String message;
}

class PasswordLengthValidation extends PasswordValidation {
  final int minLength;

  PasswordLengthValidation({
    @required this.minLength,
  }) : super('Password is too short');

  @override
  bool validate(String password) => password.length >= minLength;
}

class PasswordContainsValidation extends PasswordValidation {
  final Pattern pattern;

  PasswordContainsValidation({
    @required this.pattern,
    String message,
  }) : super(message ?? 'Password must contain $pattern');

  @override
  bool validate(String password) => password.contains(pattern);
}

class PasswordValidator {
  static const MIN_LENGTH = 8;

  static final Iterable<PasswordValidation> _validators = [
    PasswordLengthValidation(minLength: MIN_LENGTH),
    PasswordContainsValidation(
      pattern: RegExp('[A-Z]'),
      message: 'Password must contain at least 1 capital letter',
    ),
    PasswordContainsValidation(
      pattern: RegExp('[0-9]'),
      message: 'Password must contain at least 1 number',
    ),
  ];

  static PasswordValidation getError(String password) => _validators.firstWhere(
        (vl) => vl.validate(password) == false,
        orElse: () => null,
      );

  static bool validate(String password) => getError(password) == null;

  static String getMessage(String password) =>
      !validate(password) ? getError(password)?.message : null;
}
