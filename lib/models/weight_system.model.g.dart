// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weight_system.model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const WeightSystem _$imperial = const WeightSystem._('imperial');
const WeightSystem _$metric = const WeightSystem._('metric');

WeightSystem _$stValueOf(String name) {
  switch (name) {
    case 'imperial':
      return _$imperial;
    case 'metric':
      return _$metric;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<WeightSystem> _$stValues =
    new BuiltSet<WeightSystem>(const <WeightSystem>[
  _$imperial,
  _$metric,
]);

Serializer<WeightSystem> _$weightSystemSerializer =
    new _$WeightSystemSerializer();

class _$WeightSystemSerializer implements PrimitiveSerializer<WeightSystem> {
  @override
  final Iterable<Type> types = const <Type>[WeightSystem];
  @override
  final String wireName = 'WeightSystem';

  @override
  Object serialize(Serializers serializers, WeightSystem object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  WeightSystem deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      WeightSystem.valueOf(serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
