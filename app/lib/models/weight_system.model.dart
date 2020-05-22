import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'weight_system.model.g.dart';

class WeightSystem extends EnumClass {
  static Serializer<WeightSystem> get serializer => _$weightSystemSerializer;

  static const WeightSystem imperial = _$imperial;
  static const WeightSystem metric = _$metric;

  String get unit {
    switch (name) {
      case 'imperial':
        return 'lbs';
      case 'metric':
        return 'kg';
      default:
        return '';
    }
  }

  const WeightSystem._(String name) : super(name);

  static BuiltSet<WeightSystem> get values => _$stValues;
  static WeightSystem valueOf(String name) => _$stValueOf(name);
}
