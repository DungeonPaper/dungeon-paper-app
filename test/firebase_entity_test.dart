import 'package:flutter_test/flutter_test.dart';
import 'helpers/entity_base_helper.dart';

void main() {
  group('Firebase Entity', () {
    test('Direct inheritence', () {
      var testA = EntityTestBase(data: {'a': 10});
      var json = testA.toJSON();

      expect(testA.a, equals(10));
      expect(json['a'], equals(10));
    });

    test('Extended inheritence', () {
      var testB = EntityTest(data: {'a': 5, 'b': 'Gohan'});
      var json = testB.toJSON();

      expect(testB.a, equals(5));
      expect(testB.b, equals('Gohan'));
      expect(json['a'], equals(5));
      expect(json['b'], equals('Gohan'));
    });
  });
}
