import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'grade_type.g.dart';

class GradeType extends EnumClass {
  static Serializer<GradeType> get serializer => _$gradeTypeSerializer;

  static const GradeType sportFrench = _$sportFrench;
  static const GradeType sportUSA = _$sportUSA;
  static const GradeType boulderVScale = _$boulderVScale;
  static const GradeType boulderFont = _$boulderFont;

  const GradeType._(String name) : super(name);

  static BuiltSet<GradeType> get values => _$stValues;
  static GradeType valueOf(String name) => _$stValueOf(name);
}
