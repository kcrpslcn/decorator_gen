import 'package:analyzer/dart/element/element.dart';
import 'package:decorator_gen/src/decorator_utils.dart';

/// Handles generation of type parameters for decorator classes
class TypeParameterGenerator {
  final ClassElement classElement;
  final DecoratorUtils decoratorUtils;

  TypeParameterGenerator(this.classElement, this.decoratorUtils);

  /// Generates type parameters string for class declaration (includes bounds)
  String generateTypeParameters() {
    return classElement.typeParameters.isNotEmpty
        ? '<${classElement.typeParameters.map((tp) {
            final bound = tp.bound;
            return bound != null ? '${tp.name} extends $bound' : tp.name;
          }).join(', ')}>'
        : '';
  }

  /// Generates type parameters string for type references (no bounds)
  String generateTypeReference() {
    return classElement.typeParameters.isNotEmpty
        ? '<${classElement.typeParameters.map((tp) => tp.name).join(', ')}>'
        : '';
  }
}
