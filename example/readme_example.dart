import 'package:decorator_annotation/decorator_annotation.dart';

part 'readme_example.g.dart';

@Decorator()
class MyService {
  final String name;

  MyService(this.name);

  String greet(String message) => 'Hello $message from $name';

  Future<String> asyncOperation() async {
    await Future.delayed(const Duration(seconds: 1));
    return 'Completed';
  }
}

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

void main() {
  // Usage
  final myService = MyService('TestService');
  final decorator = LoggingServiceDecorator(myService: myService);
  print(decorator.greet('World'));
}
