import 'package:decorator_annotation/decorator_annotation.dart';
import 'package:test/test.dart';

part 'decorator_equality_test.g.dart';

void main() {
  group('Plidar Device Wrapper', () {
    final instance1 = IdEqualitySameType('123');
    final instance2 = IdEqualitySameType('456');
    test('IdEqualitySameType', () {
      final wrapped1 = EmptyClassDecorator(emptyClass: instance1);
      final wrapped2 = EmptyClassDecorator(emptyClass: instance1);
      final wrapped3 = EmptyClassDecorator(emptyClass: instance2);

      expect(wrapped1 == wrapped2, isTrue);
      expect(wrapped1 == wrapped3, isFalse);
      expect(wrapped2 == wrapped3, isFalse);
    });

    test('IdEqualityDecoratorType', () {
      final wrapped1 = EmptyClassDecorator(emptyClass: instance1);
      final wrapped2 = EmptyClassDecorator(emptyClass: instance1);
      final wrapped3 = EmptyClassDecorator(emptyClass: instance2);

      expect(wrapped1 == wrapped2, isTrue);
      expect(wrapped1 == wrapped3, isFalse);
      expect(wrapped2 == wrapped3, isFalse);
    });

    test('IdEqualityDecoratedType', () {
      final wrapped1 = EmptyClassDecorator(emptyClass: instance1);
      final wrapped2 = EmptyClassDecorator(emptyClass: instance1);
      final wrapped3 = EmptyClassDecorator(emptyClass: instance2);

      expect(wrapped1 == wrapped2, isTrue);
      expect(wrapped1 == wrapped3, isFalse);
      expect(wrapped2 == wrapped3, isFalse);
    });

    group('Value Equality', () {
      final valueInstance1 = ValueEqualityClass('value1');
      final valueInstance2 = ValueEqualityClass('value2');
      test('ValueEqualityClass', () {
        final wrappedValue1 =
            ValueEqualityClassDecorator(valueEqualityClass: valueInstance1);
        final wrappedValue2 =
            ValueEqualityClassDecorator(valueEqualityClass: valueInstance1);
        final wrappedValue3 =
            ValueEqualityClassDecorator(valueEqualityClass: valueInstance2);

        expect(wrappedValue1 == wrappedValue2, isTrue);
        expect(wrappedValue1 == wrappedValue3, isFalse);
        expect(wrappedValue2 == wrappedValue3, isFalse);
      });

      test('ValueEqualityDecoratorImpl', () {
        final wrappedValue1 =
            ValueEqualityDecoratorImpl(valueEqualityClass: valueInstance1);
        final wrappedValue2 =
            ValueEqualityDecoratorImpl(valueEqualityClass: valueInstance1);
        final wrappedValue3 =
            ValueEqualityDecoratorImpl(valueEqualityClass: valueInstance2);

        expect(wrappedValue1 == wrappedValue2, isTrue);
        expect(wrappedValue1 == wrappedValue3, isFalse);
        expect(wrappedValue2 == wrappedValue3, isFalse);
      });
    });
  });
}

@Decorator()
class EmptyClass {
  EmptyClass({
    required this.id,
  });

  final String id;
}

class IdEqualitySameType extends EmptyClassDecorator {
  IdEqualitySameType(this.id) : super(emptyClass: EmptyClass(id: id));

  final String id;

  @override
  bool operator ==(Object other) {
    if (other is IdEqualitySameType) {
      return id == other.id;
    }
    return false;
  }
}

class IdEqualityDecoratorType extends EmptyClassDecorator {
  IdEqualityDecoratorType(this.id) : super(emptyClass: EmptyClass(id: id));

  final String id;

  @override
  bool operator ==(Object other) {
    if (other is EmptyClassDecorator) {
      return id == other.emptyClass.id;
    }
    return false;
  }
}

class IdEqualityDecoratedType extends EmptyClassDecorator {
  IdEqualityDecoratedType(this.id) : super(emptyClass: EmptyClass(id: id));

  final String id;

  @override
  bool operator ==(Object other) {
    if (other is EmptyClass) {
      return id == other.id;
    }
    return false;
  }
}

@Decorator()
class ValueEqualityClass {
  ValueEqualityClass(this.fieldName);

  final String fieldName;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is ValueEqualityClass) {
      return fieldName == other.fieldName;
    }
    return false;
  }
}

class ValueEqualityDecoratorImpl extends ValueEqualityClassDecorator {
  ValueEqualityDecoratorImpl({required super.valueEqualityClass});
}
