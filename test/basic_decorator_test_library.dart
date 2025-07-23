import 'package:decorator_annotation/decorator_annotation.dart';
import 'package:source_gen_test/annotations.dart';

// Empty class - should generate minimal decorator
@ShouldGenerate(r'''
class EmptyClassDecorator implements EmptyClass {
  final EmptyClass emptyClass;

  EmptyClassDecorator({required this.emptyClass});

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

  @override
  String toString() {
    return basicClass.toString();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is BasicClassDecorator) {
      return basicClass == other.basicClass;
    }
    return basicClass == other;
  }

  @override
  int get hashCode => basicClass.hashCode;
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

  @override
  String toString() {
    return classWithMethods.toString();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is ClassWithMethodsDecorator) {
      return classWithMethods == other.classWithMethods;
    }
    return classWithMethods == other;
  }

  @override
  int get hashCode => classWithMethods.hashCode;
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

  @override
  String toString() {
    return classWithProperties.toString();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is ClassWithPropertiesDecorator) {
      return classWithProperties == other.classWithProperties;
    }
    return classWithProperties == other;
  }

  @override
  int get hashCode => classWithProperties.hashCode;
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

// Class with standalone getters and setters (not associated with fields)
@ShouldGenerate(r'''
class ClassWithStandaloneAccessorsDecorator
    implements ClassWithStandaloneAccessors {
  final ClassWithStandaloneAccessors classWithStandaloneAccessors;

  ClassWithStandaloneAccessorsDecorator({
    required this.classWithStandaloneAccessors,
  });

  @override
  String get computedValue => classWithStandaloneAccessors.computedValue;

  @override
  int get dynamicCalculation => classWithStandaloneAccessors.dynamicCalculation;

  @override
  set externalSetter(String value) {
    classWithStandaloneAccessors.externalSetter = value;
  }

  @override
  String toString() {
    return classWithStandaloneAccessors.toString();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is ClassWithStandaloneAccessorsDecorator) {
      return classWithStandaloneAccessors == other.classWithStandaloneAccessors;
    }
    return classWithStandaloneAccessors == other;
  }

  @override
  int get hashCode => classWithStandaloneAccessors.hashCode;
}
''')
@Decorator()
class ClassWithStandaloneAccessors {
  // Standalone getter - computes value without a backing field
  String get computedValue =>
      'computed_${DateTime.now().millisecondsSinceEpoch}';

  // Another standalone getter
  int get dynamicCalculation => 42 * 2;

  // Standalone setter - doesn't have a corresponding field in this class
  set externalSetter(String value) {
    print('Setting external value: $value');
  }
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

  @override
  String toString() {
    return classWithConstructor.toString();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is ClassWithConstructorDecorator) {
      return classWithConstructor == other.classWithConstructor;
    }
    return classWithConstructor == other;
  }

  @override
  int get hashCode => classWithConstructor.hashCode;
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
