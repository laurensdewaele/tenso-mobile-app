import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'label.g.dart';

class Label extends EnumClass {
  static Serializer<Label> get serializer => _$labelSerializer;

  static const Label black = _$black;
  static const Label red = _$red;
  static const Label orange = _$orange;
  static const Label yellow = _$yellow;
  static const Label turquoise = _$turquoise;
  static const Label blue = _$blue;
  static const Label purple = _$purple;

  const Label._(String name) : super(name);

  static BuiltSet<Label> get values => _$stValues;
  static Label valueOf(String name) => _$stValueOf(name);
}
