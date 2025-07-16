library;

import 'package:build/build.dart';
import 'package:decorator_gen/src/generator.dart';
import 'package:source_gen/source_gen.dart';

Builder decoratorBuilder(BuilderOptions options) {
  final methodNameToIsForwarding = _methodNameToIsForwardingFrom(options);

  return SharedPartBuilder(
    [
      DecoratorGenerator(
        methodNameToIsForwarding: methodNameToIsForwarding,
      )
    ],
    'decorator_gen',
  );
}

const String _forwardObjectMethod = 'forward_object_method';
Map<String, bool> _methodNameToIsForwardingFrom(BuilderOptions options) {
  final config = options.config[_forwardObjectMethod];
  if (config == null) return {};

  return Map<String, dynamic>.from(config).map(
    (key, value) => MapEntry(key, value as bool),
  );
}
