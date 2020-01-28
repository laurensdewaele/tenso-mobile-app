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
      'manufacturer',
      serializers.serialize(object.manufacturer,
          specifiedType: const FullType(String)),
      'model',
      serializers.serialize(object.model,
          specifiedType: const FullType(String)),
      'size',
      serializers.serialize(object.size, specifiedType: const FullType(Size)),
      'aspectRatio',
      serializers.serialize(object.aspectRatio,
          specifiedType: const FullType(double)),
      'boardHolds',
      serializers.serialize(object.boardHolds,
          specifiedType:
              const FullType(BuiltList, const [const FullType(BoardHold)])),
      'handToBoardHeightRatio',
      serializers.serialize(object.handToBoardHeightRatio,
          specifiedType: const FullType(double)),
      'assetSrc',
      serializers.serialize(object.assetSrc,
          specifiedType: const FullType(String)),
      'defaultLeftGripHold',
      serializers.serialize(object.defaultLeftGripHold,
          specifiedType: const FullType(BoardHold)),
      'defaultRightGripHold',
      serializers.serialize(object.defaultRightGripHold,
          specifiedType: const FullType(BoardHold)),
    ];

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
        case 'manufacturer':
          result.manufacturer = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'model':
          result.model = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'size':
          result.size = serializers.deserialize(value,
              specifiedType: const FullType(Size)) as Size;
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
        case 'handToBoardHeightRatio':
          result.handToBoardHeightRatio = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'assetSrc':
          result.assetSrc = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
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
  final String manufacturer;
  @override
  final String model;
  @override
  final Size size;
  @override
  final double aspectRatio;
  @override
  final BuiltList<BoardHold> boardHolds;
  @override
  final double handToBoardHeightRatio;
  @override
  final String assetSrc;
  @override
  final BoardHold defaultLeftGripHold;
  @override
  final BoardHold defaultRightGripHold;

  factory _$Board([void Function(BoardBuilder) updates]) =>
      (new BoardBuilder()..update(updates)).build();

  _$Board._(
      {this.manufacturer,
      this.model,
      this.size,
      this.aspectRatio,
      this.boardHolds,
      this.handToBoardHeightRatio,
      this.assetSrc,
      this.defaultLeftGripHold,
      this.defaultRightGripHold})
      : super._() {
    if (manufacturer == null) {
      throw new BuiltValueNullFieldError('Board', 'manufacturer');
    }
    if (model == null) {
      throw new BuiltValueNullFieldError('Board', 'model');
    }
    if (size == null) {
      throw new BuiltValueNullFieldError('Board', 'size');
    }
    if (aspectRatio == null) {
      throw new BuiltValueNullFieldError('Board', 'aspectRatio');
    }
    if (boardHolds == null) {
      throw new BuiltValueNullFieldError('Board', 'boardHolds');
    }
    if (handToBoardHeightRatio == null) {
      throw new BuiltValueNullFieldError('Board', 'handToBoardHeightRatio');
    }
    if (assetSrc == null) {
      throw new BuiltValueNullFieldError('Board', 'assetSrc');
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
        manufacturer == other.manufacturer &&
        model == other.model &&
        size == other.size &&
        aspectRatio == other.aspectRatio &&
        boardHolds == other.boardHolds &&
        handToBoardHeightRatio == other.handToBoardHeightRatio &&
        assetSrc == other.assetSrc &&
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
                                $jc($jc(0, manufacturer.hashCode),
                                    model.hashCode),
                                size.hashCode),
                            aspectRatio.hashCode),
                        boardHolds.hashCode),
                    handToBoardHeightRatio.hashCode),
                assetSrc.hashCode),
            defaultLeftGripHold.hashCode),
        defaultRightGripHold.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Board')
          ..add('manufacturer', manufacturer)
          ..add('model', model)
          ..add('size', size)
          ..add('aspectRatio', aspectRatio)
          ..add('boardHolds', boardHolds)
          ..add('handToBoardHeightRatio', handToBoardHeightRatio)
          ..add('assetSrc', assetSrc)
          ..add('defaultLeftGripHold', defaultLeftGripHold)
          ..add('defaultRightGripHold', defaultRightGripHold))
        .toString();
  }
}

class BoardBuilder implements Builder<Board, BoardBuilder> {
  _$Board _$v;

  String _manufacturer;
  String get manufacturer => _$this._manufacturer;
  set manufacturer(String manufacturer) => _$this._manufacturer = manufacturer;

  String _model;
  String get model => _$this._model;
  set model(String model) => _$this._model = model;

  Size _size;
  Size get size => _$this._size;
  set size(Size size) => _$this._size = size;

  double _aspectRatio;
  double get aspectRatio => _$this._aspectRatio;
  set aspectRatio(double aspectRatio) => _$this._aspectRatio = aspectRatio;

  ListBuilder<BoardHold> _boardHolds;
  ListBuilder<BoardHold> get boardHolds =>
      _$this._boardHolds ??= new ListBuilder<BoardHold>();
  set boardHolds(ListBuilder<BoardHold> boardHolds) =>
      _$this._boardHolds = boardHolds;

  double _handToBoardHeightRatio;
  double get handToBoardHeightRatio => _$this._handToBoardHeightRatio;
  set handToBoardHeightRatio(double handToBoardHeightRatio) =>
      _$this._handToBoardHeightRatio = handToBoardHeightRatio;

  String _assetSrc;
  String get assetSrc => _$this._assetSrc;
  set assetSrc(String assetSrc) => _$this._assetSrc = assetSrc;

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
      _manufacturer = _$v.manufacturer;
      _model = _$v.model;
      _size = _$v.size;
      _aspectRatio = _$v.aspectRatio;
      _boardHolds = _$v.boardHolds?.toBuilder();
      _handToBoardHeightRatio = _$v.handToBoardHeightRatio;
      _assetSrc = _$v.assetSrc;
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
              manufacturer: manufacturer,
              model: model,
              size: size,
              aspectRatio: aspectRatio,
              boardHolds: boardHolds.build(),
              handToBoardHeightRatio: handToBoardHeightRatio,
              assetSrc: assetSrc,
              defaultLeftGripHold: defaultLeftGripHold.build(),
              defaultRightGripHold: defaultRightGripHold.build());
    } catch (_) {
      String _$failedField;
      try {
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
