import 'package:decorator_annotation/decorator_annotation.dart';
import 'package:source_gen_test/annotations.dart';

// Test mixin declarations
mixin SimpleMixin {
  void mixinMethod() {}
  int get mixinProperty => 42;
  set mixinSetter(String value) {}
}

mixin GenericMixin<T> {
  T? _value;
  T? get value => _value;
  set value(T? newValue) => _value = newValue;
  void processValue(T input) {}
}

mixin CalculatorMixin {
  int add(int a, int b) => a + b;
  int multiply(int a, int b) => a * b;
}

// Basic class with mixin
@ShouldGenerate(r'''
class ClassWithMixinDecorator implements ClassWithMixin {
  final ClassWithMixin classWithMixin;

  ClassWithMixinDecorator({required this.classWithMixin});

  @override
  void ownMethod() {
    classWithMixin.ownMethod();
  }

  @override
  void mixinMethod() {
    classWithMixin.mixinMethod();
  }

  @override
  int get mixinProperty => classWithMixin.mixinProperty;

  @override
  set mixinSetter(String value) {
    classWithMixin.mixinSetter = value;
  }
}
''')
@Decorator()
class ClassWithMixin with SimpleMixin {
  void ownMethod() {}
}

// Class with multiple mixins
@ShouldGenerate(r'''
class ClassWithMultipleMixinsDecorator implements ClassWithMultipleMixins {
  final ClassWithMultipleMixins classWithMultipleMixins;

  ClassWithMultipleMixinsDecorator({required this.classWithMultipleMixins});

  @override
  void ownMethod() {
    classWithMultipleMixins.ownMethod();
  }

  @override
  void mixinMethod() {
    classWithMultipleMixins.mixinMethod();
  }

  @override
  int add(int a, int b) {
    return classWithMultipleMixins.add(a, b);
  }

  @override
  int multiply(int a, int b) {
    return classWithMultipleMixins.multiply(a, b);
  }

  @override
  int get mixinProperty => classWithMultipleMixins.mixinProperty;

  @override
  set mixinSetter(String value) {
    classWithMultipleMixins.mixinSetter = value;
  }
}
''')
@Decorator()
class ClassWithMultipleMixins with SimpleMixin, CalculatorMixin {
  void ownMethod() {}
}

// Class with generic mixin
@ShouldGenerate(r'''
class ClassWithGenericMixinDecorator implements ClassWithGenericMixin {
  final ClassWithGenericMixin classWithGenericMixin;

  ClassWithGenericMixinDecorator({required this.classWithGenericMixin});

  @override
  void ownMethod() {
    classWithGenericMixin.ownMethod();
  }

  @override
  void processValue(String input) {
    classWithGenericMixin.processValue(input);
  }

  @override
  T? get _value => classWithGenericMixin._value;

  @override
  set _value(T? value) {
    classWithGenericMixin._value = value;
  }

  @override
  T? get value => classWithGenericMixin.value;

  @override
  set value(T? value) {
    classWithGenericMixin.value = value;
  }
}
''')
@Decorator()
class ClassWithGenericMixin with GenericMixin<String> {
  void ownMethod() {}
}

// Base class for inheritance
class BaseClass {
  void baseMethod() {}
  String get baseProperty => 'base';
}

// Class with both mixin and inheritance
@ShouldGenerate(r'''
class ClassWithMixinAndInheritanceDecorator
    implements ClassWithMixinAndInheritance {
  final ClassWithMixinAndInheritance classWithMixinAndInheritance;

  ClassWithMixinAndInheritanceDecorator({
    required this.classWithMixinAndInheritance,
  });

  @override
  void ownMethod() {
    classWithMixinAndInheritance.ownMethod();
  }

  @override
  void mixinMethod() {
    classWithMixinAndInheritance.mixinMethod();
  }

  @override
  void baseMethod() {
    classWithMixinAndInheritance.baseMethod();
  }

  @override
  int get mixinProperty => classWithMixinAndInheritance.mixinProperty;

  @override
  set mixinSetter(String value) {
    classWithMixinAndInheritance.mixinSetter = value;
  }

  @override
  String get baseProperty => classWithMixinAndInheritance.baseProperty;
}
''')
@Decorator()
class ClassWithMixinAndInheritance extends BaseClass with SimpleMixin {
  void ownMethod() {}
}
