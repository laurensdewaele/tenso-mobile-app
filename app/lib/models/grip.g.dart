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
      'assetSrc',
      serializers.serialize(object.assetSrc,
          specifiedType: const FullType(String)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'description',
      serializers.serialize(object.description,
          specifiedType: const FullType(String)),
      'dxHangAnchor',
      serializers.serialize(object.dxHangAnchor,
          specifiedType: const FullType(double)),
      'dyHangAnchor',
      serializers.serialize(object.dyHangAnchor,
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
        case 'assetSrc':
          result.assetSrc = serializers.deserialize(value,
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
        case 'dxHangAnchor':
          result.dxHangAnchor = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'dyHangAnchor':
          result.dyHangAnchor = serializers.deserialize(value,
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
  final String assetSrc;
  @override
  final String name;
  @override
  final String description;
  @override
  final double dxHangAnchor;
  @override
  final double dyHangAnchor;
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
      this.assetSrc,
      this.name,
      this.description,
      this.dxHangAnchor,
      this.dyHangAnchor,
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
    if (assetSrc == null) {
      throw new BuiltValueNullFieldError('Grip', 'assetSrc');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('Grip', 'name');
    }
    if (description == null) {
      throw new BuiltValueNullFieldError('Grip', 'description');
    }
    if (dxHangAnchor == null) {
      throw new BuiltValueNullFieldError('Grip', 'dxHangAnchor');
    }
    if (dyHangAnchor == null) {
      throw new BuiltValueNullFieldError('Grip', 'dyHangAnchor');
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
        assetSrc == other.assetSrc &&
        name == other.name &&
        description == other.description &&
        dxHangAnchor == other.dxHangAnchor &&
        dyHangAnchor == other.dyHangAnchor &&
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
                                assetSrc.hashCode),
                            name.hashCode),
                        description.hashCode),
                    dxHangAnchor.hashCode),
                dyHangAnchor.hashCode),
            assetWidth.hashCode),
        assetHeight.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Grip')
          ..add('handType', handType)
          ..add('fingers', fingers)
          ..add('crimped', crimped)
          ..add('assetSrc', assetSrc)
          ..add('name', name)
          ..add('description', description)
          ..add('dxHangAnchor', dxHangAnchor)
          ..add('dyHangAnchor', dyHangAnchor)
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

  String _assetSrc;
  String get assetSrc => _$this._assetSrc;
  set assetSrc(String assetSrc) => _$this._assetSrc = assetSrc;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _description;
  String get description => _$this._description;
  set description(String description) => _$this._description = description;

  double _dxHangAnchor;
  double get dxHangAnchor => _$this._dxHangAnchor;
  set dxHangAnchor(double dxHangAnchor) => _$this._dxHangAnchor = dxHangAnchor;

  double _dyHangAnchor;
  double get dyHangAnchor => _$this._dyHangAnchor;
  set dyHangAnchor(double dyHangAnchor) => _$this._dyHangAnchor = dyHangAnchor;

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
      _assetSrc = _$v.assetSrc;
      _name = _$v.name;
      _description = _$v.description;
      _dxHangAnchor = _$v.dxHangAnchor;
      _dyHangAnchor = _$v.dyHangAnchor;
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
              assetSrc: assetSrc,
              name: name,
              description: description,
              dxHangAnchor: dxHangAnchor,
              dyHangAnchor: dyHangAnchor,
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
