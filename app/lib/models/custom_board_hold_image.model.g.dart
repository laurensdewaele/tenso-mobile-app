// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_board_hold_image.model.dart';

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
      'holdType',
      serializers.serialize(object.holdType,
          specifiedType: const FullType(HoldType)),
      'leftPercent',
      serializers.serialize(object.leftPercent,
          specifiedType: const FullType(double)),
      'topPercent',
      serializers.serialize(object.topPercent,
          specifiedType: const FullType(double)),
      'widthPercent',
      serializers.serialize(object.widthPercent,
          specifiedType: const FullType(double)),
      'heightPercent',
      serializers.serialize(object.heightPercent,
          specifiedType: const FullType(double)),
      'scale',
      serializers.serialize(object.scale,
          specifiedType: const FullType(double)),
      'imageAsset',
      serializers.serialize(object.imageAsset,
          specifiedType: const FullType(String)),
    ];

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
        case 'holdType':
          result.holdType = serializers.deserialize(value,
              specifiedType: const FullType(HoldType)) as HoldType;
          break;
        case 'leftPercent':
          result.leftPercent = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'topPercent':
          result.topPercent = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'widthPercent':
          result.widthPercent = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'heightPercent':
          result.heightPercent = serializers.deserialize(value,
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
  final HoldType holdType;
  @override
  final double leftPercent;
  @override
  final double topPercent;
  @override
  final double widthPercent;
  @override
  final double heightPercent;
  @override
  final double scale;
  @override
  final String imageAsset;

  factory _$CustomBoardHoldImage(
          [void Function(CustomBoardHoldImageBuilder) updates]) =>
      (new CustomBoardHoldImageBuilder()..update(updates)).build();

  _$CustomBoardHoldImage._(
      {this.holdType,
      this.leftPercent,
      this.topPercent,
      this.widthPercent,
      this.heightPercent,
      this.scale,
      this.imageAsset})
      : super._() {
    if (holdType == null) {
      throw new BuiltValueNullFieldError('CustomBoardHoldImage', 'holdType');
    }
    if (leftPercent == null) {
      throw new BuiltValueNullFieldError('CustomBoardHoldImage', 'leftPercent');
    }
    if (topPercent == null) {
      throw new BuiltValueNullFieldError('CustomBoardHoldImage', 'topPercent');
    }
    if (widthPercent == null) {
      throw new BuiltValueNullFieldError(
          'CustomBoardHoldImage', 'widthPercent');
    }
    if (heightPercent == null) {
      throw new BuiltValueNullFieldError(
          'CustomBoardHoldImage', 'heightPercent');
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
        holdType == other.holdType &&
        leftPercent == other.leftPercent &&
        topPercent == other.topPercent &&
        widthPercent == other.widthPercent &&
        heightPercent == other.heightPercent &&
        scale == other.scale &&
        imageAsset == other.imageAsset;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, holdType.hashCode), leftPercent.hashCode),
                        topPercent.hashCode),
                    widthPercent.hashCode),
                heightPercent.hashCode),
            scale.hashCode),
        imageAsset.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CustomBoardHoldImage')
          ..add('holdType', holdType)
          ..add('leftPercent', leftPercent)
          ..add('topPercent', topPercent)
          ..add('widthPercent', widthPercent)
          ..add('heightPercent', heightPercent)
          ..add('scale', scale)
          ..add('imageAsset', imageAsset))
        .toString();
  }
}

class CustomBoardHoldImageBuilder
    implements Builder<CustomBoardHoldImage, CustomBoardHoldImageBuilder> {
  _$CustomBoardHoldImage _$v;

  HoldType _holdType;
  HoldType get holdType => _$this._holdType;
  set holdType(HoldType holdType) => _$this._holdType = holdType;

  double _leftPercent;
  double get leftPercent => _$this._leftPercent;
  set leftPercent(double leftPercent) => _$this._leftPercent = leftPercent;

  double _topPercent;
  double get topPercent => _$this._topPercent;
  set topPercent(double topPercent) => _$this._topPercent = topPercent;

  double _widthPercent;
  double get widthPercent => _$this._widthPercent;
  set widthPercent(double widthPercent) => _$this._widthPercent = widthPercent;

  double _heightPercent;
  double get heightPercent => _$this._heightPercent;
  set heightPercent(double heightPercent) =>
      _$this._heightPercent = heightPercent;

  double _scale;
  double get scale => _$this._scale;
  set scale(double scale) => _$this._scale = scale;

  String _imageAsset;
  String get imageAsset => _$this._imageAsset;
  set imageAsset(String imageAsset) => _$this._imageAsset = imageAsset;

  CustomBoardHoldImageBuilder();

  CustomBoardHoldImageBuilder get _$this {
    if (_$v != null) {
      _holdType = _$v.holdType;
      _leftPercent = _$v.leftPercent;
      _topPercent = _$v.topPercent;
      _widthPercent = _$v.widthPercent;
      _heightPercent = _$v.heightPercent;
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
            holdType: holdType,
            leftPercent: leftPercent,
            topPercent: topPercent,
            widthPercent: widthPercent,
            heightPercent: heightPercent,
            scale: scale,
            imageAsset: imageAsset);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
