// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grip.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Grip> _$gripSerializer = new _$GripSerializer();

class _$GripSerializer implements StructuredSerializer<Grip> {
  @override
  final Iterable<Type> types = const [Grip, _$Grip];
  @override
  final String wireName = 'Grip';

  @override
  Iterable<Object> serialize(Serializers serializers, Grip object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'handType',
      serializers.serialize(object.handType,
          specifiedType: const FullType(HandType)),
      'fingers',
      serializers.serialize(object.fingers,
          specifiedType: const FullType(Fingers)),
      'crimped',
      serializers.serialize(object.crimped,
          specifiedType: const FullType(bool)),
      'imageAsset',
      serializers.serialize(object.imageAsset,
          specifiedType: const FullType(String)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'description',
      serializers.serialize(object.description,
          specifiedType: const FullType(String)),
      'hangAnchorX',
      serializers.serialize(object.hangAnchorX,
          specifiedType: const FullType(double)),
      'hangAnchorY',
      serializers.serialize(object.hangAnchorY,
          specifiedType: const FullType(double)),
      'assetWidth',
      serializers.serialize(object.assetWidth,
          specifiedType: const FullType(double)),
      'assetHeight',
      serializers.serialize(object.assetHeight,
          specifiedType: const FullType(double)),
    ];

    return result;
  }

  @override
  Grip deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GripBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'handType':
          result.handType = serializers.deserialize(value,
              specifiedType: const FullType(HandType)) as HandType;
          break;
        case 'fingers':
          result.fingers.replace(serializers.deserialize(value,
              specifiedType: const FullType(Fingers)) as Fingers);
          break;
        case 'crimped':
          result.crimped = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'imageAsset':
          result.imageAsset = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'hangAnchorX':
          result.hangAnchorX = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'hangAnchorY':
          result.hangAnchorY = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'assetWidth':
          result.assetWidth = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'assetHeight':
          result.assetHeight = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
      }
    }

    return result.build();
  }
}

class _$Grip extends Grip {
  @override
  final HandType handType;
  @override
  final Fingers fingers;
  @override
  final bool crimped;
  @override
  final String imageAsset;
  @override
  final String name;
  @override
  final String description;
  @override
  final double hangAnchorX;
  @override
  final double hangAnchorY;
  @override
  final double assetWidth;
  @override
  final double assetHeight;

  factory _$Grip([void Function(GripBuilder) updates]) =>
      (new GripBuilder()..update(updates)).build();

  _$Grip._(
      {this.handType,
      this.fingers,
      this.crimped,
      this.imageAsset,
      this.name,
      this.description,
      this.hangAnchorX,
      this.hangAnchorY,
      this.assetWidth,
      this.assetHeight})
      : super._() {
    if (handType == null) {
      throw new BuiltValueNullFieldError('Grip', 'handType');
    }
    if (fingers == null) {
      throw new BuiltValueNullFieldError('Grip', 'fingers');
    }
    if (crimped == null) {
      throw new BuiltValueNullFieldError('Grip', 'crimped');
    }
    if (imageAsset == null) {
      throw new BuiltValueNullFieldError('Grip', 'imageAsset');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('Grip', 'name');
    }
    if (description == null) {
      throw new BuiltValueNullFieldError('Grip', 'description');
    }
    if (hangAnchorX == null) {
      throw new BuiltValueNullFieldError('Grip', 'hangAnchorX');
    }
    if (hangAnchorY == null) {
      throw new BuiltValueNullFieldError('Grip', 'hangAnchorY');
    }
    if (assetWidth == null) {
      throw new BuiltValueNullFieldError('Grip', 'assetWidth');
    }
    if (assetHeight == null) {
      throw new BuiltValueNullFieldError('Grip', 'assetHeight');
    }
  }

  @override
  Grip rebuild(void Function(GripBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GripBuilder toBuilder() => new GripBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Grip &&
        handType == other.handType &&
        fingers == other.fingers &&
        crimped == other.crimped &&
        imageAsset == other.imageAsset &&
        name == other.name &&
        description == other.description &&
        hangAnchorX == other.hangAnchorX &&
        hangAnchorY == other.hangAnchorY &&
        assetWidth == other.assetWidth &&
        assetHeight == other.assetHeight;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc($jc(0, handType.hashCode),
                                        fingers.hashCode),
                                    crimped.hashCode),
                                imageAsset.hashCode),
                            name.hashCode),
                        description.hashCode),
                    hangAnchorX.hashCode),
                hangAnchorY.hashCode),
            assetWidth.hashCode),
        assetHeight.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Grip')
          ..add('handType', handType)
          ..add('fingers', fingers)
          ..add('crimped', crimped)
          ..add('imageAsset', imageAsset)
          ..add('name', name)
          ..add('description', description)
          ..add('hangAnchorX', hangAnchorX)
          ..add('hangAnchorY', hangAnchorY)
          ..add('assetWidth', assetWidth)
          ..add('assetHeight', assetHeight))
        .toString();
  }
}

class GripBuilder implements Builder<Grip, GripBuilder> {
  _$Grip _$v;

  HandType _handType;
  HandType get handType => _$this._handType;
  set handType(HandType handType) => _$this._handType = handType;

  FingersBuilder _fingers;
  FingersBuilder get fingers => _$this._fingers ??= new FingersBuilder();
  set fingers(FingersBuilder fingers) => _$this._fingers = fingers;

  bool _crimped;
  bool get crimped => _$this._crimped;
  set crimped(bool crimped) => _$this._crimped = crimped;

  String _imageAsset;
  String get imageAsset => _$this._imageAsset;
  set imageAsset(String imageAsset) => _$this._imageAsset = imageAsset;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _description;
  String get description => _$this._description;
  set description(String description) => _$this._description = description;

  double _hangAnchorX;
  double get hangAnchorX => _$this._hangAnchorX;
  set hangAnchorX(double hangAnchorX) => _$this._hangAnchorX = hangAnchorX;

  double _hangAnchorY;
  double get hangAnchorY => _$this._hangAnchorY;
  set hangAnchorY(double hangAnchorY) => _$this._hangAnchorY = hangAnchorY;

  double _assetWidth;
  double get assetWidth => _$this._assetWidth;
  set assetWidth(double assetWidth) => _$this._assetWidth = assetWidth;

  double _assetHeight;
  double get assetHeight => _$this._assetHeight;
  set assetHeight(double assetHeight) => _$this._assetHeight = assetHeight;

  GripBuilder();

  GripBuilder get _$this {
    if (_$v != null) {
      _handType = _$v.handType;
      _fingers = _$v.fingers?.toBuilder();
      _crimped = _$v.crimped;
      _imageAsset = _$v.imageAsset;
      _name = _$v.name;
      _description = _$v.description;
      _hangAnchorX = _$v.hangAnchorX;
      _hangAnchorY = _$v.hangAnchorY;
      _assetWidth = _$v.assetWidth;
      _assetHeight = _$v.assetHeight;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Grip other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Grip;
  }

  @override
  void update(void Function(GripBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Grip build() {
    _$Grip _$result;
    try {
      _$result = _$v ??
          new _$Grip._(
              handType: handType,
              fingers: fingers.build(),
              crimped: crimped,
              imageAsset: imageAsset,
              name: name,
              description: description,
              hangAnchorX: hangAnchorX,
              hangAnchorY: hangAnchorY,
              assetWidth: assetWidth,
              assetHeight: assetHeight);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'fingers';
        fingers.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Grip', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
