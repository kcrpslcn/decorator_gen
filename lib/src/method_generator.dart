import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';

import 'decorator_utils.dart';

/// Handles generation of delegating methods for decorator classes
class MethodGenerator {
  final ClassElement classElement;
  final DecoratorUtils decoratorUtils;

  const MethodGenerator(this.classElement, this.decoratorUtils);

  String generateDelegatingMethods() {
    final buffer = StringBuffer();

    // Get all methods that need to be implemented
    final allMethods = <MethodElement>[];

    // Add methods from the class itself (excluding static methods and Object methods)
    allMethods.addAll(classElement.methods.where((method) =>
        !method.isStatic && !decoratorUtils.isObjectMethod(method.name)));

    // Add abstract methods from directly implemented interfaces only
    final processedTypes = <String>{};

    void collectAbstractMethods(InterfaceType interfaceType) {
      final typeName = interfaceType.element.name;
      if (processedTypes.contains(typeName)) return;
      processedTypes.add(typeName);

      // Add methods from this interface only if they are abstract
      for (final method in interfaceType.methods) {
        if (!method.isStatic &&
            !decoratorUtils.isObjectMethod(method.name) &&
            !allMethods.any((m) => m.name == method.name)) {
          // Only add methods that are not already implemented in the current class
          final isImplementedInClass = classElement.methods.any(
            (m) => m.name == method.name && !m.isAbstract,
          );

          if (!isImplementedInClass) {
            allMethods.add(method);
          }
        }
      }

      // Recursively process all interfaces that this interface implements
      for (final superInterface in interfaceType.interfaces) {
        collectAbstractMethods(superInterface);
      }

      // Process superclass if it exists
      if (interfaceType.superclass != null &&
          interfaceType.superclass!.element.name != 'Object') {
        collectAbstractMethods(interfaceType.superclass!);
      }
    }

    // Only collect from directly implemented interfaces and superclasses
    for (final interface in classElement.interfaces) {
      collectAbstractMethods(interface);
    }

    // Process mixins
    for (final mixin in classElement.mixins) {
      collectAbstractMethods(mixin);
    }

    // Also process superclass if it's not Object
    if (classElement.supertype != null &&
        classElement.supertype!.element.name != 'Object') {
      collectAbstractMethods(classElement.supertype!);
    }

    for (final method in allMethods) {
      buffer.writeln('  @override');

      // Generate type parameters
      final typeParams = method.typeParameters.isNotEmpty
          ? '<${method.typeParameters.map((tp) {
              final bound = tp.bound;
              return bound != null ? '${tp.name} extends $bound' : tp.name;
            }).join(', ')}>'
          : '';

      // Check if this is an operator
      final isOperator = _isOperator(method.name);
      final methodPrefix =
          isOperator && !method.name.startsWith('operator') ? 'operator ' : '';

      // Handle special case for unary minus operator
      final methodName = method.name == 'unary-' ? '-' : method.name;

      buffer.write(
        '  ${method.returnType} $methodPrefix$methodName$typeParams(',
      );

      // Generate parameters
      final parameters = _generateParameters(method);
      buffer.write(parameters);
      buffer.writeln(') {');

      // Generate method body
      final paramNames = method.parameters.map((p) {
        if (p.isNamed) {
          return '${p.name}: ${p.name}';
        } else {
          return p.name;
        }
      }).join(', ');

      // Special handling for operator calls
      final methodCall = _generateMethodCall(method, paramNames);

      if (method.returnType.toString() != 'void') {
        buffer.writeln('    return $methodCall;');
      } else {
        buffer.writeln('    $methodCall;');
      }

      buffer.writeln('  }');
      buffer.writeln();
    }

    return buffer.toString();
  }

  String _generateParameters(MethodElement method) {
    final requiredParams = <String>[];
    final namedParams = <String>[];
    final optionalParams = <String>[];

    for (final param in method.parameters) {
      final type = param.type;
      final name = param.name;
      final defaultValue = param.defaultValueCode;

      if (param.isNamed) {
        final defaultPart = defaultValue != null ? ' = $defaultValue' : '';
        final requiredPart = param.isRequiredNamed ? 'required ' : '';
        namedParams.add('$requiredPart$type $name$defaultPart');
      } else if (param.isOptional) {
        final defaultPart = defaultValue != null ? ' = $defaultValue' : '';
        optionalParams.add('$type $name$defaultPart');
      } else {
        requiredParams.add('$type $name');
      }
    }

    final parameterParts = <String>[];
    if (requiredParams.isNotEmpty) {
      parameterParts.add(requiredParams.join(', '));
    }
    if (namedParams.isNotEmpty) {
      parameterParts.add('{${namedParams.join(', ')}}');
    }
    if (optionalParams.isNotEmpty) {
      parameterParts.add('[${optionalParams.join(', ')}]');
    }

    return parameterParts.join(', ');
  }

  bool _isOperator(String methodName) {
    return methodName.startsWith('operator') ||
        [
          '==',
          '+',
          '-',
          '*',
          '/',
          '%',
          '~/',
          '<',
          '>',
          '<=',
          '>=',
          '[]',
          '[]=',
          '~',
          '&',
          '|',
          '^',
          '<<',
          '>>',
          '>>>',
          'unary-',
        ].contains(methodName);
  }

  String _generateMethodCall(MethodElement method, String paramNames) {
    final instanceName = DecoratorUtils.toCamelCase(classElement.name);

    // Special handling for specific operators
    switch (method.name) {
      case '==':
        final param = method.parameters.first.name;
        return '$instanceName == $param';
      case '+':
      case '-':
      case '*':
      case '/':
      case '%':
      case '~/':
      case '<':
      case '>':
      case '<=':
      case '>=':
      case '&':
      case '|':
      case '^':
      case '<<':
      case '>>':
      case '>>>':
        final param = method.parameters.first.name;
        return '$instanceName ${method.name} $param';
      case '[]':
        final param = method.parameters.first.name;
        return '$instanceName[$param]';
      case '[]=':
        final params = method.parameters.map((p) => p.name).toList();
        return '$instanceName[${params[0]}] = ${params[1]}';
      case '~':
        return '~$instanceName';
      case 'unary-':
        return '-$instanceName';
      default:
        // Regular method call
        return '$instanceName.${method.name}($paramNames)';
    }
  }
}
