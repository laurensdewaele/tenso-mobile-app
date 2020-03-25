// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weight_unit.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const WeightUnit _$imperial = const WeightUnit._('imperial');
const WeightUnit _$metric = const WeightUnit._('metric');

WeightUnit _$stValueOf(String name) {
  switch (name) {
    case 'imperial':
      return _$imperial;
    case 'metric':
      return _$metric;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<WeightUnit> _$stValues =
    new BuiltSet<WeightUnit>(const <WeightUnit>[
  _$imperial,
  _$metric,
]);

Serializer<WeightUnit> _$weightUnitSerializer = new _$WeightUnitSerializer();

class _$WeightUnitSerializer implements PrimitiveSerializer<WeightUnit> {
  @override
  final Iterable<Type> types = const <Type>[WeightUnit];
  @override
  final String wireName = 'WeightUnit';

  @override
  Object serialize(Serializers serializers, WeightUnit object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  WeightUnit deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      WeightUnit.valueOf(serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
