import 'package:decorator_annotation/decorator_annotation.dart';
import 'package:source_gen_test/annotations.dart';

// Test classes with private fields
@ShouldGenerate(r'''
class ClassWithPrivateFieldDecorator implements ClassWithPrivateField {
  final ClassWithPrivateField classWithPrivateField;

  ClassWithPrivateFieldDecorator({required this.classWithPrivateField});

  @override
  void increment() {
    classWithPrivateField.increment();
  }

  @override
  void reset() {
    classWithPrivateField.reset();
  }

  @override
  int get _privateField => classWithPrivateField._privateField;

  @override
  set _privateField(int value) {
    classWithPrivateField._privateField = value;
  }

  @override
  int get count => classWithPrivateField.count;
}
''')
@Decorator()
class ClassWithPrivateField {
  int _privateField = 0;

  void increment() {
    _privateField++;
  }

  void reset() {
    _privateField = 0;
  }

  int get count => _privateField;
}

// Test class with only private getter
@ShouldGenerate(r'''
class ClassWithPrivateGetterDecorator implements ClassWithPrivateGetter {
  final ClassWithPrivateGetter classWithPrivateGetter;

  ClassWithPrivateGetterDecorator({required this.classWithPrivateGetter});

  @override
  String get _privateGetter => classWithPrivateGetter._privateGetter;

  @override
  String get publicValue => classWithPrivateGetter.publicValue;
}
''')
@Decorator()
class ClassWithPrivateGetter {
  String get _privateGetter => 'private value';
  String get publicValue => _privateGetter;
}

// Test class with only private setter
@ShouldGenerate(r'''
class ClassWithPrivateSetterDecorator implements ClassWithPrivateSetter {
  final ClassWithPrivateSetter classWithPrivateSetter;

  ClassWithPrivateSetterDecorator({required this.classWithPrivateSetter});

  @override
  set _privateSetter(String value) {
    classWithPrivateSetter._privateSetter = value;
  }
}
''')
@Decorator()
class ClassWithPrivateSetter {
  // ignore: unused_element
  set _privateSetter(String value) {
    print('Hello private setter: $value');
  }
}

// Test class with private methods
@ShouldGenerate(r'''
class ClassWithPrivateMethodDecorator implements ClassWithPrivateMethod {
  final ClassWithPrivateMethod classWithPrivateMethod;

  ClassWithPrivateMethodDecorator({required this.classWithPrivateMethod});

  @override
  void _privateMethod() {
    classWithPrivateMethod._privateMethod();
  }
}
''')
@Decorator()
class ClassWithPrivateMethod {
  // ignore: unused_element
  void _privateMethod() {
    print('Hello from private method');
  }
}
