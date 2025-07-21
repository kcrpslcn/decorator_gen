import 'package:analyzer/dart/element/element2.dart';
import 'package:build/build.dart';
import 'package:decorator_annotation/decorator_annotation.dart';
import 'package:source_gen/source_gen.dart';

import 'decorator_builder.dart';

class DecoratorGenerator extends GeneratorForAnnotation<Decorator> {
  final Map<String, bool> methodNameToIsForwarding;

  const DecoratorGenerator({this.methodNameToIsForwarding = const {}});

  @override
  String generateForAnnotatedElement(
    Element2 element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement2) {
      throw InvalidGenerationSourceError(
        'Generator can only be applied to classes.',
        element: element,
      );
    }

    // Extract forwarding settings from annotation and merge with build.yaml settings
    final annotationForwardingSettings = _extractForwardingSettings(annotation);
    final mergedSettings = _mergeForwardingSettings(
      buildYamlSettings: methodNameToIsForwarding,
      annotationSettings: annotationForwardingSettings,
    );

    // Create decorator builder and generate the code
    final builder = DecoratorBuilder(element, mergedSettings);
    return builder();
  }

  /// Extracts forwarding settings from the @Decorator annotation
  Map<String, bool> _extractForwardingSettings(ConstantReader annotation) {
    final forwardingSettings = <String, bool>{};

    // Read each forwarding property from the annotation
    final forwardToString = annotation.read('forwardToString');
    if (!forwardToString.isNull) {
      forwardingSettings['toString'] = forwardToString.boolValue;
    }

    final forwardEquals = annotation.read('forwardEquals');
    if (!forwardEquals.isNull) {
      forwardingSettings['=='] = forwardEquals.boolValue;
    }

    final forwardHashCode = annotation.read('forwardHashCode');
    if (!forwardHashCode.isNull) {
      forwardingSettings['hashCode'] = forwardHashCode.boolValue;
    }

    final forwardRuntimeType = annotation.read('forwardRuntimeType');
    if (!forwardRuntimeType.isNull) {
      forwardingSettings['runtimeType'] = forwardRuntimeType.boolValue;
    }

    final forwardNoSuchMethod = annotation.read('forwardNoSuchMethod');
    if (!forwardNoSuchMethod.isNull) {
      forwardingSettings['noSuchMethod'] = forwardNoSuchMethod.boolValue;
    }

    return forwardingSettings;
  }

  /// Merges forwarding settings with annotation settings taking precedence over build.yaml settings
  Map<String, bool> _mergeForwardingSettings({
    required Map<String, bool> buildYamlSettings,
    required Map<String, bool> annotationSettings,
  }) {
    final merged = Map<String, bool>.from(buildYamlSettings);

    // Annotation settings override build.yaml settings
    merged.addAll(annotationSettings);

    return merged;
  }
}
