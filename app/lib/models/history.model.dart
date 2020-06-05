import 'dart:convert';

import 'package:app/models/models.dart';
import 'package:app/models/serializers.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'history.model.g.dart';

abstract class History implements Built<History, HistoryBuilder> {
  static Serializer<History> get serializer => _$historySerializer;

  BuiltList<SequenceTimerLog> get sequenceTimerLogs;
  double get timerUnderTensionMs => _calculateTimeUnderTensionMs();

  double _calculateTimeUnderTensionMs() {
    final _hangSequences = sequenceTimerLogs
        .toList()
        .where((SequenceTimerLog t) => t.type == SequenceTimerType.hangTimer);

    return _hangSequences
        .map((SequenceTimerLog t) => t.effectiveDurationMs)
        .fold(0, (previous, current) => previous + current);
  }

  factory History([void Function(HistoryBuilder) updates]) = _$History;
  History._();

  String toJson() {
    return json.encode(serializers.serializeWith(History.serializer, this));
  }

  static History fromJson(String jsonString) {
    return serializers.deserializeWith(
        History.serializer, json.decode(jsonString));
  }
}
