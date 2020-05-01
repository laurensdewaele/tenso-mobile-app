// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Board> _$boardSerializer = new _$BoardSerializer();

class _$BoardSerializer implements StructuredSerializer<Board> {
  @override
  final Iterable<Type> types = const [Board, _$Board];
  @override
  final String wireName = 'Board';

  @override
  Iterable<Object> serialize(Serializers serializers, Board object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'aspectRatio',
      serializers.serialize(object.aspectRatio,
          specifiedType: const FullType(double)),
      'boardHolds',
      serializers.serialize(object.boardHolds,
          specifiedType:
              const FullType(BuiltList, const [const FullType(BoardHold)])),
      'custom',
      serializers.serialize(object.custom, specifiedType: const FullType(bool)),
      'defaultLeftGripHold',
      serializers.serialize(object.defaultLeftGripHold,
          specifiedType: const FullType(BoardHold)),
      'defaultRightGripHold',
      serializers.serialize(object.defaultRightGripHold,
          specifiedType: const FullType(BoardHold)),
      'imageAsset',
      serializers.serialize(object.imageAsset,
          specifiedType: const FullType(String)),
      'handToBoardHeightRatio',
      serializers.serialize(object.handToBoardHeightRatio,
          specifiedType: const FullType(double)),
      'height',
      serializers.serialize(object.height,
          specifiedType: const FullType(double)),
      'model',
      serializers.serialize(object.model,
          specifiedType: const FullType(String)),
      'width',
      serializers.serialize(object.width,
          specifiedType: const FullType(double)),
    ];
    if (object.customBoardHoldImages != null) {
      result
        ..add('customBoardHoldImages')
        ..add(serializers.serialize(object.customBoardHoldImages,
            specifiedType: const FullType(
                BuiltList, const [const FullType(CustomBoardHoldImage)])));
    }
    if (object.manufacturer != null) {
      result
        ..add('manufacturer')
        ..add(serializers.serialize(object.manufacturer,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  Board deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BoardBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'aspectRatio':
          result.aspectRatio = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'boardHolds':
          result.boardHolds.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(BoardHold)]))
              as BuiltList<Object>);
          break;
        case 'custom':
          result.custom = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'customBoardHoldImages':
          result.customBoardHoldImages.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(CustomBoardHoldImage)]))
              as BuiltList<Object>);
          break;
        case 'defaultLeftGripHold':
          result.defaultLeftGripHold.replace(serializers.deserialize(value,
              specifiedType: const FullType(BoardHold)) as BoardHold);
          break;
        case 'defaultRightGripHold':
          result.defaultRightGripHold.replace(serializers.deserialize(value,
              specifiedType: const FullType(BoardHold)) as BoardHold);
          break;
        case 'imageAsset':
          result.imageAsset = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'handToBoardHeightRatio':
          result.handToBoardHeightRatio = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'height':
          result.height = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'manufacturer':
          result.manufacturer = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'model':
          result.model = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'width':
          result.width = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
      }
    }

    return result.build();
  }
}

class _$Board extends Board {
  @override
  final String id;
  @override
  final double aspectRatio;
  @override
  final BuiltList<BoardHold> boardHolds;
  @override
  final bool custom;
  @override
  final BuiltList<CustomBoardHoldImage> customBoardHoldImages;
  @override
  final BoardHold defaultLeftGripHold;
  @override
  final BoardHold defaultRightGripHold;
  @override
  final String imageAsset;
  @override
  final double handToBoardHeightRatio;
  @override
  final double height;
  @override
  final String manufacturer;
  @override
  final String model;
  @override
  final double width;

  factory _$Board([void Function(BoardBuilder) updates]) =>
      (new BoardBuilder()..update(updates)).build();

  _$Board._(
      {this.id,
      this.aspectRatio,
      this.boardHolds,
      this.custom,
      this.customBoardHoldImages,
      this.defaultLeftGripHold,
      this.defaultRightGripHold,
      this.imageAsset,
      this.handToBoardHeightRatio,
      this.height,
      this.manufacturer,
      this.model,
      this.width})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('Board', 'id');
    }
    if (aspectRatio == null) {
      throw new BuiltValueNullFieldError('Board', 'aspectRatio');
    }
    if (boardHolds == null) {
      throw new BuiltValueNullFieldError('Board', 'boardHolds');
    }
    if (custom == null) {
      throw new BuiltValueNullFieldError('Board', 'custom');
    }
    if (defaultLeftGripHold == null) {
      throw new BuiltValueNullFieldError('Board', 'defaultLeftGripHold');
    }
    if (defaultRightGripHold == null) {
      throw new BuiltValueNullFieldError('Board', 'defaultRightGripHold');
    }
    if (imageAsset == null) {
      throw new BuiltValueNullFieldError('Board', 'imageAsset');
    }
    if (handToBoardHeightRatio == null) {
      throw new BuiltValueNullFieldError('Board', 'handToBoardHeightRatio');
    }
    if (height == null) {
      throw new BuiltValueNullFieldError('Board', 'height');
    }
    if (model == null) {
      throw new BuiltValueNullFieldError('Board', 'model');
    }
    if (width == null) {
      throw new BuiltValueNullFieldError('Board', 'width');
    }
  }

  @override
  Board rebuild(void Function(BoardBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BoardBuilder toBuilder() => new BoardBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Board &&
        id == other.id &&
        aspectRatio == other.aspectRatio &&
        boardHolds == other.boardHolds &&
        custom == other.custom &&
        customBoardHoldImages == other.customBoardHoldImages &&
        defaultLeftGripHold == other.defaultLeftGripHold &&
        defaultRightGripHold == other.defaultRightGripHold &&
        imageAsset == other.imageAsset &&
        handToBoardHeightRatio == other.handToBoardHeightRatio &&
        height == other.height &&
        manufacturer == other.manufacturer &&
        model == other.model &&
        width == other.width;
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
                                    $jc(
                                        $jc(
                                            $jc(
                                                $jc($jc(0, id.hashCode),
                                                    aspectRatio.hashCode),
                                                boardHolds.hashCode),
                                            custom.hashCode),
                                        customBoardHoldImages.hashCode),
                                    defaultLeftGripHold.hashCode),
                                defaultRightGripHold.hashCode),
                            imageAsset.hashCode),
                        handToBoardHeightRatio.hashCode),
                    height.hashCode),
                manufacturer.hashCode),
            model.hashCode),
        width.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Board')
          ..add('id', id)
          ..add('aspectRatio', aspectRatio)
          ..add('boardHolds', boardHolds)
          ..add('custom', custom)
          ..add('customBoardHoldImages', customBoardHoldImages)
          ..add('defaultLeftGripHold', defaultLeftGripHold)
          ..add('defaultRightGripHold', defaultRightGripHold)
          ..add('imageAsset', imageAsset)
          ..add('handToBoardHeightRatio', handToBoardHeightRatio)
          ..add('height', height)
          ..add('manufacturer', manufacturer)
          ..add('model', model)
          ..add('width', width))
        .toString();
  }
}

