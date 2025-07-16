import 'package:decorator_annotation/decorator_annotation.dart';
import 'package:source_gen_test/annotations.dart';

// Simple generic class
@ShouldGenerate(r'''
class GenericClassDecorator<T> implements GenericClass<T> {
  final GenericClass<T> genericClass;

  GenericClassDecorator({required this.genericClass});

  @override
  T getValue() {
    return genericClass.getValue();
  }

  @override
  void setValue(T value) {
    genericClass.setValue(value);
  }

  @override
  T get _value => genericClass._value;

  @override
  set _value(T value) {
    genericClass._value = value;
  }

  @override
  T get value => genericClass.value;

  @override
  set value(T value) {
    genericClass.value = value;
  }
}
''')
@Decorator()
class GenericClass<T> {
  T _value;

  GenericClass(this._value);

  T getValue() => _value;
  void setValue(T value) => _value = value;

  T get value => _value;
  set value(T newValue) => _value = newValue;
}

// Class with multiple type parameters
@ShouldGenerate(r'''
class MultipleGenericsClassDecorator<T, U, V>
    implements MultipleGenericsClass<T, U, V> {
  final MultipleGenericsClass<T, U, V> multipleGenericsClass;

  MultipleGenericsClassDecorator({required this.multipleGenericsClass});

  @override
  Map<T, U> process(V input) {
    return multipleGenericsClass.process(input);
  }

  @override
  T transformKey(U value) {
    return multipleGenericsClass.transformKey(value);
  }

  @override
  U transformValue(T key) {
    return multipleGenericsClass.transformValue(key);
  }

  @override
  V combine(T key, U value) {
    return multipleGenericsClass.combine(key, value);
  }
}
''')
@Decorator()
class MultipleGenericsClass<T, U, V> {
  Map<T, U> process(V input) => {};
  T transformKey(U value) => throw UnimplementedError();
  U transformValue(T key) => throw UnimplementedError();
  V combine(T key, U value) => throw UnimplementedError();
}

// Generic class with bounded type parameters
@ShouldGenerate(r'''
class BoundedGenericsClassDecorator<T extends Comparable<T>, U extends List<T>>
    implements BoundedGenericsClass<T, U> {
  final BoundedGenericsClass<T, U> boundedGenericsClass;

  BoundedGenericsClassDecorator({required this.boundedGenericsClass});

  @override
  T findMax(U list) {
    return boundedGenericsClass.findMax(list);
  }

  @override
  U sort(U list) {
    return boundedGenericsClass.sort(list);
  }

  @override
  bool isGreater(T a, T b) {
    return boundedGenericsClass.isGreater(a, b);
  }
}
''')
@Decorator()
class BoundedGenericsClass<T extends Comparable<T>, U extends List<T>> {
  T findMax(U list) => throw UnimplementedError();
  U sort(U list) => list..sort();
  bool isGreater(T a, T b) => a.compareTo(b) > 0;
}

// Generic class with nested generics
@ShouldGenerate(r'''
class NestedGenericsClassDecorator<T> implements NestedGenericsClass<T> {
  final NestedGenericsClass<T> nestedGenericsClass;

  NestedGenericsClassDecorator({required this.nestedGenericsClass});

  @override
  Future<List<T>> processAsync(List<Future<T>> futures) {
    return nestedGenericsClass.processAsync(futures);
  }

  @override
  Map<String, List<T>> groupData(List<T> data) {
    return nestedGenericsClass.groupData(data);
  }

  @override
  Stream<T> createStream(Iterable<T> data) {
    return nestedGenericsClass.createStream(data);
  }
}
''')
@Decorator()
class NestedGenericsClass<T> {
  Future<List<T>> processAsync(List<Future<T>> futures) => Future.wait(futures);
  Map<String, List<T>> groupData(List<T> data) => {};
  Stream<T> createStream(Iterable<T> data) => Stream.fromIterable(data);
}

// Generic class with complex constraints
@ShouldGenerate(r'''
class GenericWithComplexConstraintsDecorator<
  T extends Comparable<T>,
  U extends Iterable<T>,
  V extends Map<T, U>
>
    implements GenericWithComplexConstraints<T, U, V> {
  final GenericWithComplexConstraints<T, U, V> genericWithComplexConstraints;

  GenericWithComplexConstraintsDecorator({
    required this.genericWithComplexConstraints,
  });

  @override
  T findMinInCollection(U collection) {
    return genericWithComplexConstraints.findMinInCollection(collection);
  }

  @override
  V filterMap(V map, bool Function(T) predicate) {
    return genericWithComplexConstraints.filterMap(map, predicate);
  }

  @override
  U mergeLists(V map) {
    return genericWithComplexConstraints.mergeLists(map);
  }

  @override
  bool validateConstraints(T value, U collection, V map) {
    return genericWithComplexConstraints.validateConstraints(
      value,
      collection,
      map,
    );
  }
}
''')
@Decorator()
class GenericWithComplexConstraints<
  T extends Comparable<T>,
  U extends Iterable<T>,
  V extends Map<T, U>
> {
  T findMinInCollection(U collection) => throw UnimplementedError();

  V filterMap(V map, bool Function(T) predicate) => throw UnimplementedError();

  U mergeLists(V map) => throw UnimplementedError();

  bool validateConstraints(T value, U collection, V map) =>
      throw UnimplementedError();
}
