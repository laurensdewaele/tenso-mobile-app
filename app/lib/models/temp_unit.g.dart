// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'temp_unit.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const TempUnit _$fahrenheit = const TempUnit._('fahrenheit');
const TempUnit _$celsius = const TempUnit._('celsius');

TempUnit _$stValueOf(String name) {
  switch (name) {
    case 'fahrenheit':
      return _$fahrenheit;
    case 'celsius':
      return _$celsius;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<TempUnit> _$stValues = new BuiltSet<TempUnit>(const <TempUnit>[
  _$fahrenheit,
  _$celsius,
]);

Serializer<TempUnit> _$tempUnitSerializer = new _$TempUnitSerializer();

class _$TempUnitSerializer implements PrimitiveSerializer<TempUnit> {
  @override
  final Iterable<Type> types = const <Type>[TempUnit];
  @override
  final String wireName = 'TempUnit';

  @override
  Object serialize(Serializers serializers, TempUnit object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  TempUnit deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      TempUnit.valueOf(serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
