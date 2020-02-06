import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'package:app/models/hold_type.g.dart';

class HoldType extends EnumClass {
  static Serializer<HoldType> get serializer => _$holdTypeSerializer;

  static const HoldType sloper = _$sloper;
  static const HoldType pocket = _$pocket;
  static const HoldType jug = _$jug;
  static const HoldType roundedPocket = _$roundedPocket;

  const HoldType._(String name) : super(name);

  static BuiltSet<HoldType> get values => _$stValues;
  static HoldType valueOf(String name) => _$stValueOf(name);
}
