import 'package:decorator_annotation/decorator_annotation.dart';
import 'package:source_gen_test/annotations.dart';

@ShouldGenerate(r'''
class OverridesDefaultIncludedMethodsDecorator
    implements OverridesDefaultIncludedMethods {
  final OverridesDefaultIncludedMethods overridesDefaultIncludedMethods;

  OverridesDefaultIncludedMethodsDecorator({
    required this.overridesDefaultIncludedMethods,
  });

  @override
  String toString() {
    return overridesDefaultIncludedMethods.toString();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is OverridesDefaultIncludedMethodsDecorator) {
      return overridesDefaultIncludedMethods ==
          other.overridesDefaultIncludedMethods;
    }
    return overridesDefaultIncludedMethods == other;
  }

  @override
  int get hashCode => overridesDefaultIncludedMethods.hashCode;
}
''')
@Decorator()
class OverridesDefaultIncludedMethods {}

@ShouldGenerate(r'''
class OverridesDefaultExcludedMethodsDecorator
    implements OverridesDefaultExcludedMethods {
  final OverridesDefaultExcludedMethods overridesDefaultExcludedMethods;

  OverridesDefaultExcludedMethodsDecorator({
    required this.overridesDefaultExcludedMethods,
  });

  @override
  String toString() {
    return overridesDefaultExcludedMethods.toString();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is OverridesDefaultExcludedMethodsDecorator) {
      return overridesDefaultExcludedMethods ==
          other.overridesDefaultExcludedMethods;
    }
    return overridesDefaultExcludedMethods == other;
  }

  @override
  int get hashCode => overridesDefaultExcludedMethods.hashCode;
}
''')
@Decorator()
class OverridesDefaultExcludedMethods {
  @override
  Type get runtimeType => super.runtimeType;

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
