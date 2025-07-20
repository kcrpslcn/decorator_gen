import 'package:decorator_annotation/decorator_annotation.dart';
import 'package:source_gen_test/annotations.dart';

// Empty class - should generate minimal decorator
@ShouldGenerate(r'''
class EmptyClassDecorator implements EmptyClass {
  final EmptyClass emptyClass;

  EmptyClassDecorator({required this.emptyClass});
}
''')
@Decorator()
class EmptyClass {}

// Basic class with one method
@ShouldGenerate(r'''
class BasicClassDecorator implements BasicClass {
  final BasicClass basicClass;

  BasicClassDecorator({required this.basicClass});

  @override
  void simpleMethod() {
    basicClass.simpleMethod();
  }
}
''')
@Decorator()
class BasicClass {
  void simpleMethod() {}
}

// Class with multiple methods
@ShouldGenerate(r'''
class ClassWithMethodsDecorator implements ClassWithMethods {
  final ClassWithMethods classWithMethods;

  ClassWithMethodsDecorator({required this.classWithMethods});

  @override
  void voidMethod() {
    classWithMethods.voidMethod();
  }

  @override
  int methodWithReturn() {
    return classWithMethods.methodWithReturn();
  }

  @override
  String methodWithParams(int a, String b) {
    return classWithMethods.methodWithParams(a, b);
  }
}
''')
@Decorator()
class ClassWithMethods {
  void voidMethod() {}
  int methodWithReturn() => 42;
  String methodWithParams(int a, String b) => '$a$b';
}

// Class with properties (getters and setters)
@ShouldGenerate(r'''
class ClassWithPropertiesDecorator implements ClassWithProperties {
  final ClassWithProperties classWithProperties;

  ClassWithPropertiesDecorator({required this.classWithProperties});

  @override
  String get _name => classWithProperties._name;

  @override
  set _name(String value) {
    classWithProperties._name = value;
  }

  @override
  String get name => classWithProperties.name;

  @override
  set name(String value) {
    classWithProperties.name = value;
  }

  @override
  int get readOnlyValue => classWithProperties.readOnlyValue;

  @override
  set writeOnlyValue(String value) {
    classWithProperties.writeOnlyValue = value;
  }
}
''')
@Decorator()
class ClassWithProperties {
  String _name = '';

  String get name => _name;
  set name(String value) => _name = value;

  int get readOnlyValue => 42;

  set writeOnlyValue(String value) {}
}

// Class with constructor parameters
@ShouldGenerate(r'''
class ClassWithConstructorDecorator implements ClassWithConstructor {
  final ClassWithConstructor classWithConstructor;

  ClassWithConstructorDecorator({required this.classWithConstructor});

  @override
  String get value => classWithConstructor.value;

  @override
  String get optionalValue => classWithConstructor.optionalValue;
}
''')
@Decorator()
class ClassWithConstructor {
  final String value;
  final String optionalValue;

  ClassWithConstructor(this.value, [this.optionalValue = 'default']);
}

@ShouldThrow('Generator can only be applied to classes.')
@Decorator()
void function() {}
