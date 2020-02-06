import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:app/models/fingers.dart';
import 'package:app/models/hand_type.dart';
import 'package:app/models/serializers.dart';

part 'package:app/models/grip.g.dart';

abstract class Grip implements Built<Grip, GripBuilder> {
  static Serializer<Grip> get serializer => _$gripSerializer;

  HandType get handType;
  Fingers get fingers;
  bool get crimped;
  String get assetSrc;
  String get name;
  String get description;
  double get dxHangAnchor;
  double get dyHangAnchor;
  double get dxRelativeHangAnchor => dxHangAnchor / assetWidth;
  double get dyRelativeHangAnchor => dyHangAnchor / assetHeight;
  double get assetWidth;
  double get assetHeight;
  double get assetAspectRatio => assetWidth / assetHeight;

  factory Grip([void Function(GripBuilder) updates]) = _$Grip;
  Grip._();

  String toJson() {
    return json.encode(serializers.serializeWith(Grip.serializer, this));
  }

  static Grip fromJson(String jsonString) {
    return serializers.deserializeWith(
        Grip.serializer, json.decode(jsonString));
  }
}
