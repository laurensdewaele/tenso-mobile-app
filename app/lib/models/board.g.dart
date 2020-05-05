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
      'custom',
      serializers.serialize(object.custom, specifiedType: const FullType(bool)),
      'model',
      serializers.serialize(object.model,
          specifiedType: const FullType(String)),
      'imageAsset',
      serializers.serialize(object.imageAsset,
          specifiedType: const FullType(String)),
      'aspectRatio',
      serializers.serialize(object.aspectRatio,
          specifiedType: const FullType(double)),
      'height',
      serializers.serialize(object.height,
          specifiedType: const FullType(double)),
      'width',
      serializers.serialize(object.width,
          specifiedType: const FullType(double)),
      'handToBoardHeightRatio',
      serializers.serialize(object.handToBoardHeightRatio,
          specifiedType: const FullType(double)),
      'boardHolds',
      serializers.serialize(object.boardHolds,
          specifiedType:
              const FullType(BuiltList, const [const FullType(BoardHold)])),
      'defaultLeftGripHold',
      serializers.serialize(object.defaultLeftGripHold,
          specifiedType: const FullType(BoardHold)),
      'defaultRightGripHold',
      serializers.serialize(object.defaultRightGripHold,
          specifiedType: const FullType(BoardHold)),
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
        case 'manufacturer':
          result.manufacturer = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'model':
          result.model = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'imageAsset':
          result.imageAsset = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'aspectRatio':
          result.aspectRatio = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'height':
          result.height = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'width':
          result.width = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'handToBoardHeightRatio':
          result.handToBoardHeightRatio = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'boardHolds':
          result.boardHolds.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(BoardHold)]))
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
      }
    }

    return result.build();
  }
}

class _$Board extends Board {
  @override
  final String id;
  @override
  final bool custom;
  @override
  final BuiltList<CustomBoardHoldImage> customBoardHoldImages;
  @override
  final String manufacturer;
  @override
  final String model;
  @override
  final String imageAsset;
  @override
  final double aspectRatio;
  @override
  final double height;
  @override
  final double width;
  @override
  final double handToBoardHeightRatio;
  @override
  final BuiltList<BoardHold> boardHolds;
  @override
  final BoardHold defaultLeftGripHold;
  @override
  final BoardHold defaultRightGripHold;

  factory _$Board([void Function(BoardBuilder) updates]) =>
      (new BoardBuilder()..update(updates)).build();

  _$Board._(
      {this.id,
      this.custom,
      this.customBoardHoldImages,
      this.manufacturer,
      this.model,
      this.imageAsset,
      this.aspectRatio,
      this.height,
      this.width,
      this.handToBoardHeightRatio,
      this.boardHolds,
      this.defaultLeftGripHold,
      this.defaultRightGripHold})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('Board', 'id');
    }
    if (custom == null) {
      throw new BuiltValueNullFieldError('Board', 'custom');
    }
    if (model == null) {
      throw new BuiltValueNullFieldError('Board', 'model');
    }
    if (imageAsset == null) {
      throw new BuiltValueNullFieldError('Board', 'imageAsset');
    }
    if (aspectRatio == null) {
      throw new BuiltValueNullFieldError('Board', 'aspectRatio');
    }
    if (height == null) {
      throw new BuiltValueNullFieldError('Board', 'height');
    }
    if (width == null) {
      throw new BuiltValueNullFieldError('Board', 'width');
    }
    if (handToBoardHeightRatio == null) {
      throw new BuiltValueNullFieldError('Board', 'handToBoardHeightRatio');
    }
    if (boardHolds == null) {
      throw new BuiltValueNullFieldError('Board', 'boardHolds');
    }
    if (defaultLeftGripHold == null) {
      throw new BuiltValueNullFieldError('Board', 'defaultLeftGripHold');
    }
    if (defaultRightGripHold == null) {
      throw new BuiltValueNullFieldError('Board', 'defaultRightGripHold');
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
        custom == other.custom &&
        customBoardHoldImages == other.customBoardHoldImages &&
        manufacturer == other.manufacturer &&
        model == other.model &&
        imageAsset == other.imageAsset &&
        aspectRatio == other.aspectRatio &&
        height == other.height &&
        width == other.width &&
        handToBoardHeightRatio == other.handToBoardHeightRatio &&
        boardHolds == other.boardHolds &&
        defaultLeftGripHold == other.defaultLeftGripHold &&
        defaultRightGripHold == other.defaultRightGripHold;
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
                                                    custom.hashCode),
                                                customBoardHoldImages.hashCode),
                                            manufacturer.hashCode),
                                        model.hashCode),
                                    imageAsset.hashCode),
                                aspectRatio.hashCode),
                            height.hashCode),
                        width.hashCode),
                    handToBoardHeightRatio.hashCode),
                boardHolds.hashCode),
            defaultLeftGripHold.hashCode),
        defaultRightGripHold.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Board')
          ..add('id', id)
          ..add('custom', custom)
          ..add('customBoardHoldImages', customBoardHoldImages)
          ..add('manufacturer', manufacturer)
          ..add('model', model)
          ..add('imageAsset', imageAsset)
          ..add('aspectRatio', aspectRatio)
          ..add('height', height)
          ..add('width', width)
          ..add('handToBoardHeightRatio', handToBoardHeightRatio)
          ..add('boardHolds', boardHolds)
          ..add('defaultLeftGripHold', defaultLeftGripHold)
          ..add('defaultRightGripHold', defaultRightGripHold))
        .toString();
  }
}

