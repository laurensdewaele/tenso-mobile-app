import 'dart:convert';

import 'package:app/models/serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'logged_metrics.model.g.dart';

abstract class LoggedMetrics
    implements Built<LoggedMetrics, LoggedMetricsBuilder> {
  static Serializer<LoggedMetrics> get serializer => _$loggedMetricsSerializer;

  int get duration;
  double get addedWeight;
  int get currentHang;

  factory LoggedMetrics([void Function(LoggedMetricsBuilder) updates]) =
      _$LoggedMetrics;
  LoggedMetrics._();

  String toJson() {
    return json
        .encode(serializers.serializeWith(LoggedMetrics.serializer, this));
  }

  static LoggedMetrics fromJson(String jsonString) {
    return serializers.deserializeWith(
        LoggedMetrics.serializer, json.decode(jsonString));
  }
}
