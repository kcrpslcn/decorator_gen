// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'decorator_equality_test.dart';

// **************************************************************************
// DecoratorGenerator
// **************************************************************************

class EmptyClassDecorator implements EmptyClass {
  final EmptyClass emptyClass;

  EmptyClassDecorator({required this.emptyClass});

  @override
  String get id => emptyClass.id;

  @override
  String toString() {
    return emptyClass.toString();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is EmptyClassDecorator) {
      return emptyClass == other.emptyClass;
    }
    return emptyClass == other;
  }

  @override
  int get hashCode => emptyClass.hashCode;
}

class ValueEqualityClassDecorator implements ValueEqualityClass {
  final ValueEqualityClass valueEqualityClass;

  ValueEqualityClassDecorator({required this.valueEqualityClass});

  @override
  String get fieldName => valueEqualityClass.fieldName;

  @override
  String toString() {
    return valueEqualityClass.toString();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is ValueEqualityClassDecorator) {
      return valueEqualityClass == other.valueEqualityClass;
    }
    return valueEqualityClass == other;
  }

  @override
  int get hashCode => valueEqualityClass.hashCode;
}
