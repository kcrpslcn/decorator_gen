import 'package:decorator_annotation/decorator_annotation.dart';
import 'package:source_gen_test/annotations.dart';

class GrandParentClass {
  void grandParentMethod() {}
}

class ParentClass extends GrandParentClass {
  void parentMethod() {}
}

// Simple generic class
@ShouldGenerate(r'''
class ExtenderDecorator implements Extender {
  final Extender extender;

  ExtenderDecorator({required this.extender});

  @override
  void parentMethod() {
    extender.parentMethod();
  }

  @override
  void grandParentMethod() {
    extender.grandParentMethod();
  }
}
''')
@Decorator()
class Extender extends ParentClass {}

class ParentInterfacer implements GrandParentClass {
  @override
  void grandParentMethod() {}

  void parentMethod() {}
}

@ShouldGenerate(r'''
class ImplementerDecorator implements Implementer {
  final Implementer implementer;

  ImplementerDecorator({required this.implementer});

  @override
  void grandParentMethod() {
    implementer.grandParentMethod();
  }

  @override
  void parentMethod() {
    implementer.parentMethod();
  }
}
''')
@Decorator()
class Implementer implements ParentInterfacer {
  @override
  void grandParentMethod() {}

  @override
  void parentMethod() {}
}
