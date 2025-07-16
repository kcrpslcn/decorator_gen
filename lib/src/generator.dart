import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:decorator_annotation/decorator_annotation.dart';
import 'package:source_gen/source_gen.dart';

import 'decorator_builder.dart';

class DecoratorGenerator extends GeneratorForAnnotation<Decorator> {
  final Map<String, bool> methodNameToIsForwarding;

  const DecoratorGenerator({this.methodNameToIsForwarding = const {}});

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        'Generator can only be applied to classes.',
        element: element,
      );
    }

    // Create decorator builder and generate the code
    final builder = DecoratorBuilder(element, methodNameToIsForwarding);
    return builder();
  }
}
