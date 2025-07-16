// Copyright (c) 2024, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:decorator_gen/src/decorator_utils.dart';
import 'package:test/test.dart';

void main() {
  group('DecoratorUtils', () {
    group('isObjectMethod', () {
      late DecoratorUtils decoratorUtils;
      setUp(() {
        decoratorUtils = DecoratorUtils();
      });

      test('returns true for Object methods', () {
        expect(decoratorUtils.isObjectMethod('runtimeType'), isTrue);
        expect(decoratorUtils.isObjectMethod('noSuchMethod'), isTrue);
      });
      test(
          'returns false (by default) for '
          'toString, hashCode and == Object methods', () {
        expect(decoratorUtils.isObjectMethod('toString'), isFalse);
        expect(decoratorUtils.isObjectMethod('hashCode'), isFalse);
        expect(decoratorUtils.isObjectMethod('=='), isFalse);
      });

      test('default behaviour can be overridden by providing options', () {
        final decoratorUtils = DecoratorUtils(
          methodNameToIsForwarding: {
            'runtimeType': true,
            'noSuchMethod': true,
            'toString': false,
            '==': false,
            'hashCode': false,
          },
        );

        expect(decoratorUtils.isObjectMethod('runtimeType'), isFalse);
        expect(decoratorUtils.isObjectMethod('noSuchMethod'), isFalse);
        expect(decoratorUtils.isObjectMethod('toString'), isTrue);
        expect(decoratorUtils.isObjectMethod('hashCode'), isTrue);
        expect(decoratorUtils.isObjectMethod('=='), isTrue);
      });

      test('returns false for non-Object methods', () {
        expect(decoratorUtils.isObjectMethod('equals'), isFalse);
        expect(decoratorUtils.isObjectMethod('customMethod'), isFalse);
        expect(decoratorUtils.isObjectMethod('getName'), isFalse);
      });

      test('handles empty and null-like strings', () {
        expect(decoratorUtils.isObjectMethod(''), isFalse);
        expect(decoratorUtils.isObjectMethod(' '), isFalse);
      });
    });

    group('toCamelCase', () {
      test('converts PascalCase to camelCase', () {
        expect(DecoratorUtils.toCamelCase('MyClass'), equals('myClass'));
        expect(
          DecoratorUtils.toCamelCase('UserService'),
          equals('userService'),
        );
        expect(DecoratorUtils.toCamelCase('HTTPClient'), equals('hTTPClient'));
        expect(DecoratorUtils.toCamelCase('XMLParser'), equals('xMLParser'));
      });

      test('handles single character strings', () {
        expect(DecoratorUtils.toCamelCase('A'), equals('a'));
        expect(DecoratorUtils.toCamelCase('Z'), equals('z'));
        expect(DecoratorUtils.toCamelCase('a'), equals('a'));
      });

      test('handles empty string', () {
        expect(DecoratorUtils.toCamelCase(''), equals(''));
      });

      test('handles strings already in camelCase', () {
        expect(DecoratorUtils.toCamelCase('myClass'), equals('myClass'));
        expect(
          DecoratorUtils.toCamelCase('userService'),
          equals('userService'),
        );
      });

      test('handles strings with numbers and special characters', () {
        expect(DecoratorUtils.toCamelCase('Class1'), equals('class1'));
        expect(DecoratorUtils.toCamelCase('My_Class'), equals('my_Class'));
        expect(DecoratorUtils.toCamelCase('Class-Name'), equals('class-Name'));
      });

      test('handles all uppercase strings', () {
        expect(DecoratorUtils.toCamelCase('API'), equals('aPI'));
        expect(DecoratorUtils.toCamelCase('JSON'), equals('jSON'));
      });

      test('handles all lowercase strings', () {
        expect(DecoratorUtils.toCamelCase('class'), equals('class'));
        expect(DecoratorUtils.toCamelCase('service'), equals('service'));
      });
    });
  });
}
