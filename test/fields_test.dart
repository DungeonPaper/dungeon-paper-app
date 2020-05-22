import 'package:dungeon_paper/db/models/firebase_entity/fields/fields.dart';
import 'package:flutter_test/flutter_test.dart';
import 'helpers/entity_base_helper.dart';

void main() {
  group('Fields', () {
    test('Dirty fields', () {
      var testA = EntityTestBase(data: {'a': 10});
      var json = testA.toJSON();

      expect(testA.a, equals(10));
      expect(json['a'], equals(10));
      expect(testA.fields.dirtyFields, isNot(contains('a')));
      testA.a = 20;
      var json2 = testA.toJSON();

      expect(testA.a, equals(20));
      expect(json2['a'], equals(20));
      expect(testA.fields.dirtyFields, contains('a'));
    });

    group('Field types', () {
      test('Empty values', () {
        expect(StringField(fieldName: '_').value, equals(''));
        expect(IntField(fieldName: '_').value, equals(0));
        expect(DecimalField(fieldName: '_').value, equals(0.0));
        expect(StringListField(fieldName: '_').value, equals(<String>[]));
        expect(
          MapOfField<String, String>(
            fieldName: '_',
            field: StringField(fieldName: '__'),
          ).value,
          equals(<String, String>{}),
        );
        expect(BoolField(fieldName: '_').value, equals(false));
      });
    });
  });
}
