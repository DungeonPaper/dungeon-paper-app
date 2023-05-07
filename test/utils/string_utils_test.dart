import 'package:dungeon_paper/core/utils/string_utils.dart';
import 'package:test/test.dart';

void main() {
  group('String Utils', () {
    group('splitIntoWords', () {
      test('should work with spaces', () {
        expect(splitIntoWords('one two three'), equals(['one', 'two', 'three']));
      });
      test('should work with underscores', () {
        expect(splitIntoWords('one_two_three'), equals(['one', 'two', 'three']));
      });
      test('should work with numbers', () {
        expect(splitIntoWords('one_2_two_three'), equals(['one', '2', 'two', 'three']));
      });
      test('should work with pascalCase', () {
        expect(splitIntoWords('OneTwoThree'), equals(['One', 'Two', 'Three']));
      });
      test('should work with camelCase', () {
        expect(splitIntoWords('oneTwoThree'), equals(['one', 'Two', 'Three']));
      });
    });

    group('toCamelCase', () {
      test('should work', () {
        expect(toCamelCase('my string'), equals('myString'));
        expect(toCamelCase('my_string'), equals('myString'));
        expect(toCamelCase('myString'), equals('myString'));
        expect(toCamelCase('MyString'), equals('myString'));
        expect(toCamelCase('My-string'), equals('myString'));
        expect(toCamelCase('My string'), equals('myString'));
        expect(toCamelCase(''), isNot(throwsException));
        expect(toCamelCase('a'), isNot(throwsException));
      });
    });
    group('toPascalCase', () {
      test('should work', () {
        expect(toPascalCase('my string'), equals('MyString'));
        expect(toPascalCase('my_string'), equals('MyString'));
        expect(toPascalCase('myString'), equals('MyString'));
        expect(toPascalCase('MyString'), equals('MyString'));
        expect(toPascalCase('My-string'), equals('MyString'));
        expect(toPascalCase('My string'), equals('MyString'));
        expect(toPascalCase(''), isNot(throwsException));
        expect(toPascalCase('a'), isNot(throwsException));
      });
    });
    group('toTitleCase', () {
      test('should work', () {
        expect(toTitleCase('my string'), equals('My String'));
        expect(toTitleCase('my_string'), equals('My String'));
        expect(toTitleCase('myString'), equals('My String'));
        expect(toTitleCase('MyString'), equals('My String'));
        expect(toTitleCase('My-string'), equals('My String'));
        expect(toTitleCase('My string'), equals('My String'));
        expect(toTitleCase(''), isNot(throwsException));
        expect(toTitleCase('a'), isNot(throwsException));
      });
    });
    group('toSnakeCase', () {
      test('should work', () {
        expect(toSnakeCase('my string'), equals('my_string'));
        expect(toSnakeCase('my_string'), equals('my_string'));
        expect(toSnakeCase('myString'), equals('my_string'));
        expect(toSnakeCase('MyString'), equals('my_string'));
        expect(toSnakeCase('My-string'), equals('my_string'));
        expect(toSnakeCase('My string'), equals('my_string'));
        expect(toSnakeCase(''), isNot(throwsException));
        expect(toSnakeCase('a'), isNot(throwsException));
      });
    });
    group('toKebabCase', () {
      test('should work', () {
        expect(toKebabCase('my string'), equals('my-string'));
        expect(toKebabCase('my_string'), equals('my-string'));
        expect(toKebabCase('myString'), equals('my-string'));
        expect(toKebabCase('MyString'), equals('my-string'));
        expect(toKebabCase('My-string'), equals('my-string'));
        expect(toKebabCase('My string'), equals('my-string'));
        expect(toKebabCase(''), isNot(throwsException));
        expect(toKebabCase('a'), isNot(throwsException));
      });
    });
  });
}
