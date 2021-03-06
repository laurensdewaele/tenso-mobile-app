import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/models/serializers.dart';

part 'sequence_timer_log.model.g.dart';

abstract class SequenceTimerLog
    implements Built<SequenceTimerLog, SequenceTimerLogBuilder> {
  static Serializer<SequenceTimerLog> get serializer =>
      _$sequenceTimerLogSerializer;

  int get index;
  SequenceTimerType get type;
  int get originalDurationS;
  double get effectiveDurationMs;
  double get originalAddedWeight;
  double get effectiveAddedWeight;
  WeightSystem get weightSystem;
  bool get skipped;
  bool get stopped;
  int get groupIndex;

  double get originalDurationMs => (originalDurationS * 1000).toDouble();

  factory SequenceTimerLog([void Function(SequenceTimerLogBuilder) updates]) =
      _$SequenceTimerLog;
  SequenceTimerLog._();

  String toJson() {
    return json
        .encode(serializers.serializeWith(SequenceTimerLog.serializer, this));
  }

  static SequenceTimerLog fromJson(String jsonString) {
    return serializers.deserializeWith(
        SequenceTimerLog.serializer, json.decode(jsonString));
  }
}