class BoardBuilder implements Builder<Board, BoardBuilder> {
  _$Board _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  double _aspectRatio;
  double get aspectRatio => _$this._aspectRatio;
  set aspectRatio(double aspectRatio) => _$this._aspectRatio = aspectRatio;

  ListBuilder<BoardHold> _boardHolds;
  ListBuilder<BoardHold> get boardHolds =>
      _$this._boardHolds ??= new ListBuilder<BoardHold>();
  set boardHolds(ListBuilder<BoardHold> boardHolds) =>
      _$this._boardHolds = boardHolds;

  bool _custom;
  bool get custom => _$this._custom;
  set custom(bool custom) => _$this._custom = custom;

  ListBuilder<CustomBoardHoldImage> _customBoardHoldImages;
  ListBuilder<CustomBoardHoldImage> get customBoardHoldImages =>
      _$this._customBoardHoldImages ??= new ListBuilder<CustomBoardHoldImage>();
  set customBoardHoldImages(
          ListBuilder<CustomBoardHoldImage> customBoardHoldImages) =>
      _$this._customBoardHoldImages = customBoardHoldImages;

  BoardHoldBuilder _defaultLeftGripHold;
  BoardHoldBuilder get defaultLeftGripHold =>
      _$this._defaultLeftGripHold ??= new BoardHoldBuilder();
  set defaultLeftGripHold(BoardHoldBuilder defaultLeftGripHold) =>
      _$this._defaultLeftGripHold = defaultLeftGripHold;

  BoardHoldBuilder _defaultRightGripHold;
  BoardHoldBuilder get defaultRightGripHold =>
      _$this._defaultRightGripHold ??= new BoardHoldBuilder();
  set defaultRightGripHold(BoardHoldBuilder defaultRightGripHold) =>
      _$this._defaultRightGripHold = defaultRightGripHold;

  String _imageAsset;
  String get imageAsset => _$this._imageAsset;
  set imageAsset(String imageAsset) => _$this._imageAsset = imageAsset;

  double _handToBoardHeightRatio;
  double get handToBoardHeightRatio => _$this._handToBoardHeightRatio;
  set handToBoardHeightRatio(double handToBoardHeightRatio) =>
      _$this._handToBoardHeightRatio = handToBoardHeightRatio;

  double _height;
  double get height => _$this._height;
  set height(double height) => _$this._height = height;

  String _manufacturer;
  String get manufacturer => _$this._manufacturer;
  set manufacturer(String manufacturer) => _$this._manufacturer = manufacturer;

  String _model;
  String get model => _$this._model;
  set model(String model) => _$this._model = model;

  double _width;
  double get width => _$this._width;
  set width(double width) => _$this._width = width;

  BoardBuilder();

  BoardBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _aspectRatio = _$v.aspectRatio;
      _boardHolds = _$v.boardHolds?.toBuilder();
      _custom = _$v.custom;
      _customBoardHoldImages = _$v.customBoardHoldImages?.toBuilder();
      _defaultLeftGripHold = _$v.defaultLeftGripHold?.toBuilder();
      _defaultRightGripHold = _$v.defaultRightGripHold?.toBuilder();
      _imageAsset = _$v.imageAsset;
      _handToBoardHeightRatio = _$v.handToBoardHeightRatio;
      _height = _$v.height;
      _manufacturer = _$v.manufacturer;
      _model = _$v.model;
      _width = _$v.width;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Board other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Board;
  }

  @override
  void update(void Function(BoardBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Board build() {
    _$Board _$result;
    try {
      _$result = _$v ??
          new _$Board._(
              id: id,
              aspectRatio: aspectRatio,
              boardHolds: boardHolds.build(),
              custom: custom,
              customBoardHoldImages: _customBoardHoldImages?.build(),
              defaultLeftGripHold: defaultLeftGripHold.build(),
              defaultRightGripHold: defaultRightGripHold.build(),
              imageAsset: imageAsset,
              handToBoardHeightRatio: handToBoardHeightRatio,
              height: height,
              manufacturer: manufacturer,
              model: model,
              width: width);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'boardHolds';
        boardHolds.build();

        _$failedField = 'customBoardHoldImages';
        _customBoardHoldImages?.build();
        _$failedField = 'defaultLeftGripHold';
        defaultLeftGripHold.build();
        _$failedField = 'defaultRightGripHold';
        defaultRightGripHold.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Board', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
