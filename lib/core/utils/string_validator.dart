import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:dungeon_paper/i18n.dart';

abstract class Validation {
  Validation(this.message);

  bool isValid(String? string);
  final String message;

  String? validator(String? string) => isValid(string) ? null : message;
}

class StringMinLengthValidation extends Validation {
  final int minLength;

  StringMinLengthValidation({
    required this.minLength,
  }) : super(tr.errors.minLength(minLength));

  @override
  bool isValid(String? string) => string == null || string.length >= minLength;
}

class StringExactLengthValidation extends Validation {
  final int length;

  StringExactLengthValidation({
    required this.length,
  }) : super(tr.errors.exactLength(length));

  @override
  bool isValid(String? string) => string == null || string.length == length;
}

class StringMaxLengthValidation extends Validation {
  final int maxLength;

  StringMaxLengthValidation({
    required this.maxLength,
  }) : super(tr.errors.maxLength(maxLength));

  @override
  bool isValid(String? string) => string == null || string.length <= maxLength;
}

class StringContainsValidation extends Validation {
  final Pattern pattern;
  final String? userFriendlyPattern;

  StringContainsValidation({
    required this.pattern,
    this.userFriendlyPattern,
    String? message,
  }) : super(message ??
            tr.errors.mustContain((userFriendlyPattern ?? pattern).toString()));

  @override
  bool isValid(String? string) => string == null || string.contains(pattern);
}

class StringNotContainsValidation extends Validation {
  final Pattern pattern;
  final String? userFriendlyPattern;

  StringNotContainsValidation({
    required this.pattern,
    this.userFriendlyPattern,
    String? message,
  }) : super(message ??
            tr.errors
                .mustNotContain((userFriendlyPattern ?? pattern).toString()));

  @override
  bool isValid(String? string) => string == null || !string.contains(pattern);
}

abstract class CompoundStringValidator extends Validation {
  CompoundStringValidator() : super('');

  List<Validation> get validators;

  @override
  bool isValid(String? string) => validators.every((v) => v.isValid(string));

  @override
  String? validator(String? string) {
    return validators.firstWhereOrNull((v) {
      return !v.isValid(string);
    })?.message;
  }
}

class StringValidator extends CompoundStringValidator {
  final int? minLength;
  final int? maxLength;
  final int? exactLength;
  final Pattern? containsPattern;
  final Pattern? notContainsPattern;
  final String? userFriendlyPattern;
  final String? patternMessage;

  StringValidator({
    this.minLength,
    this.maxLength,
    this.exactLength,
    this.containsPattern,
    this.notContainsPattern,
    this.userFriendlyPattern,
    this.patternMessage,
  });

  @override
  List<Validation> get validators => [
        if (minLength != null) StringMinLengthValidation(minLength: minLength!),
        if (maxLength != null) StringMaxLengthValidation(maxLength: maxLength!),
        if (exactLength != null)
          StringExactLengthValidation(length: exactLength!),
        if (containsPattern != null)
          StringContainsValidation(
            pattern: containsPattern!,
            userFriendlyPattern: userFriendlyPattern,
            message: patternMessage,
          ),
        if (notContainsPattern != null)
          StringNotContainsValidation(
            pattern: notContainsPattern!,
            userFriendlyPattern: userFriendlyPattern,
            message: patternMessage,
          ),
      ];
}
