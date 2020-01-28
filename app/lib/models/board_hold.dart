import 'dart:convert';
import 'dart:ui';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:app/models/hold_type.dart';
import 'package:app/models/serializers.dart';

part 'board_hold.g.dart';

abstract class BoardHold implements Built<BoardHold, BoardHoldBuilder> {
  static Serializer<BoardHold> get serializer => _$boardHoldSerializer;

  int get position;
  Rect get rect;
  HoldType get holdType;
  int get maxAllowedFingers;
  Size get boardSize;
  @nullable
  double get sloperDegrees;
  @nullable
  double get pocketDepth;
  double get dxHangAnchor;
  double get dyHangAnchor;
  Rect get relativeRect {
    return Rect.fromLTWH(
        rect.left / boardSize.width,
        rect.top / boardSize.height,
        rect.width / boardSize.width,
        rect.height / boardSize.height);
  }

  double get dxRelativeHangAnchor => dxHangAnchor / boardSize.width;
  double get dyRelativeHangAnchor => dyHangAnchor / boardSize.height;

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
