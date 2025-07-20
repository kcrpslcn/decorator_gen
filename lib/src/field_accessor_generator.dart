import 'package:analyzer/dart/element/element2.dart';
import 'package:analyzer/dart/element/type.dart';

import 'decorator_utils.dart';

/// Handles generation of field accessors (getters and setters) for decorator classes
class FieldAccessorGenerator {
  final ClassElement2 classElement;
  final DecoratorUtils decoratorUtils;

  FieldAccessorGenerator(this.classElement, this.decoratorUtils);

  String generateFieldAccessors() {
    final buffer = StringBuffer();

    // Collect all fields and accessors that need to be implemented
    final allFields = <FieldElement2>[];
    final allAccessors = <PropertyAccessorElement2>[];
    final processedTypes = <String>{};

    void collectFieldsAndAccessors(InterfaceType interfaceType) {
      final typeName = interfaceType.element3.name3!;
      if (processedTypes.contains(typeName)) return;
      processedTypes.add(typeName);

      // Add fields from this interface/class
      for (final field in interfaceType.element3.fields2) {
        final isAccessible =
            !field.isPrivate || _isPrivateFieldAccessible(field);
        if (isAccessible &&
            !field.isStatic &&
            !decoratorUtils.isObjectMethod(field.name3!) &&
            !allFields.any((f) => f.name3 == field.name3)) {
          allFields.add(field);
        }
      }

      // Add standalone accessors from this interface/class
      for (final accessor in interfaceType.element3.getters2) {
        final isAccessible =
            !accessor.isPrivate || _isPrivateAccessorAccessible(accessor);
        if (isAccessible &&
            !accessor.isStatic &&
            !decoratorUtils.isObjectMethod(accessor.name3!) &&
            !decoratorUtils
                .isObjectMethod(accessor.name3!.replaceAll('=', '')) &&
            !allAccessors.any((a) => a.name3 == accessor.name3)) {
          allAccessors.add(accessor);
        }
      }

      // Recursively process all interfaces that this interface implements
      for (final superInterface in interfaceType.interfaces) {
        collectFieldsAndAccessors(superInterface);
      }

      // Process superclass if it exists
      if (interfaceType.superclass != null &&
          interfaceType.superclass!.element3.name3 != 'Object') {
        collectFieldsAndAccessors(interfaceType.superclass!);
      }
    }

    // Collect from the class itself (including accessible private members)
    for (final field in classElement.fields2) {
      final isAccessible = !field.isPrivate || _isPrivateFieldAccessible(field);
      if (isAccessible &&
          !field.isStatic &&
          !decoratorUtils.isObjectMethod(field.name3!)) {
        allFields.add(field);
      }
    }

    for (final accessor in classElement.getters2) {
      final isAccessible =
          !accessor.isPrivate || _isPrivateAccessorAccessible(accessor);
      if (isAccessible &&
          !accessor.isStatic &&
          !decoratorUtils.isObjectMethod(accessor.name3!) &&
          !decoratorUtils.isObjectMethod(accessor.name3!.replaceAll('=', ''))) {
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
        classElement.supertype!.element3.name3 != 'Object') {
      collectFieldsAndAccessors(classElement.supertype!);
    }

    // Generate accessors for fields
    for (final field in allFields) {
      _generateFieldAccessor(buffer, field);
    }

    return buffer.toString();
  }

  /// Checks if a private field is accessible from the decorator's context
  /// A private field is accessible if it's defined in the same library as the decorated class
  bool _isPrivateFieldAccessible(FieldElement2 field) {
    // Check if the field is defined in the same library as the class being decorated
    final fieldLibrary = field.library2;
    final classLibrary = classElement.library2;
    return fieldLibrary == classLibrary;
  }

  /// Checks if a private accessor is accessible from the decorator's context
  /// A private accessor is accessible if it's defined in the same library as the decorated class
  bool _isPrivateAccessorAccessible(PropertyAccessorElement2 accessor) {
    // Check if the accessor is defined in the same library as the class being decorated
    final accessorLibrary = accessor.library2;
    final classLibrary = classElement.library2;
    return accessorLibrary == classLibrary;
  }

  void _generateFieldAccessor(StringBuffer buffer, FieldElement2 field) {
    final instanceName = DecoratorUtils.toCamelCase(classElement.name3!);

    // For private fields, we need to generate getters and setters that delegate to the wrapped instance
    if (field.isPrivate && _isPrivateFieldAccessible(field)) {
      // Generate getter that delegates to the wrapped instance (if getter exists)
      if (field.getter2 != null) {
        buffer.writeln('  @override');
        buffer.writeln(
          '  ${field.type} get ${field.name3} => $instanceName.${field.name3};',
        );
        buffer.writeln();
      }

      // Generate setter that delegates to the wrapped instance (if setter exists and field is not final)
      if (field.setter2 != null && !field.isFinal) {
        buffer.writeln('  @override');
        buffer.writeln(
          '  set ${field.name3}(${field.type} value) { $instanceName.${field.name3} = value; }',
        );
        buffer.writeln();
      }
      return;
    }

    // Generate getter for public fields
    if (field.getter2 != null && !field.getter2!.isPrivate) {
      buffer.writeln('  @override');
      buffer.writeln(
        '  ${field.type} get ${field.name3} => $instanceName.${field.name3};',
      );
      buffer.writeln();
    }

    // Generate setter if it exists for public fields
    if (field.setter2 != null && !field.setter2!.isPrivate) {
      buffer.writeln('  @override');
      buffer.writeln(
        '  set ${field.name3}(${field.type} value) { $instanceName.${field.name3} = value; }',
      );
      buffer.writeln();
    }
  }
}
