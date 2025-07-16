import 'package:decorator_annotation/decorator_annotation.dart';
import 'package:source_gen_test/annotations.dart';

// Class with only static methods - these should NOT be included in decorator
@ShouldGenerate(r'''
class ClassWithStaticMembersDecorator implements ClassWithStaticMembers {
  final ClassWithStaticMembers classWithStaticMembers;

  ClassWithStaticMembersDecorator({required this.classWithStaticMembers});

  @override
  void instanceMethod() {
    classWithStaticMembers.instanceMethod();
  }
}
''')
@Decorator()
class ClassWithStaticMembers {
  // Static methods should NOT be overridden in decorator
  static String staticMethod() => 'static';
  static int staticCalculation(int a, int b) => a + b;
  static String get staticProperty => 'static property';
  static set staticSetter(String value) {}
  static const String defaultName = 'Default';
  static int instanceCount = 0;

  // Instance methods SHOULD be overridden in decorator
  void instanceMethod() {}
}
