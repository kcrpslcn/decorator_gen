import 'package:analyzer/dart/element/element2.dart';

import 'decorator_utils.dart';
import 'field_accessor_generator.dart';
import 'method_generator.dart';
import 'object_method_generator.dart';
import 'type_parameter_generator.dart';

/// Main class responsible for building decorator classes
class DecoratorBuilder {
  final ClassElement2 classElement;
  final Map<String, bool> methodNameToIsForwarding;
  final StringBuffer buffer = StringBuffer();

  late final MethodGenerator _methodGenerator;
  late final FieldAccessorGenerator _fieldAccessorGenerator;
  late final ObjectMethodGenerator _objectMethodGenerator;
  late final TypeParameterGenerator _typeParameterGenerator;
  late final DecoratorUtils _decoratorUtils;

  DecoratorBuilder(this.classElement, this.methodNameToIsForwarding) {
    _decoratorUtils = DecoratorUtils(
      methodNameToIsForwarding: methodNameToIsForwarding,
    );
    _methodGenerator = MethodGenerator(classElement, _decoratorUtils);
    _fieldAccessorGenerator =
        FieldAccessorGenerator(classElement, _decoratorUtils);
    _objectMethodGenerator =
        ObjectMethodGenerator(classElement, _decoratorUtils);
    _typeParameterGenerator =
        TypeParameterGenerator(classElement, _decoratorUtils);
  }

  /// Generates the complete decorator class code
  String call() {
    final className = classElement.name3!;
    final fieldName = DecoratorUtils.toCamelCase(className);
    final typeParams = _typeParameterGenerator.generateTypeParameters();
    final typeRef = _typeParameterGenerator.generateTypeReference();

    final resultingClassName = '${className}Decorator';

    // Generate class declaration
    buffer.writeln(
      'class $resultingClassName$typeParams implements $className$typeRef {',
    );

    // Generate field
    buffer.writeln('  final $className$typeRef $fieldName;');
    buffer.writeln();

    // Generate constructor
    buffer.writeln('  $resultingClassName({required this.$fieldName});');
    buffer.writeln();

    // Generate delegating methods
    buffer.write(_methodGenerator.generateDelegatingMethods());

    // Generate getters and setters for public fields
    buffer.write(_fieldAccessorGenerator.generateFieldAccessors());

    // Generate Object method forwarding based on configuration
    buffer.write(_objectMethodGenerator.generateObjectMethods(
      className: resultingClassName,
    ));

    buffer.writeln('}');

    return buffer.toString();
  }
}
