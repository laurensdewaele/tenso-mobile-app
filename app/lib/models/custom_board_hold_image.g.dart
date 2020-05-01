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
      'position',
      serializers.serialize(object.position,
          specifiedType: const FullType(int)),
      'type',
      serializers.serialize(object.type,
          specifiedType: const FullType(HoldType)),
      'topLeftXPercent',
      serializers.serialize(object.topLeftXPercent,
          specifiedType: const FullType(double)),
      'topLeftYPercent',
      serializers.serialize(object.topLeftYPercent,
          specifiedType: const FullType(double)),
      'widthPercent',
      serializers.serialize(object.widthPercent,
          specifiedType: const FullType(double)),
      'heightPercent',
      serializers.serialize(object.heightPercent,
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
        case 'position':
          result.position = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'type':
          result.type = serializers.deserialize(value,
              specifiedType: const FullType(HoldType)) as HoldType;
          break;
        case 'topLeftXPercent':
          result.topLeftXPercent = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'topLeftYPercent':
          result.topLeftYPercent = serializers.deserialize(value,
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
  final HoldType type;
  @override
  final double topLeftXPercent;
  @override
  final double topLeftYPercent;
  @override
  final double widthPercent;
  @override
  final double heightPercent;
  @override
  final String imageAsset;

  factory _$CustomBoardHoldImage(
          [void Function(CustomBoardHoldImageBuilder) updates]) =>
      (new CustomBoardHoldImageBuilder()..update(updates)).build();

  _$CustomBoardHoldImage._(
      {this.position,
      this.type,
      this.topLeftXPercent,
      this.topLeftYPercent,
      this.widthPercent,
      this.heightPercent,
      this.imageAsset})
      : super._() {
    if (position == null) {
      throw new BuiltValueNullFieldError('CustomBoardHoldImage', 'position');
    }
    if (type == null) {
      throw new BuiltValueNullFieldError('CustomBoardHoldImage', 'type');
    }
    if (topLeftXPercent == null) {
      throw new BuiltValueNullFieldError(
          'CustomBoardHoldImage', 'topLeftXPercent');
    }
    if (topLeftYPercent == null) {
      throw new BuiltValueNullFieldError(
          'CustomBoardHoldImage', 'topLeftYPercent');
    }
    if (widthPercent == null) {
      throw new BuiltValueNullFieldError(
          'CustomBoardHoldImage', 'widthPercent');
    }
    if (heightPercent == null) {
      throw new BuiltValueNullFieldError(
          'CustomBoardHoldImage', 'heightPercent');
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
        type == other.type &&
        topLeftXPercent == other.topLeftXPercent &&
        topLeftYPercent == other.topLeftYPercent &&
        widthPercent == other.widthPercent &&
        heightPercent == other.heightPercent &&
        imageAsset == other.imageAsset;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, position.hashCode), type.hashCode),
                        topLeftXPercent.hashCode),
                    topLeftYPercent.hashCode),
                widthPercent.hashCode),
            heightPercent.hashCode),
        imageAsset.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CustomBoardHoldImage')
          ..add('position', position)
          ..add('type', type)
          ..add('topLeftXPercent', topLeftXPercent)
          ..add('topLeftYPercent', topLeftYPercent)
          ..add('widthPercent', widthPercent)
          ..add('heightPercent', heightPercent)
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

  HoldType _type;
  HoldType get type => _$this._type;
  set type(HoldType type) => _$this._type = type;

  double _topLeftXPercent;
  double get topLeftXPercent => _$this._topLeftXPercent;
  set topLeftXPercent(double topLeftXPercent) =>
      _$this._topLeftXPercent = topLeftXPercent;

  double _topLeftYPercent;
  double get topLeftYPercent => _$this._topLeftYPercent;
  set topLeftYPercent(double topLeftYPercent) =>
      _$this._topLeftYPercent = topLeftYPercent;

  double _widthPercent;
  double get widthPercent => _$this._widthPercent;
  set widthPercent(double widthPercent) => _$this._widthPercent = widthPercent;

  double _heightPercent;
  double get heightPercent => _$this._heightPercent;
  set heightPercent(double heightPercent) =>
      _$this._heightPercent = heightPercent;

  String _imageAsset;
  String get imageAsset => _$this._imageAsset;
  set imageAsset(String imageAsset) => _$this._imageAsset = imageAsset;

  CustomBoardHoldImageBuilder();

  CustomBoardHoldImageBuilder get _$this {
    if (_$v != null) {
      _position = _$v.position;
      _type = _$v.type;
      _topLeftXPercent = _$v.topLeftXPercent;
      _topLeftYPercent = _$v.topLeftYPercent;
      _widthPercent = _$v.widthPercent;
      _heightPercent = _$v.heightPercent;
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
            type: type,
            topLeftXPercent: topLeftXPercent,
            topLeftYPercent: topLeftYPercent,
            widthPercent: widthPercent,
            heightPercent: heightPercent,
            imageAsset: imageAsset);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
