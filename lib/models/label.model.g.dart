// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'label.model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Label _$black = const Label._('black');
const Label _$red = const Label._('red');
const Label _$orange = const Label._('orange');
const Label _$yellow = const Label._('yellow');
const Label _$turquoise = const Label._('turquoise');
const Label _$blue = const Label._('blue');
const Label _$purple = const Label._('purple');

Label _$stValueOf(String name) {
  switch (name) {
    case 'black':
      return _$black;
    case 'red':
      return _$red;
    case 'orange':
      return _$orange;
    case 'yellow':
      return _$yellow;
    case 'turquoise':
      return _$turquoise;
    case 'blue':
      return _$blue;
    case 'purple':
      return _$purple;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<Label> _$stValues = new BuiltSet<Label>(const <Label>[
  _$black,
  _$red,
  _$orange,
  _$yellow,
  _$turquoise,
  _$blue,
  _$purple,
]);

Serializer<Label> _$labelSerializer = new _$LabelSerializer();

class _$LabelSerializer implements PrimitiveSerializer<Label> {
  @override
  final Iterable<Type> types = const <Type>[Label];
  @override
  final String wireName = 'Label';

  @override
  Object serialize(Serializers serializers, Label object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  Label deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Label.valueOf(serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
