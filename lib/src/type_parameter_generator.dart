import 'package:analyzer/dart/element/element2.dart';
import 'package:decorator_gen/src/decorator_utils.dart';

/// Handles generation of type parameters for decorator classes
class TypeParameterGenerator {
  final ClassElement2 classElement;
  final DecoratorUtils decoratorUtils;

  TypeParameterGenerator(this.classElement, this.decoratorUtils);

  /// Generates type parameters string for class declaration (includes bounds)
  String generateTypeParameters() {
    return classElement.typeParameters2.isNotEmpty
        ? '<${classElement.typeParameters2.map((tp) {
            final bound = tp.bound;
            return bound != null ? '${tp.name3} extends $bound' : tp.name3;
          }).join(', ')}>'
        : '';
  }

  /// Generates type parameters string for type references (no bounds)
  String generateTypeReference() {
    return classElement.typeParameters2.isNotEmpty
        ? '<${classElement.typeParameters2.map((tp) => tp.name3).join(', ')}>'
        : '';
  }
}
