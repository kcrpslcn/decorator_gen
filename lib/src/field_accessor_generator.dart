import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';

import 'decorator_utils.dart';

/// Handles generation of field accessors (getters and setters) for decorator classes
class FieldAccessorGenerator {
  final ClassElement classElement;
  final DecoratorUtils decoratorUtils;

  FieldAccessorGenerator(this.classElement, this.decoratorUtils);

  String generateFieldAccessors() {
    final buffer = StringBuffer();

    // Collect all fields and accessors that need to be implemented
    final allFields = <FieldElement>[];
    final allAccessors = <PropertyAccessorElement>[];
    final processedTypes = <String>{};

    void collectFieldsAndAccessors(InterfaceType interfaceType) {
      final typeName = interfaceType.element.name;
      if (processedTypes.contains(typeName)) return;
      processedTypes.add(typeName);

      // Add fields from this interface/class
      for (final field in interfaceType.element.fields) {
        final isAccessible =
            !field.isPrivate || _isPrivateFieldAccessible(field);
        if (isAccessible &&
            !field.isStatic &&
            !decoratorUtils.isObjectMethod(field.name) &&
            !allFields.any((f) => f.name == field.name)) {
          allFields.add(field);
        }
      }

      // Add standalone accessors from this interface/class
      for (final accessor in interfaceType.element.accessors) {
        final isAccessible =
            !accessor.isPrivate || _isPrivateAccessorAccessible(accessor);
        if (isAccessible &&
            !accessor.isStatic &&
            !decoratorUtils.isObjectMethod(accessor.name) &&
            !decoratorUtils.isObjectMethod(accessor.name.replaceAll('=', '')) &&
            !allAccessors.any((a) => a.name == accessor.name)) {
          allAccessors.add(accessor);
        }
      }

      // Recursively process all interfaces that this interface implements
      for (final superInterface in interfaceType.interfaces) {
        collectFieldsAndAccessors(superInterface);
      }

      // Process superclass if it exists
      if (interfaceType.superclass != null &&
          interfaceType.superclass!.element.name != 'Object') {
        collectFieldsAndAccessors(interfaceType.superclass!);
      }
    }

    // Collect from the class itself (including accessible private members)
    for (final field in classElement.fields) {
      final isAccessible = !field.isPrivate || _isPrivateFieldAccessible(field);
      if (isAccessible &&
          !field.isStatic &&
          !decoratorUtils.isObjectMethod(field.name)) {
        allFields.add(field);
      }
    }

    for (final accessor in classElement.accessors) {
      final isAccessible =
          !accessor.isPrivate || _isPrivateAccessorAccessible(accessor);
      if (isAccessible &&
          !accessor.isStatic &&
          !decoratorUtils.isObjectMethod(accessor.name) &&
          !decoratorUtils.isObjectMethod(accessor.name.replaceAll('=', ''))) {
        allAccessors.add(accessor);
      }
    }

    // Only collect from directly implemented interfaces
    for (final interface in classElement.interfaces) {
      collectFieldsAndAccessors(interface);
    }

    // Process mixins
    for (final mixin in classElement.mixins) {
      collectFieldsAndAccessors(mixin);
    }

    // Also process superclass if it's not Object
    if (classElement.supertype != null &&
        classElement.supertype!.element.name != 'Object') {
      collectFieldsAndAccessors(classElement.supertype!);
    }

    // Generate accessors for fields
    for (final field in allFields) {
      _generateFieldAccessor(buffer, field);
    }

    // Generate accessors for standalone getters and setters
    for (final accessor in allAccessors) {
      _generateStandaloneAccessor(buffer, accessor, allFields);
    }

    return buffer.toString();
  }

  /// Checks if a private field is accessible from the decorator's context
  /// A private field is accessible if it's defined in the same library as the decorated class
  bool _isPrivateFieldAccessible(FieldElement field) {
    // Check if the field is defined in the same library as the class being decorated
    final fieldLibrary = field.library;
    final classLibrary = classElement.library;
    return fieldLibrary == classLibrary;
  }

  /// Checks if a private accessor is accessible from the decorator's context
  /// A private accessor is accessible if it's defined in the same library as the decorated class
  bool _isPrivateAccessorAccessible(PropertyAccessorElement accessor) {
    // Check if the accessor is defined in the same library as the class being decorated
    final accessorLibrary = accessor.library;
    final classLibrary = classElement.library;
    return accessorLibrary == classLibrary;
  }

  void _generateFieldAccessor(StringBuffer buffer, FieldElement field) {
    final instanceName = DecoratorUtils.toCamelCase(classElement.name);

    // For private fields, we need to generate getters and setters that delegate to the wrapped instance
    if (field.isPrivate && _isPrivateFieldAccessible(field)) {
      // Generate getter that delegates to the wrapped instance (if getter exists)
      if (field.getter != null) {
        buffer.writeln('  @override');
        buffer.writeln(
          '  ${field.type} get ${field.name} => $instanceName.${field.name};',
        );
        buffer.writeln();
      }

      // Generate setter that delegates to the wrapped instance (if setter exists and field is not final)
      if (field.setter != null && !field.isFinal) {
        buffer.writeln('  @override');
        buffer.writeln(
          '  set ${field.name}(${field.type} value) { $instanceName.${field.name} = value; }',
        );
        buffer.writeln();
      }
      return;
    }

    // Generate getter for public fields
    if (field.getter != null && !field.getter!.isPrivate) {
      buffer.writeln('  @override');
      buffer.writeln(
        '  ${field.type} get ${field.name} => $instanceName.${field.name};',
      );
      buffer.writeln();
    }

    // Generate setter if it exists for public fields
    if (field.setter != null && !field.setter!.isPrivate) {
      buffer.writeln('  @override');
      buffer.writeln(
        '  set ${field.name}(${field.type} value) { $instanceName.${field.name} = value; }',
      );
      buffer.writeln();
    }
  }

  void _generateStandaloneAccessor(
    StringBuffer buffer,
    PropertyAccessorElement accessor,
    List<FieldElement> allFields,
  ) {
    // Check if this accessor is NOT a synthetic accessor for a field
    final setterName = accessor.isSetter && accessor.name.endsWith('=')
        ? accessor.name.substring(0, accessor.name.length - 1)
        : accessor.name;

    final isFieldAccessor = allFields.any(
      (field) =>
          field.name == setterName &&
          ((accessor.isGetter && field.getter == accessor) ||
              (accessor.isSetter && field.setter == accessor)),
    );

    if (!isFieldAccessor) {
      final instanceName = DecoratorUtils.toCamelCase(classElement.name);
      buffer.writeln('  @override');

      if (accessor.isGetter) {
        buffer.writeln(
          '  ${accessor.returnType} get ${accessor.name} => $instanceName.${accessor.name};',
        );
      } else if (accessor.isSetter) {
        final paramType = accessor.parameters.first.type;
        // Remove the '=' from setter name if present
        final cleanSetterName = accessor.name.endsWith('=')
            ? accessor.name.substring(0, accessor.name.length - 1)
            : accessor.name;
        buffer.writeln(
          '  set $cleanSetterName($paramType value) { $instanceName.$cleanSetterName = value; }',
        );
      }
      buffer.writeln();
    }
  }
}
