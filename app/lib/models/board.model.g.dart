// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board.model.dart';

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
      'imageAsset',
      serializers.serialize(object.imageAsset,
          specifiedType: const FullType(String)),
      'imageAssetHeight',
      serializers.serialize(object.imageAssetHeight,
          specifiedType: const FullType(double)),
      'imageAssetWidth',
      serializers.serialize(object.imageAssetWidth,
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
    if (object.model != null) {
      result
        ..add('model')
        ..add(serializers.serialize(object.model,
            specifiedType: const FullType(String)));
    }
    if (object.customName != null) {
      result
        ..add('customName')
        ..add(serializers.serialize(object.customName,
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
        case 'customName':
          result.customName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'imageAsset':
          result.imageAsset = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'imageAssetHeight':
          result.imageAssetHeight = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'imageAssetWidth':
          result.imageAssetWidth = serializers.deserialize(value,
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
  final String customName;
  @override
  final String imageAsset;
  @override
  final double imageAssetHeight;
  @override
  final double imageAssetWidth;
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
      this.customName,
      this.imageAsset,
      this.imageAssetHeight,
      this.imageAssetWidth,
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
    if (imageAsset == null) {
      throw new BuiltValueNullFieldError('Board', 'imageAsset');
    }
    if (imageAssetHeight == null) {
      throw new BuiltValueNullFieldError('Board', 'imageAssetHeight');
    }
    if (imageAssetWidth == null) {
      throw new BuiltValueNullFieldError('Board', 'imageAssetWidth');
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
        customName == other.customName &&
        imageAsset == other.imageAsset &&
        imageAssetHeight == other.imageAssetHeight &&
        imageAssetWidth == other.imageAssetWidth &&
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
                                    customName.hashCode),
                                imageAsset.hashCode),
                            imageAssetHeight.hashCode),
                        imageAssetWidth.hashCode),
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
          ..add('customName', customName)
          ..add('imageAsset', imageAsset)
          ..add('imageAssetHeight', imageAssetHeight)
          ..add('imageAssetWidth', imageAssetWidth)
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

  String _customName;
  String get customName => _$this._customName;
  set customName(String customName) => _$this._customName = customName;

  String _imageAsset;
  String get imageAsset => _$this._imageAsset;
  set imageAsset(String imageAsset) => _$this._imageAsset = imageAsset;

  double _imageAssetHeight;
  double get imageAssetHeight => _$this._imageAssetHeight;
  set imageAssetHeight(double imageAssetHeight) =>
      _$this._imageAssetHeight = imageAssetHeight;

  double _imageAssetWidth;
  double get imageAssetWidth => _$this._imageAssetWidth;
  set imageAssetWidth(double imageAssetWidth) =>
      _$this._imageAssetWidth = imageAssetWidth;

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
      _customName = _$v.customName;
      _imageAsset = _$v.imageAsset;
      _imageAssetHeight = _$v.imageAssetHeight;
      _imageAssetWidth = _$v.imageAssetWidth;
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
              customName: customName,
              imageAsset: imageAsset,
              imageAssetHeight: imageAssetHeight,
              imageAssetWidth: imageAssetWidth,
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
