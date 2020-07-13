// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hold_type.model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const HoldType _$pinchBlock = const HoldType._('pinchBlock');
const HoldType _$sloper = const HoldType._('sloper');
const HoldType _$jug = const HoldType._('jug');
const HoldType _$pocket = const HoldType._('pocket');
const HoldType _$edge = const HoldType._('edge');

HoldType _$stValueOf(String name) {
  switch (name) {
    case 'pinchBlock':
      return _$pinchBlock;
    case 'sloper':
      return _$sloper;
    case 'jug':
      return _$jug;
    case 'pocket':
      return _$pocket;
    case 'edge':
      return _$edge;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<HoldType> _$stValues = new BuiltSet<HoldType>(const <HoldType>[
  _$pinchBlock,
  _$sloper,
  _$jug,
  _$pocket,
  _$edge,
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
