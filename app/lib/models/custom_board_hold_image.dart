import 'dart:convert';

import 'package:app/models/models.dart';
import 'package:app/models/serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'custom_board_hold_image.g.dart';

abstract class CustomBoardHoldImage
    implements Built<CustomBoardHoldImage, CustomBoardHoldImageBuilder> {
  static Serializer<CustomBoardHoldImage> get serializer =>
      _$customBoardHoldImageSerializer;

  @nullable
  int get position;
  int get widthFactor;
  HoldType get type;
  double get topYPercent;
  double get heightPercent;
  double get widthPercent;
  double get scale;
  String get imageAsset;

  factory CustomBoardHoldImage(
          [void Function(CustomBoardHoldImageBuilder) updates]) =
      _$CustomBoardHoldImage;
  CustomBoardHoldImage._();

  String toJson() {
    return json.encode(
        serializers.serializeWith(CustomBoardHoldImage.serializer, this));
  }

  static CustomBoardHoldImage fromJson(String jsonString) {
    return serializers.deserializeWith(
        CustomBoardHoldImage.serializer, json.decode(jsonString));
  }
}
