## 0.4.0
- Object methods are now forwarded even if they are not overridden
  - still respects the global or local settings for overriding
- Make decorator `==` method transparent by forwarding to the components `==` if possible
- Fix value equality issue where 2 generated decorators with the same instance could be considered **not** equal

## 0.3.0
- Added annotation-level forwarding support through `@Decorator()` constructor parameters

## 0.2.0+1
  - Fix README pub package shield to point to `decorator_annotation` instead of `decorator_gen`

## 0.2.0
  - Require `analyzer: ^7.4.0`
  - Require `build: ^3.0.0`
  - Require `source_gen: ^3.0.0` 
  - Fix deprecation warnings

## 0.1.1
  - Fix unary- operator generation for `@Decorator()` classes
  - increase test coverage

## 0.1.0
  - Generate decorator classes using the `@Decorator()` annotation
  - Support for generics, mixins, operators, parameters, records, properties
  - forward_object_method options to control generation of `toString`, `==`, `hashCode`, `runtimeType`, and `noSuchMethod`
