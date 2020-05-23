// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'execution_event_type.model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ExecutionEventType _$stopwatchRestTimer =
    const ExecutionEventType._('stopwatchRestTimer');
const ExecutionEventType _$countdownRestTimer =
    const ExecutionEventType._('countdownRestTimer');
const ExecutionEventType _$pauseTimer =
    const ExecutionEventType._('pauseTimer');
const ExecutionEventType _$preparationTimer =
    const ExecutionEventType._('preparationTimer');
const ExecutionEventType _$hangTimer = const ExecutionEventType._('hangTimer');
const ExecutionEventType _$stopEvent = const ExecutionEventType._('stopEvent');
const ExecutionEventType _$skipEvent = const ExecutionEventType._('skipEvent');
const ExecutionEventType _$resumeEvent =
    const ExecutionEventType._('resumeEvent');
const ExecutionEventType _$pauseEvent =
    const ExecutionEventType._('pauseEvent');
const ExecutionEventType _$readyEvent =
    const ExecutionEventType._('readyEvent');
const ExecutionEventType _$editHangsEvent =
    const ExecutionEventType._('editHangsEvent');
const ExecutionEventType _$editHangsTimer =
    const ExecutionEventType._('editHangsTimer');
const ExecutionEventType _$editHangsDoneEvent =
    const ExecutionEventType._('editHangsDoneEvent');

ExecutionEventType _$stValueOf(String name) {
  switch (name) {
    case 'stopwatchRestTimer':
      return _$stopwatchRestTimer;
    case 'countdownRestTimer':
      return _$countdownRestTimer;
    case 'pauseTimer':
      return _$pauseTimer;
    case 'preparationTimer':
      return _$preparationTimer;
    case 'hangTimer':
      return _$hangTimer;
    case 'stopEvent':
      return _$stopEvent;
    case 'skipEvent':
      return _$skipEvent;
    case 'resumeEvent':
      return _$resumeEvent;
    case 'pauseEvent':
      return _$pauseEvent;
    case 'readyEvent':
      return _$readyEvent;
    case 'editHangsEvent':
      return _$editHangsEvent;
    case 'editHangsTimer':
      return _$editHangsTimer;
    case 'editHangsDoneEvent':
      return _$editHangsDoneEvent;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<ExecutionEventType> _$stValues =
    new BuiltSet<ExecutionEventType>(const <ExecutionEventType>[
  _$stopwatchRestTimer,
  _$countdownRestTimer,
  _$pauseTimer,
  _$preparationTimer,
  _$hangTimer,
  _$stopEvent,
  _$skipEvent,
  _$resumeEvent,
  _$pauseEvent,
  _$readyEvent,
  _$editHangsEvent,
  _$editHangsTimer,
  _$editHangsDoneEvent,
]);

Serializer<ExecutionEventType> _$executionEventTypeSerializer =
    new _$ExecutionEventTypeSerializer();

class _$ExecutionEventTypeSerializer
    implements PrimitiveSerializer<ExecutionEventType> {
  @override
  final Iterable<Type> types = const <Type>[ExecutionEventType];
  @override
  final String wireName = 'ExecutionEventType';

  @override
  Object serialize(Serializers serializers, ExecutionEventType object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  ExecutionEventType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ExecutionEventType.valueOf(serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
