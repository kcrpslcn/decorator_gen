import 'package:analyzer/dart/element/element2.dart';

import 'decorator_utils.dart';

/// Handles generation of Object method forwarding for decorator classes
class ObjectMethodGenerator {
  final ClassElement2 classElement;
  final DecoratorUtils decoratorUtils;

  const ObjectMethodGenerator(this.classElement, this.decoratorUtils);

  String generateObjectMethods() {
    final buffer = StringBuffer();
    final instanceName = DecoratorUtils.toCamelCase(classElement.name3!);

    for (final methodName in decoratorUtils.getObjectMethodsToForward()) {
      buffer.writeln('  @override');

      switch (methodName) {
        case 'toString':
          buffer.writeln('  String toString() {');
          buffer.writeln('    return $instanceName.toString();');
          buffer.writeln('  }');
          break;

        case '==':
          buffer.writeln('  bool operator ==(Object other) {');
          buffer.writeln('    return $instanceName == other;');
          buffer.writeln('  }');
          break;

        case 'hashCode':
          buffer.writeln('  int get hashCode => $instanceName.hashCode;');
          break;

        case 'runtimeType':
          buffer
              .writeln('  Type get runtimeType => $instanceName.runtimeType;');
          break;

        case 'noSuchMethod':
          buffer.writeln('  dynamic noSuchMethod(Invocation invocation) {');
          buffer.writeln('    return $instanceName.noSuchMethod(invocation);');
          buffer.writeln('  }');
          break;
      }

      buffer.writeln();
    }

    return buffer.toString();
  }
}
