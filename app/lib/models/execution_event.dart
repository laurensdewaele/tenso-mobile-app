import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:app/models/models.dart';
import 'package:app/models/serializers.dart';

part 'execution_event.g.dart';

abstract class ExecutionEvent
    implements Built<ExecutionEvent, ExecutionEventBuilder> {
  static Serializer<ExecutionEvent> get serializer =>
      _$executionEventSerializer;

  ExecutionEventType get type;
  @nullable
  int get elapsed;
  @nullable
  int get targetDuration;
  @nullable
  double get completionPercentage => _calculateCompletionPercentage();

  double _calculateCompletionPercentage() {
    if (elapsed != null && targetDuration != null && targetDuration > 0) {
      return elapsed / targetDuration * 100;
    }
    return null;
  }

  factory ExecutionEvent([void Function(ExecutionEventBuilder) updates]) =
      _$ExecutionEvent;
  ExecutionEvent._();

  String toJson() {
    return json
        .encode(serializers.serializeWith(ExecutionEvent.serializer, this));
  }

  static ExecutionEvent fromJson(String jsonString) {
    return serializers.deserializeWith(
        ExecutionEvent.serializer, json.decode(jsonString));
  }
}