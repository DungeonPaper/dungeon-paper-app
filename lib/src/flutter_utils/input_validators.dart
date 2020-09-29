class PasswordValidator {
  static const MIN_LENGTH = 8;

  static bool validate(String password) =>
      password?.isNotEmpty == true && password.length >= MIN_LENGTH;
}
