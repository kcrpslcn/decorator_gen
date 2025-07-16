class DecoratorUtils {
  static const String _toString = 'toString';
  static const String _equals = '==';
  static const String _hashCode = 'hashCode';
  static const String _runtimeType = 'runtimeType';
  static const String _noSuchMethod = 'noSuchMethod';

  late final Map<String, bool> objectMethodNameToIsObjectMethod;

  DecoratorUtils({
    Map<String, bool> methodNameToIsForwarding = const {},
  }) {
    // Initialize default values for Object methods if not provided
    this.objectMethodNameToIsObjectMethod =
        Map.of(methodNameToIsForwarding.map((e, v) => MapEntry(e, !v)))
          ..putIfAbsent(_toString, () => false)
          ..putIfAbsent(_equals, () => false)
          ..putIfAbsent(_hashCode, () => false)
          ..putIfAbsent(_runtimeType, () => true)
          ..putIfAbsent(_noSuchMethod, () => true);
  }

  /// Checks if a method should be considered an Object method
  bool isObjectMethod(String methodName) {
    return objectMethodNameToIsObjectMethod[methodName] ?? false;
  }

  /// Converts a class name to camelCase for field naming
  static String toCamelCase(String className) {
    if (className.isEmpty) return className;
    return className[0].toLowerCase() + className.substring(1);
  }
}
