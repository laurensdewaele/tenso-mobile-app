import 'dart:convert';

import 'package:app/models/models.dart';
import 'package:app/models/serializers.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'history.model.g.dart';

abstract class History implements Built<History, HistoryBuilder> {
  static Serializer<History> get serializer => _$historySerializer;

  BuiltList<ExecutionEvent> get history;
  int get timeUnderTensionMs => _calculateTimeUnderTensionMs();
  int get timeUnderTensionS =>
      Duration(milliseconds: timeUnderTensionMs).inSeconds;

  int _calculateTimeUnderTensionMs() {
    final List<int> _times = history
        .toList()
        .where((ExecutionEvent e) =>
            e.executionEventType == ExecutionEventType.hangTimer)
        .map((e) => e.elapsedMs)
        .toList();

    return _times.fold(0, (previous, current) => previous + current);
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
