import 'package:decorator_annotation/decorator_annotation.dart';
import 'package:source_gen_test/annotations.dart';

// Class with simple record types
@ShouldGenerate(r'''
class SimpleRecordsDecorator implements SimpleRecords {
  final SimpleRecords simpleRecords;

  SimpleRecordsDecorator({required this.simpleRecords});

  @override
  (int, String) getCoordinates() {
    return simpleRecords.getCoordinates();
  }

  @override
  void setCoordinates((int, String) coords) {
    simpleRecords.setCoordinates(coords);
  }

  @override
  (bool, int, String) processData() {
    return simpleRecords.processData();
  }

  @override
  (double, double) get _position => simpleRecords._position;

  @override
  set _position((double, double) value) {
    simpleRecords._position = value;
  }

  @override
  (double, double) get position => simpleRecords.position;

  @override
  set position((double, double) value) {
    simpleRecords.position = value;
  }
}
''')
@Decorator()
class SimpleRecords {
  (double, double) _position = (0.0, 0.0);

  (int, String) getCoordinates() => (42, 'test');
  void setCoordinates((int, String) coords) {}
  (bool, int, String) processData() => (true, 1, 'data');

  (double, double) get position => _position;
  set position((double, double) value) => _position = value;
}

// Class with named record types
@ShouldGenerate(r'''
class NamedRecordsDecorator implements NamedRecords {
  final NamedRecords namedRecords;

  NamedRecordsDecorator({required this.namedRecords});

  @override
  ({int age, String name}) getPerson() {
    return namedRecords.getPerson();
  }

  @override
  void updatePerson({required String name, required int age}) {
    namedRecords.updatePerson(name: name, age: age);
  }

  @override
  ({bool isActive, List<String> tags, String? title}) getMetadata() {
    return namedRecords.getMetadata();
  }

  @override
  ({double x, double y, double z}) get _coordinates =>
      namedRecords._coordinates;

  @override
  set _coordinates(({double x, double y, double z}) value) {
    namedRecords._coordinates = value;
  }

  @override
  ({double x, double y, double z}) get coordinates => namedRecords.coordinates;

  @override
  set coordinates(({double x, double y, double z}) value) {
    namedRecords.coordinates = value;
  }
}
''')
@Decorator()
class NamedRecords {
  ({double x, double y, double z}) _coordinates = (x: 0.0, y: 0.0, z: 0.0);

  ({String name, int age}) getPerson() => (name: 'John', age: 30);
  void updatePerson({required String name, required int age}) {}
  ({String? title, bool isActive, List<String> tags}) getMetadata() =>
      (title: null, isActive: true, tags: []);

  ({double x, double y, double z}) get coordinates => _coordinates;
  set coordinates(({double x, double y, double z}) value) =>
      _coordinates = value;
}

// Class with complex record combinations
@ShouldGenerate(r'''
class ComplexRecordsDecorator implements ComplexRecords {
  final ComplexRecords complexRecords;

  ComplexRecordsDecorator({required this.complexRecords});

  @override
  (String, {int count, bool flag}) mixedRecord() {
    return complexRecords.mixedRecord();
  }

  @override
  ({(int, String) data, String name}) nestedRecord() {
    return complexRecords.nestedRecord();
  }

  @override
  Map<String, (int, bool)> recordMap() {
    return complexRecords.recordMap();
  }

  @override
  List<({String key, int value})> recordList() {
    return complexRecords.recordList();
  }

  @override
  Future<(bool, String?)> asyncRecord() {
    return complexRecords.asyncRecord();
  }
}
''')
@Decorator()
class ComplexRecords {
  (String, {int count, bool flag}) mixedRecord() =>
      ('test', count: 5, flag: true);

  ({String name, (int, String) data}) nestedRecord() =>
      (name: 'item', data: (42, 'value'));

  Map<String, (int, bool)> recordMap() => {'key': (1, true)};

  List<({String key, int value})> recordList() => [(key: 'test', value: 100)];

  Future<(bool, String?)> asyncRecord() async => (true, 'success');
}

// Class with nested and generic records
@ShouldGenerate(r'''
class NestedRecordsDecorator implements NestedRecords {
  final NestedRecords nestedRecords;

  NestedRecordsDecorator({required this.nestedRecords});

  @override
  (({int id, String name}), ({bool active, List<String> permissions}))
  getUserWithPermissions() {
    return nestedRecords.getUserWithPermissions();
  }

  @override
  Future<(T, {String message, bool success})> processGeneric<T>(T data) {
    return nestedRecords.processGeneric(data);
  }

  @override
  ({String category, (int, {bool isMetric, String unit}) measurement})
  getComplexData() {
    return nestedRecords.getComplexData();
  }

  @override
  Stream<(String, {Map<String, dynamic> metadata, DateTime timestamp})>
  getEventStream() {
    return nestedRecords.getEventStream();
  }
}
''')
@Decorator()
class NestedRecords {
  (
    ({String name, int id}),
    ({bool active, List<String> permissions})
  ) getUserWithPermissions() =>
      ((name: 'user', id: 1), (active: true, permissions: ['read']));

  Future<(T, {String message, bool success})> processGeneric<T>(T data) async =>
      (data, message: 'ok', success: true);

  ({
    String category,
    (int count, {String unit, bool isMetric}) measurement
  }) getComplexData() =>
      (category: 'test', measurement: (10, unit: 'kg', isMetric: true));

  Stream<(String, {DateTime timestamp, Map<String, dynamic> metadata})>
      getEventStream() => Stream.empty();
}
