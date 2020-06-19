// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sequence_timer_type.model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const SequenceTimerType _$variableRestTimer =
    const SequenceTimerType._('variableRestTimer');
const SequenceTimerType _$fixedRestTimer =
    const SequenceTimerType._('fixedRestTimer');
const SequenceTimerType _$preparationTimer =
    const SequenceTimerType._('preparationTimer');
const SequenceTimerType _$hangTimer = const SequenceTimerType._('hangTimer');

SequenceTimerType _$stValueOf(String name) {
  switch (name) {
    case 'variableRestTimer':
      return _$variableRestTimer;
    case 'fixedRestTimer':
      return _$fixedRestTimer;
    case 'preparationTimer':
      return _$preparationTimer;
    case 'hangTimer':
      return _$hangTimer;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<SequenceTimerType> _$stValues =
    new BuiltSet<SequenceTimerType>(const <SequenceTimerType>[
  _$variableRestTimer,
  _$fixedRestTimer,
  _$preparationTimer,
  _$hangTimer,
]);

Serializer<SequenceTimerType> _$sequenceTimerTypeSerializer =
    new _$SequenceTimerTypeSerializer();

class _$SequenceTimerTypeSerializer
    implements PrimitiveSerializer<SequenceTimerType> {
  @override
  final Iterable<Type> types = const <Type>[SequenceTimerType];
  @override
  final String wireName = 'SequenceTimerType';

  @override
  Object serialize(Serializers serializers, SequenceTimerType object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  SequenceTimerType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      SequenceTimerType.valueOf(serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
