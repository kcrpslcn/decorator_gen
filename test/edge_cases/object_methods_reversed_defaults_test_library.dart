import 'package:decorator_annotation/decorator_annotation.dart';
import 'package:source_gen_test/annotations.dart';

// Empty class - should generate minimal decorator
@ShouldGenerate(r'''
class OverridesDefaultIncludedMethodsDecorator
    implements OverridesDefaultIncludedMethods {
  final OverridesDefaultIncludedMethods overridesDefaultIncludedMethods;

  OverridesDefaultIncludedMethodsDecorator({
    required this.overridesDefaultIncludedMethods,
  });
}
''')
@Decorator()
class OverridesDefaultIncludedMethods {
  @override
  String toString() => 'OverridesDefaultIncludedMethods';

  @override
  bool operator ==(Object other) => other is OverridesDefaultIncludedMethods;

  @override
  int get hashCode => 0;
}

// Empty class - should generate minimal decorator
@ShouldGenerate(r'''
class OverridesDefaultExcludedMethodsDecorator
    implements OverridesDefaultExcludedMethods {
  final OverridesDefaultExcludedMethods overridesDefaultExcludedMethods;

  OverridesDefaultExcludedMethodsDecorator({
    required this.overridesDefaultExcludedMethods,
  });

  @override
  dynamic noSuchMethod(Invocation invocation) {
    return overridesDefaultExcludedMethods.noSuchMethod(invocation);
  }

  @override
  Type get runtimeType => overridesDefaultExcludedMethods.runtimeType;
}
''')
@Decorator()
class OverridesDefaultExcludedMethods {
  @override
  Type get runtimeType => super.runtimeType;

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
