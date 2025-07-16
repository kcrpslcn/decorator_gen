import 'package:decorator_annotation/decorator_annotation.dart';
import 'package:source_gen_test/annotations.dart';

// Class with arithmetic operators
@ShouldGenerate(r'''
class ArithmeticOperatorsDecorator implements ArithmeticOperators {
  final ArithmeticOperators arithmeticOperators;

  ArithmeticOperatorsDecorator({required this.arithmeticOperators});

  @override
  ArithmeticOperators operator +(ArithmeticOperators other) {
    return arithmeticOperators + other;
  }

  @override
  ArithmeticOperators operator -(ArithmeticOperators other) {
    return arithmeticOperators - other;
  }

  @override
  ArithmeticOperators operator *(ArithmeticOperators other) {
    return arithmeticOperators * other;
  }

  @override
  ArithmeticOperators operator /(ArithmeticOperators other) {
    return arithmeticOperators / other;
  }

  @override
  ArithmeticOperators operator %(ArithmeticOperators other) {
    return arithmeticOperators % other;
  }

  @override
  num get value => arithmeticOperators.value;
}
''')
@Decorator()
class ArithmeticOperators {
  final num value;

  ArithmeticOperators(this.value);

  ArithmeticOperators operator +(ArithmeticOperators other) =>
      ArithmeticOperators(value + other.value);

  ArithmeticOperators operator -(ArithmeticOperators other) =>
      ArithmeticOperators(value - other.value);

  ArithmeticOperators operator *(ArithmeticOperators other) =>
      ArithmeticOperators(value * other.value);

  ArithmeticOperators operator /(ArithmeticOperators other) =>
      ArithmeticOperators(value / other.value);

  ArithmeticOperators operator %(ArithmeticOperators other) =>
      ArithmeticOperators(value % other.value);
}

// Class with comparison operators
@ShouldGenerate(r'''
class ComparisonOperatorsDecorator implements ComparisonOperators {
  final ComparisonOperators comparisonOperators;

  ComparisonOperatorsDecorator({required this.comparisonOperators});

  @override
  bool operator <(ComparisonOperators other) {
    return comparisonOperators < other;
  }

  @override
  bool operator <=(ComparisonOperators other) {
    return comparisonOperators <= other;
  }

  @override
  bool operator >(ComparisonOperators other) {
    return comparisonOperators > other;
  }

  @override
  bool operator >=(ComparisonOperators other) {
    return comparisonOperators >= other;
  }

  @override
  bool operator ==(Object other) {
    return comparisonOperators == other;
  }

  @override
  int compareTo(ComparisonOperators other) {
    return comparisonOperators.compareTo(other);
  }

  @override
  int get value => comparisonOperators.value;

  @override
  int get hashCode => comparisonOperators.hashCode;
}
''')
@Decorator()
class ComparisonOperators implements Comparable<ComparisonOperators> {
  final int value;

  ComparisonOperators(this.value);

  bool operator <(ComparisonOperators other) => value < other.value;
  bool operator <=(ComparisonOperators other) => value <= other.value;
  bool operator >(ComparisonOperators other) => value > other.value;
  bool operator >=(ComparisonOperators other) => value >= other.value;

  @override
  bool operator ==(Object other) =>
      other is ComparisonOperators && value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  int compareTo(ComparisonOperators other) => value.compareTo(other.value);
}

// Class with bitwise operators
@ShouldGenerate(r'''
class BitwiseOperatorsDecorator implements BitwiseOperators {
  final BitwiseOperators bitwiseOperators;

  BitwiseOperatorsDecorator({required this.bitwiseOperators});

  @override
  BitwiseOperators operator &(BitwiseOperators other) {
    return bitwiseOperators & other;
  }

  @override
  BitwiseOperators operator |(BitwiseOperators other) {
    return bitwiseOperators | other;
  }

  @override
  BitwiseOperators operator ^(BitwiseOperators other) {
    return bitwiseOperators ^ other;
  }

  @override
  BitwiseOperators operator ~() {
    return ~bitwiseOperators;
  }

  @override
  BitwiseOperators operator <<(int shiftAmount) {
    return bitwiseOperators << shiftAmount;
  }

  @override
  BitwiseOperators operator >>(int shiftAmount) {
    return bitwiseOperators >> shiftAmount;
  }

  @override
  int get value => bitwiseOperators.value;
}
''')
@Decorator()
class BitwiseOperators {
  final int value;

  BitwiseOperators(this.value);

  BitwiseOperators operator &(BitwiseOperators other) =>
      BitwiseOperators(value & other.value);

  BitwiseOperators operator |(BitwiseOperators other) =>
      BitwiseOperators(value | other.value);

  BitwiseOperators operator ^(BitwiseOperators other) =>
      BitwiseOperators(value ^ other.value);

  BitwiseOperators operator ~() => BitwiseOperators(~value);

  BitwiseOperators operator <<(int shiftAmount) =>
      BitwiseOperators(value << shiftAmount);

  BitwiseOperators operator >>(int shiftAmount) =>
      BitwiseOperators(value >> shiftAmount);
}

// Class with custom operators (index operators)
@ShouldGenerate(r'''
class ListOperatorsDecorator implements ListOperators {
  final ListOperators listOperators;

  ListOperatorsDecorator({required this.listOperators});

  @override
  int operator [](int index) {
    return listOperators[index];
  }

  @override
  void operator []=(int index, int value) {
    listOperators[index] = value;
  }

  @override
  List<int> get _data => listOperators._data;
}
''')
@Decorator()
class ListOperators {
  final List<int> _data = [];

  int operator [](int index) => _data[index];
  void operator []=(int index, int value) => _data[index] = value;
}
