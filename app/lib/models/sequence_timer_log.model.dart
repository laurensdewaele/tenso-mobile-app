import 'dart:convert';

import 'package:app/models/models.dart';
import 'package:app/models/serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'sequence_timer_log.model.g.dart';

abstract class SequenceTimerLog
    implements Built<SequenceTimerLog, SequenceTimerLogBuilder> {
  static Serializer<SequenceTimerLog> get serializer =>
      _$sequenceTimerLogSerializer;

  SequenceTimerType get type;
  int get duration;
  double get effectiveDurationMs;
  bool get skipped;
  bool get stopped;

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
