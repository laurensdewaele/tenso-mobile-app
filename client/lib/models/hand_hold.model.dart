import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hand_hold.model.g.dart';

class HandHold extends EnumClass {
  static Serializer<HandHold> get serializer => _$handHoldSerializer;

  static const HandHold twoHanded = _$twoHanded;
  static const HandHold oneHandedLeft = _$oneHandedLeft;
  static const HandHold oneHandedRight = _$oneHandedRight;

  const HandHold._(String name) : super(name);

  static BuiltSet<HandHold> get values => _$stValues;
  static HandHold valueOf(String name) => _$stValueOf(name);
}
