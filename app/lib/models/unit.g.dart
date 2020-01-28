// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Unit _$imperial = const Unit._('imperial');
const Unit _$metric = const Unit._('metric');

Unit _$stValueOf(String name) {
  switch (name) {
    case 'imperial':
      return _$imperial;
    case 'metric':
      return _$metric;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<Unit> _$stValues = new BuiltSet<Unit>(const <Unit>[
  _$imperial,
  _$metric,
]);

Serializer<Unit> _$unitSerializer = new _$UnitSerializer();

class _$UnitSerializer implements PrimitiveSerializer<Unit> {
  @override
  final Iterable<Type> types = const <Type>[Unit];
  @override
  final String wireName = 'Unit';

  @override
  Object serialize(Serializers serializers, Unit object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  Unit deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Unit.valueOf(serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
