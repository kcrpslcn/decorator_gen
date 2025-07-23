// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example.dart';

// **************************************************************************
// DecoratorGenerator
// **************************************************************************

class MyExampleClassDecorator implements MyExampleClass {
  final MyExampleClass myExampleClass;

  MyExampleClassDecorator({required this.myExampleClass});

  @override
  void foo() {
    myExampleClass.foo();
  }

  @override
  String toString() {
    return myExampleClass.toString();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is MyExampleClassDecorator) {
      return myExampleClass == other.myExampleClass;
    }
    return myExampleClass == other;
  }

  @override
  int get hashCode => myExampleClass.hashCode;
}
