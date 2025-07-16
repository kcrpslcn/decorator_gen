import 'dart:async';

import 'package:decorator_annotation/decorator_annotation.dart';
import 'package:source_gen_test/annotations.dart';

// Class with positional parameters
@ShouldGenerate(r'''
class PositionalParametersDecorator implements PositionalParameters {
  final PositionalParameters positionalParameters;

  PositionalParametersDecorator({required this.positionalParameters});

  @override
  void method1(String a) {
    positionalParameters.method1(a);
  }

  @override
  int method2(String first, int second) {
    return positionalParameters.method2(first, second);
  }

  @override
  String method3(int a, String b, bool c) {
    return positionalParameters.method3(a, b, c);
  }

  @override
  void method4(List<String> items, Map<int, String> mapping, Set<bool> flags) {
    positionalParameters.method4(items, mapping, flags);
  }
}
''')
@Decorator()
class PositionalParameters {
  void method1(String a) {}
  int method2(String first, int second) => 0;
  String method3(int a, String b, bool c) => '';
  void method4(List<String> items, Map<int, String> mapping, Set<bool> flags) {}
}

// Class with optional positional parameters
@ShouldGenerate(r'''
class OptionalParametersDecorator implements OptionalParameters {
  final OptionalParameters optionalParameters;

  OptionalParametersDecorator({required this.optionalParameters});

  @override
  void method1(String required, [String? optional]) {
    optionalParameters.method1(required, optional);
  }

  @override
  int method2(int a, [int? b, String? c]) {
    return optionalParameters.method2(a, b, c);
  }

  @override
  String method3(bool flag, [int count = 10, String prefix = 'default']) {
    return optionalParameters.method3(flag, count, prefix);
  }

  @override
  List<T> method4<T>(T item, [int count = 1]) {
    return optionalParameters.method4(item, count);
  }
}
''')
@Decorator()
class OptionalParameters {
  void method1(String required, [String? optional]) {}
  int method2(int a, [int? b, String? c]) => 0;
  String method3(bool flag, [int count = 10, String prefix = 'default']) => '';
  List<T> method4<T>(T item, [int count = 1]) => [];
}

// Class with named parameters
@ShouldGenerate(r'''
class NamedParametersDecorator implements NamedParameters {
  final NamedParameters namedParameters;

  NamedParametersDecorator({required this.namedParameters});

  @override
  void method1({required String name, int? age}) {
    namedParameters.method1(name: name, age: age);
  }

  @override
  String method2({
    required bool flag,
    String prefix = 'default',
    int count = 0,
  }) {
    return namedParameters.method2(flag: flag, prefix: prefix, count: count);
  }

  @override
  Future<List<T>> method3<T>({
    required T item,
    int repeat = 1,
    bool validate = true,
    String? description,
  }) {
    return namedParameters.method3(
      item: item,
      repeat: repeat,
      validate: validate,
      description: description,
    );
  }

  @override
  Map<String, dynamic> method4({
    String? optionalString,
    required List<int> requiredList,
    Map<String, bool>? optionalMap,
  }) {
    return namedParameters.method4(
      optionalString: optionalString,
      requiredList: requiredList,
      optionalMap: optionalMap,
    );
  }
}
''')
@Decorator()
class NamedParameters {
  void method1({required String name, int? age}) {}

  String method2({
    required bool flag,
    String prefix = 'default',
    int count = 0,
  }) => '';

  Future<List<T>> method3<T>({
    required T item,
    int repeat = 1,
    bool validate = true,
    String? description,
  }) async => [];

  Map<String, dynamic> method4({
    String? optionalString,
    required List<int> requiredList,
    Map<String, bool>? optionalMap,
  }) => {};
}

// Class with complex parameter combinations
@ShouldGenerate(r'''
class ComplexParametersDecorator implements ComplexParameters {
  final ComplexParameters complexParameters;

  ComplexParametersDecorator({required this.complexParameters});

  @override
  Future<Map<String, T>> complexMethod<T extends Comparable<T>>(
    String requiredPositional,
    List<T> requiredList, [
    int? optionalPositional,
    String optionalWithDefault = 'default',
  ]) {
    return complexParameters.complexMethod(
      requiredPositional,
      requiredList,
      optionalPositional,
      optionalWithDefault,
    );
  }

  @override
  Stream<U> mixedParameters<T, U>(
    T positionalRequired,
    List<T> positionalList, [
    Map<String, T>? optionalMap,
  ]) {
    return complexParameters.mixedParameters(
      positionalRequired,
      positionalList,
      optionalMap,
    );
  }

  @override
  void positionalNamedParameters(
    String positional,
    int positionalTwo, {
    bool? optionalNamed,
    required String requiredNamed,
  }) {
    complexParameters.positionalNamedParameters(
      positional,
      positionalTwo,
      optionalNamed: optionalNamed,
      requiredNamed: requiredNamed,
    );
  }
}
''')
@Decorator()
class ComplexParameters {
  Future<Map<String, T>> complexMethod<T extends Comparable<T>>(
    String requiredPositional,
    List<T> requiredList, [
    int? optionalPositional,
    String optionalWithDefault = 'default',
  ]) async => {};

  Stream<U> mixedParameters<T, U>(
    T positionalRequired,
    List<T> positionalList, [
    Map<String, T>? optionalMap,
  ]) => Stream.empty();

  void positionalNamedParameters(
    String positional,
    int positionalTwo, {
    bool? optionalNamed,
    required String requiredNamed,
  }) {}
}

// Class with function type parameters
@ShouldGenerate(r'''
class FunctionTypeParametersDecorator implements FunctionTypeParameters {
  final FunctionTypeParameters functionTypeParameters;

  FunctionTypeParametersDecorator({required this.functionTypeParameters});

  @override
  void method1(void Function() callback) {
    functionTypeParameters.method1(callback);
  }

  @override
  int method2(int Function(String) transformer, String input) {
    return functionTypeParameters.method2(transformer, input);
  }

  @override
  Future<T> method3<T>(Future<T> Function() asyncProvider) {
    return functionTypeParameters.method3(asyncProvider);
  }

  @override
  void method4({
    required void Function(String) onSuccess,
    void Function(Object)? onError,
    bool Function()? validator,
  }) {
    functionTypeParameters.method4(
      onSuccess: onSuccess,
      onError: onError,
      validator: validator,
    );
  }

  @override
  List<U> method5<T, U>(
    List<T> items,
    U Function(T) mapper, [
    bool Function(T)? filter,
  ]) {
    return functionTypeParameters.method5(items, mapper, filter);
  }
}
''')
@Decorator()
class FunctionTypeParameters {
  void method1(void Function() callback) {}

  int method2(int Function(String) transformer, String input) => 0;

  Future<T> method3<T>(Future<T> Function() asyncProvider) => asyncProvider();

  void method4({
    required void Function(String) onSuccess,
    void Function(Object)? onError,
    bool Function()? validator,
  }) {}

  List<U> method5<T, U>(
    List<T> items,
    U Function(T) mapper, [
    bool Function(T)? filter,
  ]) => [];
}
