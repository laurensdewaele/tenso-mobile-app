import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hand_type.g.dart';

class HandType extends EnumClass {
  static Serializer<HandType> get serializer => _$handTypeSerializer;

  static const HandType leftHand = _$leftHand;
  static const HandType rightHand = _$rightHand;

  const HandType._(String name) : super(name);

  static BuiltSet<HandType> get values => _$stValues;
  static HandType valueOf(String name) => _$stValueOf(name);
}
