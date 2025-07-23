// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forwarding_example.dart';

// **************************************************************************
// DecoratorGenerator
// **************************************************************************

class CustomServiceDecorator implements CustomService {
  final CustomService customService;

  CustomServiceDecorator({required this.customService});

  @override
  String processData(String data) {
    return customService.processData(data);
  }

  @override
  String get name => customService.name;

  @override
  String toString() {
    return customService.toString();
  }

  @override
  int get hashCode => customService.hashCode;

  @override
  Type get runtimeType => customService.runtimeType;
}

class MinimalServiceDecorator implements MinimalService {
  final MinimalService minimalService;

  MinimalServiceDecorator({required this.minimalService});

  @override
  void execute() {
    minimalService.execute();
  }

  @override
  int get id => minimalService.id;
}
