import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:app/models/models.dart';
import 'package:app/models/serializers.dart';

part 'hold.g.dart';

abstract class Hold implements Built<Hold, HoldBuilder> {
  static Serializer<Hold> get serializer => _$holdSerializer;

  @nullable
  Grip get leftGrip;

  @nullable
  Grip get rightGrip;

  HandHold get handHold;

  @nullable
  BoardHold get leftGripBoardHold;

  @nullable
  BoardHold get rightGripBoardHold;

  int get repetitions;

  @nullable
  int get countdownDuration;

  int get hangTime;
  double get addedWeight;

  factory Hold([void Function(HoldBuilder) updates]) = _$Hold;

  Hold._();

  String toJson() {
    return json.encode(serializers.serializeWith(Hold.serializer, this));
  }

  static Hold fromJson(String jsonString) {
    return serializers.deserializeWith(
        Hold.serializer, json.decode(jsonString));
  }
}
