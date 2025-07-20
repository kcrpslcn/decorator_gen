import 'package:analyzer/dart/element/element.dart';

import 'decorator_utils.dart';
import 'field_accessor_generator.dart';
import 'method_generator.dart';
import 'type_parameter_generator.dart';

/// Main class responsible for building decorator classes
class DecoratorBuilder {
  final ClassElement classElement;
  final Map<String, bool> methodNameToIsForwarding;
  final StringBuffer buffer = StringBuffer();

  late final MethodGenerator _methodGenerator;
  late final FieldAccessorGenerator _fieldAccessorGenerator;
  late final TypeParameterGenerator _typeParameterGenerator;
  late final DecoratorUtils _decoratorUtils;

  DecoratorBuilder(this.classElement, this.methodNameToIsForwarding) {
    _decoratorUtils = DecoratorUtils(
      methodNameToIsForwarding: methodNameToIsForwarding,
    );
    _methodGenerator = MethodGenerator(classElement, _decoratorUtils);
    _fieldAccessorGenerator =
        FieldAccessorGenerator(classElement, _decoratorUtils);
    _typeParameterGenerator =
        TypeParameterGenerator(classElement, _decoratorUtils);
  }

  /// Generates the complete decorator class code
  String call() {
    final className = classElement.name;
    final fieldName = DecoratorUtils.toCamelCase(className);
    final typeParams = _typeParameterGenerator.generateTypeParameters();
    final typeRef = _typeParameterGenerator.generateTypeReference();

    // Generate class declaration
    buffer.writeln(
      'class ${className}Decorator$typeParams implements $className$typeRef {',
    );

    // Generate field
    buffer.writeln('  final $className$typeRef $fieldName;');
    buffer.writeln();

    // Generate constructor
    buffer.writeln('  ${className}Decorator({required this.$fieldName});');
    buffer.writeln();

    // Generate delegating methods
    buffer.write(_methodGenerator.generateDelegatingMethods());

    // Generate getters and setters for public fields
    buffer.write(_fieldAccessorGenerator.generateFieldAccessors());

    buffer.writeln('}');

    return buffer.toString();
  }
}
