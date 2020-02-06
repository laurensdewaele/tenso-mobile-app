import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:app/models/board_hold.dart';
import 'package:app/models/serializers.dart';

part 'package:app/models/board.g.dart';

abstract class Board implements Built<Board, BoardBuilder> {
  static Serializer<Board> get serializer => _$boardSerializer;

  String get manufacturer;
  String get model;
  double get width;
  double get height;
  double get aspectRatio;
  BuiltList<BoardHold> get boardHolds;
  double get handToBoardHeightRatio;
  String get assetSrc;
  BoardHold get defaultLeftGripHold;
  BoardHold get defaultRightGripHold;

  factory Board([void Function(BoardBuilder) updates]) = _$Board;
  Board._();

  String toJson() {
    return json.encode(serializers.serializeWith(Board.serializer, this));
  }

  static Board fromJson(String jsonString) {
    return serializers.deserializeWith(
        Board.serializer, json.decode(jsonString));
  }
}
