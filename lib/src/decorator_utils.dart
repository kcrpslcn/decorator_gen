class DecoratorUtils {
  static const String _toString = 'toString';
  static const String _equals = '==';
  static const String _hashCode = 'hashCode';
  static const String _runtimeType = 'runtimeType';
  static const String _noSuchMethod = 'noSuchMethod';

  late final Map<String, bool> methodNameToIsForwarding;

  DecoratorUtils({
    Map<String, bool> methodNameToIsForwarding = const {},
  }) {
    this.methodNameToIsForwarding = methodNameToIsForwarding;
  }

  /// Converts a class name to camelCase for field naming
  static String toCamelCase(String className) {
    if (className.isEmpty) return className;
    return className[0].toLowerCase() + className.substring(1);
  }

  /// Checks if a method name is an Object method
  bool isObjectMethod(String methodName) {
    return methodName == _toString ||
        methodName == _equals ||
        methodName == _hashCode ||
        methodName == _runtimeType ||
        methodName == _noSuchMethod;
  }

  /// Checks if an Object method should be forwarded based on configuration

  /// Gets all Object method names that are configured to be forwarded
  List<String> getObjectMethodsToForward() {
    return const [_toString, _equals, _noSuchMethod, _hashCode, _runtimeType]
        .where(_shouldForwardObjectMethod)
        .toList();
  }

  bool _shouldForwardObjectMethod(String methodName) {
    return methodNameToIsForwarding[methodName] ??
        _getDefaultForwarding(methodName);
  }

  /// Gets the default forwarding behavior for Object methods
  bool _getDefaultForwarding(String methodName) {
    switch (methodName) {
      case _toString:
      case _equals:
      case _hashCode:
        return true;
      case _runtimeType:
      case _noSuchMethod:
        return false;
      default:
        return false;
    }
  }
}
