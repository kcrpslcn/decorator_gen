// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'readme_example.dart';

// **************************************************************************
// DecoratorGenerator
// **************************************************************************

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
