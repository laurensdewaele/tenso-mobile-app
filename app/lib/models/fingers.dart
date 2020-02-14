import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:app/models/serializers.dart';

part 'fingers.g.dart';

abstract class Fingers implements Built<Fingers, FingersBuilder> {
  static Serializer<Fingers> get serializer => _$fingersSerializer;

  bool get pinky;
  bool get ring;
  bool get middle;
  bool get index;
  bool get thumb;
  int get count;

  factory Fingers([void Function(FingersBuilder) updates]) = _$Fingers;
  Fingers._();

  String toJson() {
    return json.encode(serializers.serializeWith(Fingers.serializer, this));
  }

  static Fingers fromJson(String jsonString) {
    return serializers.deserializeWith(
        Fingers.serializer, json.decode(jsonString));
  }
}
