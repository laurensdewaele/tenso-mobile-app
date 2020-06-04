import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'sequence_timer_type.model.g.dart';

class SequenceTimerType extends EnumClass {
  static Serializer<SequenceTimerType> get serializer =>
      _$sequenceTimerTypeSerializer;

  static const SequenceTimerType stopwatchRestTimer = _$stopwatchRestTimer;
  static const SequenceTimerType countdownRestTimer = _$countdownRestTimer;
  static const SequenceTimerType preparationTimer = _$preparationTimer;
  static const SequenceTimerType hangTimer = _$hangTimer;

  const SequenceTimerType._(String name) : super(name);

  static BuiltSet<SequenceTimerType> get values => _$stValues;
  static SequenceTimerType valueOf(String name) => _$stValueOf(name);
}
