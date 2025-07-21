import 'package:decorator_annotation/decorator_annotation.dart';

part 'forwarding_example.g.dart';

// Example class that uses annotation-level forwarding settings
@Decorator(
  forwardToString: true,
  forwardEquals: false, // This overrides build.yaml default
  forwardHashCode: true,
  forwardRuntimeType: true, // This overrides build.yaml default
  forwardNoSuchMethod: false,
)
class CustomService {
  final String name;

  CustomService(this.name);

  @override
  String toString() => 'CustomService($name)';

  @override
  bool operator ==(Object other) =>
      other is CustomService && other.name == name;

  @override
  int get hashCode => name.hashCode;

  @override
  Type get runtimeType => super.runtimeType;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);

  String processData(String data) => 'Processing: $data';
}

// Example with minimal forwarding
@Decorator(
  forwardToString: false,
  forwardEquals: false,
  forwardHashCode: false,
)
class MinimalService {
  final int id;

  MinimalService(this.id);

  @override
  String toString() => 'MinimalService($id)';

  @override
  bool operator ==(Object other) => other is MinimalService && other.id == id;

  @override
  int get hashCode => id.hashCode;

  void execute() => print('Executing service $id');
}

void main() {
  final service = CustomService('test');
  final decorator = CustomServiceDecorator(customService: service);

  print(decorator.toString()); // Will forward to underlying service
  print(decorator.runtimeType); // Will forward to underlying service
  print(decorator.processData('example')); // Regular method forwarding

  final minimal = MinimalService(42);
  final minimalDecorator = MinimalServiceDecorator(minimalService: minimal);

  minimalDecorator
      .execute(); // Only regular methods, no Object method forwarding
}
