import 'package:decorator_annotation/decorator_annotation.dart';
import 'package:source_gen_test/annotations.dart';

@ShouldGenerate(r'''
class OverridesDefaultIncludedMethodsReversedDecorator
    implements OverridesDefaultIncludedMethodsReversed {
  final OverridesDefaultIncludedMethodsReversed
  overridesDefaultIncludedMethodsReversed;

  OverridesDefaultIncludedMethodsReversedDecorator({
    required this.overridesDefaultIncludedMethodsReversed,
  });

  @override
  dynamic noSuchMethod(Invocation invocation) {
    return overridesDefaultIncludedMethodsReversed.noSuchMethod(invocation);
  }

  @override
  Type get runtimeType => overridesDefaultIncludedMethodsReversed.runtimeType;
}
''')
@Decorator()
class OverridesDefaultIncludedMethodsReversed {
  @override
  String toString() => 'OverridesDefaultIncludedMethods';

  @override
  bool operator ==(Object other) =>
      other is OverridesDefaultIncludedMethodsReversed;

  @override
  int get hashCode => 0;
}

@ShouldGenerate(r'''
class OverridesDefaultExcludedMethodsReversedDecorator
    implements OverridesDefaultExcludedMethodsReversed {
  final OverridesDefaultExcludedMethodsReversed
  overridesDefaultExcludedMethodsReversed;

  OverridesDefaultExcludedMethodsReversedDecorator({
    required this.overridesDefaultExcludedMethodsReversed,
  });

  @override
  dynamic noSuchMethod(Invocation invocation) {
    return overridesDefaultExcludedMethodsReversed.noSuchMethod(invocation);
  }

  @override
  Type get runtimeType => overridesDefaultExcludedMethodsReversed.runtimeType;
}
''')
@Decorator()
class OverridesDefaultExcludedMethodsReversed {
  @override
  Type get runtimeType => super.runtimeType;

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
