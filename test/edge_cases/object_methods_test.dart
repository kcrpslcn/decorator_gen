import 'dart:async';

import 'package:decorator_annotation/decorator_annotation.dart';
import 'package:decorator_gen/src/generator.dart';
import 'package:source_gen_test/src/build_log_tracking.dart';
import 'package:source_gen_test/src/init_library_reader.dart';
import 'package:source_gen_test/src/test_annotated_classes.dart';

Future<void> main() async {
  final reader = await initializeLibraryReaderForDirectory(
    'test/edge_cases',
    'object_methods_test_library.dart',
  );

  initializeBuildLogTracking();
  testAnnotatedElements<Decorator>(
    reader,
    DecoratorGenerator(),
    expectedAnnotatedTests: _expectedAnnotatedTests,
  );

  final reversedReader = await initializeLibraryReaderForDirectory(
    'test/edge_cases',
    'object_methods_reversed_defaults_test_library.dart',
  );

  testAnnotatedElements<Decorator>(
    reversedReader,
    DecoratorGenerator(
      methodNameToIsForwarding: {
        'toString': false,
        '==': false,
        'hashCode': false,
        'runtimeType': true,
        'noSuchMethod': true,
      },
    ),
    expectedAnnotatedTests: _expectedAnnotatedTestsWithReversedDefaults,
  );
}

const _expectedAnnotatedTests = {
  'OverridesDefaultIncludedMethods',
  'OverridesDefaultExcludedMethods',
};

const _expectedAnnotatedTestsWithReversedDefaults = {
  'OverridesDefaultIncludedMethodsReversed',
  'OverridesDefaultExcludedMethodsReversed',
};
