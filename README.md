# Decorator Gen
A Dart code generator that automatically creates the [decorator pattern] for your Dart code.

The builder generates code if it finds classes with annotations from the [decorator_annotation] package.

## Features
- Generate complete decorator classes with a single `@Decorator()` annotation
  - Forward all public members of the source class
  - Works with generics, records, nested types, etc.
- Option to forward Object methods 
  - automatically forwarded: `toString` , `==`, `hashCode`
  - **not** automatically forwarded: `runtimeType` and `noSuchMethod` 

## Installation
Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  decorator_annotation: ^latest

dev_dependencies:
  decorator_gen: ^latest
  build_runner: any
```

## Usage
### 1. Annotate Your Class And Include The Part Directive
```dart
import 'package:decorator_annotation/decorator_annotation.dart';

part 'example.g.dart'; // This part directive is necessary for code generation

@Decorator() // Add this annotation to generate a decorator for this class
class MyService {
  final String name;
  
  MyService(this.name);
  
  String greet(String message) => 'Hello $message from $name';
  
  Future<String> asyncOperation() async {
    await Future.delayed(const Duration(seconds: 1));
    return 'Completed';
  }
}

// Generates: MyServiceDecorator in example.g.dart
class MyServiceDecorator implements MyService {
  final MyService myService;

  MyServiceDecorator({required this.myService});

  @override
  String greet(String message) {
    return myService.greet(message);
  }

  @override
  Future<String> asyncOperation() {
    return myService.asyncOperation();
  }

  @override
  String get name => myService.name;
}
```

### 2. Run Code Generation
```bash
dart run build_runner build
```

### 3. Use Your Generated Decorator
```dart
// Generated: MyServiceDecorator
class LoggingServiceDecorator extends MyServiceDecorator {
  LoggingServiceDecorator({required super.myService});

  @override
  String greet(String message) {
    print('Calling greet with: $message');
    final result = super.greet(message);
    print('greet returned: $result');
    return result;
  }

  @override
  Future<String> asyncOperation() async {
    print('Starting async operation');
    final result = await super.asyncOperation();
    print('Async operation completed');
    return result;
  }
}

// Usage
final service = MyService('TestService');
final decorator = LoggingServiceDecorator(myService: service);
print(decorator.greet('World')); // Logs and returns result
```

## Supported Features
### Generics (with Bounds)
```dart
@Decorator()
class GenericService<T extends Comparable<T>> {
  T process(T value) => /* implementation */
}
// Generates: GenericServiceDecorator<T extends Comparable<T>>
```

### Mixins
```dart
mixin SimpleMixin {
  void mixinMethod() => /* implementation */
}

@Decorator()
class MixinService with SimpleMixin {
  void ownMethod() => /* implementation */
}
// Generates: MixinServiceDecorator having mixinMethod and ownMethod 
```

### Object methods
```dart
@Decorator()
class ObjectService {
  @override
  String toString() => 'Hello World!'; // included by default

  @override
  Type get runtimeType => super.runtimeType; // excluded by default
}
// Generates: ObjectServiceDecorator with forwarded toString only
```


### Operators
```dart
@Decorator()
class OperatorService {
  int operator +(int other) => /* implementation */
  bool operator ==(Object other) => /* implementation */
  int operator [](int index) => /* implementation */
}
// Generates: OperatorServiceDecorator with forwarded operators
```

### Parameters (positional, named, optional, combined)
```dart
@Decorator()
class ParameterService {
  void positionalNamed(int a, {String? b, double c = 0.0}) => /* implementation */
  void positionalOptional(int a, [String? b, double c = 0.0]) => /* implementation */
}
// Generates: ParameterServiceDecorator with all parameter types handled
```

### Records 
```dart
@Decorator()
class RecordService {
  (int, String) getTuple() => (42, 'Hello World!');
  
  // With named fields
  void setRecord(({int foo, String bar}) record) => /* implementation */
}
// Generates: RecordServiceDecorator with tuple handling
```

## Forwarding Object Methods
If, and only if, you override Object methods in your class, 
the generator **can** generate code that forwards these methods.

The following Object methods are **included** by default:
- `toString`
- `==`
- `hashCode`

The following Object methods are **excluded** by default:
- `runtimeType`
- `noSuchMethod`


You can customize this behavior in your `build.yaml` file:

```yaml
targets:
  $default:
    builders:
      decorator_gen:
        enabled: true
        options:
          forward_object_method:
            toString: true # Defaults to true
            "==": true # Defaults to true
            hashCode: true # Defaults to true
            runtimeType: false # Defaults to false
            noSuchMethod: false # Defaults to false
```

## FAQ
### Private members
Private members (those starting with `_`) **are** included in the generated decorators. 
This is required by the Dart compiler. All accessible members must be implemented.

### Static members
Static members are **not** included in the generated decorators.

## Contributing
Contributions are welcome! Please feel free to submit a Pull Request.

## License
This project is licensed under the MIT License.

[decorator_annotation]: https://pub.dev/packages/decorator_annotation
[decorator pattern]: https://en.wikipedia.org/wiki/Decorator_pattern