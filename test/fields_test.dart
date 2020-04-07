import 'package:flutter_test/flutter_test.dart';
import 'helpers/entity_base_helper.dart';

void main() {
  group('Fields', () {
    test('Dirty field', () {
      var testA = EntityTestBase(data: {'a': 10});
      var json = testA.toJSON();

      expect(testA.a, equals(10));
      expect(json['a'], equals(10));
    });
  });
}
