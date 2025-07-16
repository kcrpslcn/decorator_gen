import 'package:decorator_annotation/decorator_annotation.dart';

part 'example.g.dart'; // This part directive is necessary for code generation

@Decorator() // Add this annotation to generate a decorator for this class
class MyExampleClass {
  // The generated decorator will forward calls to this method
  void foo() {}

  // This method will not be in the generated decorator
  static void bar() {}
}
