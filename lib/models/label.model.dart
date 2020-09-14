import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter/cupertino.dart';
import 'package:tenso_app/styles/styles.dart' as styles;

part 'label.model.g.dart';

class Label extends EnumClass {
  static Serializer<Label> get serializer => _$labelSerializer;

  static const Label black = _$black;
  static const Label red = _$red;
  static const Label orange = _$orange;
  static const Label yellow = _$yellow;
  static const Label turquoise = _$turquoise;
  static const Label blue = _$blue;
  static const Label purple = _$purple;

  Color get color => styles.labelColors[name];

  @override
  String toString() => name;

  const Label._(String name) : super(name);

  static BuiltSet<Label> get values => _$stValues;
  static Label valueOf(String name) => _$stValueOf(name);
}
