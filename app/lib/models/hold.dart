import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:app/models/board_hold.dart';
import 'package:app/models/grip.dart';
import 'package:app/models/hand_hold.dart';
import 'package:app/models/serializers.dart';

part 'hold.g.dart';

abstract class Hold implements Built<Hold, HoldBuilder> {
  static Serializer<Hold> get serializer => _$holdSerializer;

  Grip get leftGrip;
  Grip get rightGrip;
  HandHold get handHold;
  BoardHold get leftGripBoardHold;
  BoardHold get rightGripBoardHold;
  int get repetitions;
  int get restBetweenRepetitions;
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
