// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_board_hold_image.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<CustomBoardHoldImage> _$customBoardHoldImageSerializer =
    new _$CustomBoardHoldImageSerializer();

class _$CustomBoardHoldImageSerializer
    implements StructuredSerializer<CustomBoardHoldImage> {
  @override
  final Iterable<Type> types = const [
    CustomBoardHoldImage,
    _$CustomBoardHoldImage
  ];
  @override
  final String wireName = 'CustomBoardHoldImage';

  @override
  Iterable<Object> serialize(
      Serializers serializers, CustomBoardHoldImage object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'widthFactor',
      serializers.serialize(object.widthFactor,
          specifiedType: const FullType(int)),
      'type',
      serializers.serialize(object.type,
          specifiedType: const FullType(HoldType)),
      'topYPercent',
      serializers.serialize(object.topYPercent,
          specifiedType: const FullType(List, const [const FullType(double)])),
      'leftXPercent',
      serializers.serialize(object.leftXPercent,
          specifiedType: const FullType(List, const [const FullType(double)])),
      'heightPercent',
      serializers.serialize(object.heightPercent,
          specifiedType: const FullType(double)),
      'widthPercent',
      serializers.serialize(object.widthPercent,
          specifiedType: const FullType(double)),
      'scale',
      serializers.serialize(object.scale,
          specifiedType: const FullType(double)),
      'imageAsset',
      serializers.serialize(object.imageAsset,
          specifiedType: const FullType(String)),
    ];
    if (object.position != null) {
      result
        ..add('position')
        ..add(serializers.serialize(object.position,
            specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  CustomBoardHoldImage deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CustomBoardHoldImageBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'position':
          result.position = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'widthFactor':
          result.widthFactor = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'type':
          result.type = serializers.deserialize(value,
              specifiedType: const FullType(HoldType)) as HoldType;
          break;
        case 'topYPercent':
          result.topYPercent = serializers.deserialize(value,
                  specifiedType:
                      const FullType(List, const [const FullType(double)]))
              as List<double>;
          break;
        case 'leftXPercent':
          result.leftXPercent = serializers.deserialize(value,
                  specifiedType:
                      const FullType(List, const [const FullType(double)]))
              as List<double>;
          break;
        case 'heightPercent':
          result.heightPercent = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'widthPercent':
          result.widthPercent = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'scale':
          result.scale = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'imageAsset':
          result.imageAsset = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$CustomBoardHoldImage extends CustomBoardHoldImage {
  @override
  final int position;
  @override
  final int widthFactor;
  @override
  final HoldType type;
  @override
  final List<double> topYPercent;
  @override
  final List<double> leftXPercent;
  @override
  final double heightPercent;
  @override
  final double widthPercent;
  @override
  final double scale;
  @override
  final String imageAsset;

  factory _$CustomBoardHoldImage(
          [void Function(CustomBoardHoldImageBuilder) updates]) =>
      (new CustomBoardHoldImageBuilder()..update(updates)).build();

  _$CustomBoardHoldImage._(
      {this.position,
      this.widthFactor,
      this.type,
      this.topYPercent,
      this.leftXPercent,
      this.heightPercent,
      this.widthPercent,
      this.scale,
      this.imageAsset})
      : super._() {
    if (widthFactor == null) {
      throw new BuiltValueNullFieldError('CustomBoardHoldImage', 'widthFactor');
    }
    if (type == null) {
      throw new BuiltValueNullFieldError('CustomBoardHoldImage', 'type');
    }
    if (topYPercent == null) {
      throw new BuiltValueNullFieldError('CustomBoardHoldImage', 'topYPercent');
    }
    if (leftXPercent == null) {
      throw new BuiltValueNullFieldError(
          'CustomBoardHoldImage', 'leftXPercent');
    }
    if (heightPercent == null) {
      throw new BuiltValueNullFieldError(
          'CustomBoardHoldImage', 'heightPercent');
    }
    if (widthPercent == null) {
      throw new BuiltValueNullFieldError(
          'CustomBoardHoldImage', 'widthPercent');
    }
    if (scale == null) {
      throw new BuiltValueNullFieldError('CustomBoardHoldImage', 'scale');
    }
    if (imageAsset == null) {
      throw new BuiltValueNullFieldError('CustomBoardHoldImage', 'imageAsset');
    }
  }

  @override
  CustomBoardHoldImage rebuild(
          void Function(CustomBoardHoldImageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CustomBoardHoldImageBuilder toBuilder() =>
      new CustomBoardHoldImageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CustomBoardHoldImage &&
        position == other.position &&
        widthFactor == other.widthFactor &&
        type == other.type &&
        topYPercent == other.topYPercent &&
        leftXPercent == other.leftXPercent &&
        heightPercent == other.heightPercent &&
        widthPercent == other.widthPercent &&
        scale == other.scale &&
        imageAsset == other.imageAsset;
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
                                $jc($jc(0, position.hashCode),
                                    widthFactor.hashCode),
                                type.hashCode),
                            topYPercent.hashCode),
                        leftXPercent.hashCode),
                    heightPercent.hashCode),
                widthPercent.hashCode),
            scale.hashCode),
        imageAsset.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CustomBoardHoldImage')
          ..add('position', position)
          ..add('widthFactor', widthFactor)
          ..add('type', type)
          ..add('topYPercent', topYPercent)
          ..add('leftXPercent', leftXPercent)
          ..add('heightPercent', heightPercent)
          ..add('widthPercent', widthPercent)
          ..add('scale', scale)
          ..add('imageAsset', imageAsset))
        .toString();
  }
}

