import 'dart:convert';

import 'package:app/models/models.dart';
import 'package:app/models/serializers.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'board.model.g.dart';

abstract class Board implements Built<Board, BoardBuilder> {
  static Serializer<Board> get serializer => _$boardSerializer;

  String get id;
  bool get custom;
  @nullable
  BuiltList<CustomBoardHoldImage> get customBoardHoldImages;
  @nullable
  String get manufacturer;
  String get model;
  String get imageAsset;
  double get aspectRatio;
  double get height;
  double get width;
  double get handToBoardHeightRatio;
  BuiltList<BoardHold> get boardHolds;
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
