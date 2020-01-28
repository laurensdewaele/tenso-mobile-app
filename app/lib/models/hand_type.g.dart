// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hand_type.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const HandType _$leftHand = const HandType._('leftHand');
const HandType _$rightHand = const HandType._('rightHand');

HandType _$stValueOf(String name) {
  switch (name) {
    case 'leftHand':
      return _$leftHand;
    case 'rightHand':
      return _$rightHand;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<HandType> _$stValues = new BuiltSet<HandType>(const <HandType>[
  _$leftHand,
  _$rightHand,
]);

Serializer<HandType> _$handTypeSerializer = new _$HandTypeSerializer();

class _$HandTypeSerializer implements PrimitiveSerializer<HandType> {
  @override
  final Iterable<Type> types = const <Type>[HandType];
  @override
  final String wireName = 'HandType';

  @override
  Object serialize(Serializers serializers, HandType object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  HandType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      HandType.valueOf(serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
