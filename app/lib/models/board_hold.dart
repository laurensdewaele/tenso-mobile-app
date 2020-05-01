import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:app/models/models.dart';
import 'package:app/models/serializers.dart';

part 'board_hold.g.dart';

abstract class BoardHold implements Built<BoardHold, BoardHoldBuilder> {
  static Serializer<BoardHold> get serializer => _$boardHoldSerializer;

  int get position;
  HoldType get type;
  @nullable
  double get depth;
  @nullable
  int get supportedFingers;
  @nullable
  double get sloperDegrees;
  double get hangAnchorXPercent;
  double get hangAnchorYPercent;
  double get topLeftXPercent;
  double get topLeftYPercent;
  double get widthPercent;
  double get heightPercent;

  bool checkGripCompatibility(Grip grip) {
    return grip.fingers.count > supportedFingers ? false : true;
  }

  factory BoardHold([void Function(BoardHoldBuilder) updates]) = _$BoardHold;
  BoardHold._();

  String toJson() {
    return json.encode(serializers.serializeWith(BoardHold.serializer, this));
  }

  static BoardHold fromJson(String jsonString) {
    return serializers.deserializeWith(
        BoardHold.serializer, json.decode(jsonString));
  }
}