class CustomBoardHoldImageBuilder
    implements Builder<CustomBoardHoldImage, CustomBoardHoldImageBuilder> {
  _$CustomBoardHoldImage _$v;

  int _position;
  int get position => _$this._position;
  set position(int position) => _$this._position = position;

  int _widthFactor;
  int get widthFactor => _$this._widthFactor;
  set widthFactor(int widthFactor) => _$this._widthFactor = widthFactor;

  HoldType _type;
  HoldType get type => _$this._type;
  set type(HoldType type) => _$this._type = type;

  List<double> _topYPercent;
  List<double> get topYPercent => _$this._topYPercent;
  set topYPercent(List<double> topYPercent) =>
      _$this._topYPercent = topYPercent;

  List<double> _leftXPercent;
  List<double> get leftXPercent => _$this._leftXPercent;
  set leftXPercent(List<double> leftXPercent) =>
      _$this._leftXPercent = leftXPercent;

  double _heightPercent;
  double get heightPercent => _$this._heightPercent;
  set heightPercent(double heightPercent) =>
      _$this._heightPercent = heightPercent;

  double _widthPercent;
  double get widthPercent => _$this._widthPercent;
  set widthPercent(double widthPercent) => _$this._widthPercent = widthPercent;

  double _scale;
  double get scale => _$this._scale;
  set scale(double scale) => _$this._scale = scale;

  String _imageAsset;
  String get imageAsset => _$this._imageAsset;
  set imageAsset(String imageAsset) => _$this._imageAsset = imageAsset;

  CustomBoardHoldImageBuilder();

  CustomBoardHoldImageBuilder get _$this {
    if (_$v != null) {
      _position = _$v.position;
      _widthFactor = _$v.widthFactor;
      _type = _$v.type;
      _topYPercent = _$v.topYPercent;
      _leftXPercent = _$v.leftXPercent;
      _heightPercent = _$v.heightPercent;
      _widthPercent = _$v.widthPercent;
      _scale = _$v.scale;
      _imageAsset = _$v.imageAsset;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CustomBoardHoldImage other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$CustomBoardHoldImage;
  }

  @override
  void update(void Function(CustomBoardHoldImageBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$CustomBoardHoldImage build() {
    final _$result = _$v ??
        new _$CustomBoardHoldImage._(
            position: position,
            widthFactor: widthFactor,
            type: type,
            topYPercent: topYPercent,
            leftXPercent: leftXPercent,
            heightPercent: heightPercent,
            widthPercent: widthPercent,
            scale: scale,
            imageAsset: imageAsset);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
