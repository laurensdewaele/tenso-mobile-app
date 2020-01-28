// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hold_type.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const HoldType _$sloper = const HoldType._('sloper');
const HoldType _$pocket = const HoldType._('pocket');
const HoldType _$jug = const HoldType._('jug');
const HoldType _$roundedPocket = const HoldType._('roundedPocket');

HoldType _$stValueOf(String name) {
  switch (name) {
    case 'sloper':
      return _$sloper;
    case 'pocket':
      return _$pocket;
    case 'jug':
      return _$jug;
    case 'roundedPocket':
      return _$roundedPocket;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<HoldType> _$stValues = new BuiltSet<HoldType>(const <HoldType>[
  _$sloper,
  _$pocket,
  _$jug,
  _$roundedPocket,
]);

Serializer<HoldType> _$holdTypeSerializer = new _$HoldTypeSerializer();

class _$HoldTypeSerializer implements PrimitiveSerializer<HoldType> {
  @override
  final Iterable<Type> types = const <Type>[HoldType];
  @override
  final String wireName = 'HoldType';

  @override
  Object serialize(Serializers serializers, HoldType object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  HoldType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      HoldType.valueOf(serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
