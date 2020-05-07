import 'dart:convert';
import 'dart:ui';

import 'package:app/models/models.dart';
import 'package:app/models/serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

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
  double get anchorLeftPercent;
  double get anchorTopPercent;
  double get leftPercent;
  double get topPercent;
  double get widthPercent;
  double get heightPercent;
  @nullable
  String get customBoardHoldImageId;
  bool get borderRadiusAll;
  @nullable
  double get topLeftBorderRadius;
  @nullable
  double get topRightBorderRadius;
  @nullable
  double get bottomRightBorderRadius;
  @nullable
  double get bottomLeftBorderRadius;

  Rect getRect({double boardWidth, double boardHeight}) {
    return Rect.fromLTWH(leftPercent * boardWidth, topPercent * boardHeight,
        widthPercent * boardWidth, heightPercent * boardHeight);
  }

  bool checkGripCompatibility(Grip grip) {
    if (supportedFingers == null) return true;
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
