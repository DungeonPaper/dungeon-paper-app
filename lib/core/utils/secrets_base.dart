part 'secrets.dart';

abstract class SecretsBase {
  String get sentryDsn;
}

final secrets = Secrets();
