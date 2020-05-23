import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'execution_event_type.model.g.dart';

class ExecutionEventType extends EnumClass {
  static Serializer<ExecutionEventType> get serializer =>
      _$executionEventTypeSerializer;

  static const ExecutionEventType stopwatchRestTimer = _$stopwatchRestTimer;
  static const ExecutionEventType countdownRestTimer = _$countdownRestTimer;
  static const ExecutionEventType pauseTimer = _$pauseTimer;
  static const ExecutionEventType preparationTimer = _$preparationTimer;
  static const ExecutionEventType hangTimer = _$hangTimer;
  static const ExecutionEventType stopEvent = _$stopEvent;
  static const ExecutionEventType skipEvent = _$skipEvent;
  static const ExecutionEventType resumeEvent = _$resumeEvent;
  static const ExecutionEventType pauseEvent = _$pauseEvent;
  static const ExecutionEventType readyEvent = _$readyEvent;
  static const ExecutionEventType editHangsEvent = _$editHangsEvent;
  static const ExecutionEventType editHangsTimer = _$editHangsTimer;
  static const ExecutionEventType editHangsDoneEvent = _$editHangsDoneEvent;

  const ExecutionEventType._(String name) : super(name);

  static BuiltSet<ExecutionEventType> get values => _$stValues;
  static ExecutionEventType valueOf(String name) => _$stValueOf(name);
}
