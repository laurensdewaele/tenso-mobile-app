import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:app/models/models.dart';
import 'package:app/models/serializers.dart';

part 'board_hold.g.dart';

abstract class BoardHold implements Built<BoardHold, BoardHoldBuilder> {
  static Serializer<BoardHold> get serializer => _$boardHoldSerializer;

  int get position;
  HoldType get holdType;
  int get maxAllowedFingers;
  @nullable
  double get sloperDegrees;
  @nullable
  double get pocketDepth;
  double get dxRelativeHangAnchor;
  double get dyRelativeHangAnchor;
  double get relativeLeft;
  double get relativeTop;
  double get relativeWidth;
  double get relativeHeight;

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
