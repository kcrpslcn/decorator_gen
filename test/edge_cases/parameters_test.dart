import 'dart:async';

import 'package:decorator_annotation/decorator_annotation.dart';
import 'package:decorator_gen/src/generator.dart';
import 'package:source_gen_test/src/build_log_tracking.dart';
import 'package:source_gen_test/src/init_library_reader.dart';
import 'package:source_gen_test/src/test_annotated_classes.dart';

Future<void> main() async {
  final reader = await initializeLibraryReaderForDirectory(
    'test/edge_cases',
    'parameters_test_library.dart',
  );

  initializeBuildLogTracking();
  testAnnotatedElements<Decorator>(
    reader,
    DecoratorGenerator.noObjectMethodForwarding(),
    expectedAnnotatedTests: _expectedAnnotatedTests,
  );
}

const _expectedAnnotatedTests = {
  'PositionalParameters',
  'OptionalParameters',
  'NamedParameters',
  'ComplexParameters',
  'FunctionTypeParameters',
};
