import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:tenso_app/models/serializers.dart';

part 'feedback.dto.g.dart';

abstract class Feedback implements Built<Feedback, FeedbackBuilder> {
  static Serializer<Feedback> get serializer => _$feedbackSerializer;

  String get type;
  String get message;
  @nullable
  String get email;

  factory Feedback([void Function(FeedbackBuilder) updates]) = _$Feedback;
  Feedback._();

  String toJson() {
    return json.encode(serializers.serializeWith(Feedback.serializer, this));
  }

  static Feedback fromJson(String jsonString) {
    return serializers.deserializeWith(
        Feedback.serializer, json.decode(jsonString));
  }
}
