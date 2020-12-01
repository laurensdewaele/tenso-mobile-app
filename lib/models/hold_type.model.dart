import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hold_type.model.g.dart';

class HoldType extends EnumClass {
  static Serializer<HoldType> get serializer => _$holdTypeSerializer;

  static const HoldType pinchBlock = _$pinchBlock;
  static const HoldType sloper = _$sloper;
  static const HoldType jug = _$jug;
  static const HoldType pocket = _$pocket;
  static const HoldType edge = _$edge;
  static const HoldType slopingEdge = _$slopingEdge;
  static const HoldType slopingPocket = _$slopingPocket;

  @override
  String toString() {
    switch (name) {
      case 'pinchBlock':
        return 'pinch block';
      case 'sloper':
        return 'sloper';
      case 'jug':
        return 'jug';
      case 'pocket':
        return 'pocket';
      case 'edge':
        return 'edge';
      case 'slopingEdge':
        return 'sloping edge';
      case 'slopingPocket':
        return 'sloping pocket';
      default:
        throw new ArgumentError(name);
    }
  }

  const HoldType._(String name) : super(name);

  static BuiltSet<HoldType> get values => _$stValues;
  static HoldType valueOf(String name) => _$stValueOf(name);
}