class BoardBuilder implements Builder<Board, BoardBuilder> {
  _$Board _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  bool _custom;
  bool get custom => _$this._custom;
  set custom(bool custom) => _$this._custom = custom;

  ListBuilder<CustomBoardHoldImage> _customBoardHoldImages;
  ListBuilder<CustomBoardHoldImage> get customBoardHoldImages =>
      _$this._customBoardHoldImages ??= new ListBuilder<CustomBoardHoldImage>();
  set customBoardHoldImages(
          ListBuilder<CustomBoardHoldImage> customBoardHoldImages) =>
      _$this._customBoardHoldImages = customBoardHoldImages;

  String _manufacturer;
  String get manufacturer => _$this._manufacturer;
  set manufacturer(String manufacturer) => _$this._manufacturer = manufacturer;

  String _model;
  String get model => _$this._model;
  set model(String model) => _$this._model = model;

  String _imageAsset;
  String get imageAsset => _$this._imageAsset;
  set imageAsset(String imageAsset) => _$this._imageAsset = imageAsset;

  double _aspectRatio;
  double get aspectRatio => _$this._aspectRatio;
  set aspectRatio(double aspectRatio) => _$this._aspectRatio = aspectRatio;

  double _height;
  double get height => _$this._height;
  set height(double height) => _$this._height = height;

  double _width;
  double get width => _$this._width;
  set width(double width) => _$this._width = width;

  double _handToBoardHeightRatio;
  double get handToBoardHeightRatio => _$this._handToBoardHeightRatio;
  set handToBoardHeightRatio(double handToBoardHeightRatio) =>
      _$this._handToBoardHeightRatio = handToBoardHeightRatio;

  ListBuilder<BoardHold> _boardHolds;
  ListBuilder<BoardHold> get boardHolds =>
      _$this._boardHolds ??= new ListBuilder<BoardHold>();
  set boardHolds(ListBuilder<BoardHold> boardHolds) =>
      _$this._boardHolds = boardHolds;

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

  BoardBuilder();

  BoardBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _custom = _$v.custom;
      _customBoardHoldImages = _$v.customBoardHoldImages?.toBuilder();
      _manufacturer = _$v.manufacturer;
      _model = _$v.model;
      _imageAsset = _$v.imageAsset;
      _aspectRatio = _$v.aspectRatio;
      _height = _$v.height;
      _width = _$v.width;
      _handToBoardHeightRatio = _$v.handToBoardHeightRatio;
      _boardHolds = _$v.boardHolds?.toBuilder();
      _defaultLeftGripHold = _$v.defaultLeftGripHold?.toBuilder();
      _defaultRightGripHold = _$v.defaultRightGripHold?.toBuilder();
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
              custom: custom,
              customBoardHoldImages: _customBoardHoldImages?.build(),
              manufacturer: manufacturer,
              model: model,
              imageAsset: imageAsset,
              aspectRatio: aspectRatio,
              height: height,
              width: width,
              handToBoardHeightRatio: handToBoardHeightRatio,
              boardHolds: boardHolds.build(),
              defaultLeftGripHold: defaultLeftGripHold.build(),
              defaultRightGripHold: defaultRightGripHold.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'customBoardHoldImages';
        _customBoardHoldImages?.build();

        _$failedField = 'boardHolds';
        boardHolds.build();
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
