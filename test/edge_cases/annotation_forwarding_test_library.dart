import 'package:decorator_annotation/decorator_annotation.dart';
import 'package:source_gen_test/annotations.dart';

// Class that overrides annotation settings to forward toString but not equals
@ShouldGenerate(r'''
class ForwardToStringOnlyDecorator implements ForwardToStringOnly {
  final ForwardToStringOnly forwardToStringOnly;

  ForwardToStringOnlyDecorator({required this.forwardToStringOnly});

  @override
  String toString() {
    return forwardToStringOnly.toString();
  }
}
''')
@Decorator(forwardToString: true, forwardEquals: false, forwardHashCode: false)
class ForwardToStringOnly {
  @override
  String toString() => 'ForwardToStringOnly';

  @override
  bool operator ==(Object other) => other is ForwardToStringOnly;
}

// Class that forwards all Object methods using annotation
@ShouldGenerate(r'''
class ForwardAllObjectMethodsDecorator implements ForwardAllObjectMethods {
  final ForwardAllObjectMethods forwardAllObjectMethods;

  ForwardAllObjectMethodsDecorator({required this.forwardAllObjectMethods});

  @override
  String toString() {
    return forwardAllObjectMethods.toString();
  }

  @override
  bool operator ==(Object other) {
    return forwardAllObjectMethods == other;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) {
    return forwardAllObjectMethods.noSuchMethod(invocation);
  }

  @override
  int get hashCode => forwardAllObjectMethods.hashCode;

  @override
  Type get runtimeType => forwardAllObjectMethods.runtimeType;
}
''')
@Decorator(
  forwardToString: true,
  forwardEquals: true,
  forwardHashCode: true,
  forwardRuntimeType: true,
  forwardNoSuchMethod: true,
)
class ForwardAllObjectMethods {
  @override
  String toString() => 'ForwardAllObjectMethods';

  @override
  bool operator ==(Object other) => other is ForwardAllObjectMethods;

  @override
  int get hashCode => 42;

  @override
  Type get runtimeType => super.runtimeType;

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

// Class that explicitly disables all forwarding through annotation
@ShouldGenerate(r'''
class ForwardNoneDecorator implements ForwardNone {
  final ForwardNone forwardNone;

  ForwardNoneDecorator({required this.forwardNone});
}
''')
@Decorator(
  forwardToString: false,
  forwardEquals: false,
  forwardHashCode: false,
  forwardRuntimeType: false,
  forwardNoSuchMethod: false,
)
class ForwardNone {
  @override
  String toString() => 'ForwardNone';

  @override
  bool operator ==(Object other) => other is ForwardNone;

  @override
  int get hashCode => 42;

  @override
  Type get runtimeType => super.runtimeType;

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

// Class that only uses some annotation parameters (mixed with defaults)
@ShouldGenerate(r'''
class PartialForwardingDecorator implements PartialForwarding {
  final PartialForwarding partialForwarding;

  PartialForwardingDecorator({required this.partialForwarding});

  @override
  String toString() {
    return partialForwarding.toString();
  }

  @override
  bool operator ==(Object other) {
    return partialForwarding == other;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) {
    return partialForwarding.noSuchMethod(invocation);
  }

  @override
  int get hashCode => partialForwarding.hashCode;
}
''')
@Decorator(
  forwardNoSuchMethod: true,
) // Only override noSuchMethod, others use defaults
class PartialForwarding {
  @override
  String toString() => 'PartialForwarding';

  @override
  bool operator ==(Object other) => other is PartialForwarding;

  @override
  int get hashCode => 42;

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
