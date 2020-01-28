// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_hold.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<BoardHold> _$boardHoldSerializer = new _$BoardHoldSerializer();

class _$BoardHoldSerializer implements StructuredSerializer<BoardHold> {
  @override
  final Iterable<Type> types = const [BoardHold, _$BoardHold];
  @override
  final String wireName = 'BoardHold';

  @override
  Iterable<Object> serialize(Serializers serializers, BoardHold object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'position',
      serializers.serialize(object.position,
          specifiedType: const FullType(int)),
      'rect',
      serializers.serialize(object.rect, specifiedType: const FullType(Rect)),
      'holdType',
      serializers.serialize(object.holdType,
          specifiedType: const FullType(HoldType)),
      'maxAllowedFingers',
      serializers.serialize(object.maxAllowedFingers,
          specifiedType: const FullType(int)),
      'boardSize',
      serializers.serialize(object.boardSize,
          specifiedType: const FullType(Size)),
      'dxHangAnchor',
      serializers.serialize(object.dxHangAnchor,
          specifiedType: const FullType(double)),
      'dyHangAnchor',
      serializers.serialize(object.dyHangAnchor,
          specifiedType: const FullType(double)),
    ];
    if (object.sloperDegrees != null) {
      result
        ..add('sloperDegrees')
        ..add(serializers.serialize(object.sloperDegrees,
            specifiedType: const FullType(double)));
    }
    if (object.pocketDepth != null) {
      result
        ..add('pocketDepth')
        ..add(serializers.serialize(object.pocketDepth,
            specifiedType: const FullType(double)));
    }
    return result;
  }

  @override
  BoardHold deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BoardHoldBuilder();

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
        case 'rect':
          result.rect = serializers.deserialize(value,
              specifiedType: const FullType(Rect)) as Rect;
          break;
        case 'holdType':
          result.holdType = serializers.deserialize(value,
              specifiedType: const FullType(HoldType)) as HoldType;
          break;
        case 'maxAllowedFingers':
          result.maxAllowedFingers = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'boardSize':
          result.boardSize = serializers.deserialize(value,
              specifiedType: const FullType(Size)) as Size;
          break;
        case 'sloperDegrees':
          result.sloperDegrees = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'pocketDepth':
          result.pocketDepth = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'dxHangAnchor':
          result.dxHangAnchor = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'dyHangAnchor':
          result.dyHangAnchor = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
      }
    }

    return result.build();
  }
}

class _$BoardHold extends BoardHold {
  @override
  final int position;
  @override
  final Rect rect;
  @override
  final HoldType holdType;
  @override
  final int maxAllowedFingers;
  @override
  final Size boardSize;
  @override
  final double sloperDegrees;
  @override
  final double pocketDepth;
  @override
  final double dxHangAnchor;
  @override
  final double dyHangAnchor;

  factory _$BoardHold([void Function(BoardHoldBuilder) updates]) =>
      (new BoardHoldBuilder()..update(updates)).build();

  _$BoardHold._(
      {this.position,
      this.rect,
      this.holdType,
      this.maxAllowedFingers,
      this.boardSize,
      this.sloperDegrees,
      this.pocketDepth,
      this.dxHangAnchor,
      this.dyHangAnchor})
      : super._() {
    if (position == null) {
      throw new BuiltValueNullFieldError('BoardHold', 'position');
    }
    if (rect == null) {
      throw new BuiltValueNullFieldError('BoardHold', 'rect');
    }
    if (holdType == null) {
      throw new BuiltValueNullFieldError('BoardHold', 'holdType');
    }
    if (maxAllowedFingers == null) {
      throw new BuiltValueNullFieldError('BoardHold', 'maxAllowedFingers');
    }
    if (boardSize == null) {
      throw new BuiltValueNullFieldError('BoardHold', 'boardSize');
    }
    if (dxHangAnchor == null) {
      throw new BuiltValueNullFieldError('BoardHold', 'dxHangAnchor');
    }
    if (dyHangAnchor == null) {
      throw new BuiltValueNullFieldError('BoardHold', 'dyHangAnchor');
    }
  }

  @override
  BoardHold rebuild(void Function(BoardHoldBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BoardHoldBuilder toBuilder() => new BoardHoldBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BoardHold &&
        position == other.position &&
        rect == other.rect &&
        holdType == other.holdType &&
        maxAllowedFingers == other.maxAllowedFingers &&
        boardSize == other.boardSize &&
        sloperDegrees == other.sloperDegrees &&
        pocketDepth == other.pocketDepth &&
        dxHangAnchor == other.dxHangAnchor &&
        dyHangAnchor == other.dyHangAnchor;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc($jc($jc(0, position.hashCode), rect.hashCode),
                                holdType.hashCode),
                            maxAllowedFingers.hashCode),
                        boardSize.hashCode),
                    sloperDegrees.hashCode),
                pocketDepth.hashCode),
            dxHangAnchor.hashCode),
        dyHangAnchor.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('BoardHold')
          ..add('position', position)
          ..add('rect', rect)
          ..add('holdType', holdType)
          ..add('maxAllowedFingers', maxAllowedFingers)
          ..add('boardSize', boardSize)
          ..add('sloperDegrees', sloperDegrees)
          ..add('pocketDepth', pocketDepth)
          ..add('dxHangAnchor', dxHangAnchor)
          ..add('dyHangAnchor', dyHangAnchor))
        .toString();
  }
}

class BoardHoldBuilder implements Builder<BoardHold, BoardHoldBuilder> {
  _$BoardHold _$v;

  int _position;
  int get position => _$this._position;
  set position(int position) => _$this._position = position;

  Rect _rect;
  Rect get rect => _$this._rect;
  set rect(Rect rect) => _$this._rect = rect;

  HoldType _holdType;
  HoldType get holdType => _$this._holdType;
  set holdType(HoldType holdType) => _$this._holdType = holdType;

  int _maxAllowedFingers;
  int get maxAllowedFingers => _$this._maxAllowedFingers;
  set maxAllowedFingers(int maxAllowedFingers) =>
      _$this._maxAllowedFingers = maxAllowedFingers;

  Size _boardSize;
  Size get boardSize => _$this._boardSize;
  set boardSize(Size boardSize) => _$this._boardSize = boardSize;

  double _sloperDegrees;
  double get sloperDegrees => _$this._sloperDegrees;
  set sloperDegrees(double sloperDegrees) =>
      _$this._sloperDegrees = sloperDegrees;

  double _pocketDepth;
  double get pocketDepth => _$this._pocketDepth;
  set pocketDepth(double pocketDepth) => _$this._pocketDepth = pocketDepth;

  double _dxHangAnchor;
  double get dxHangAnchor => _$this._dxHangAnchor;
  set dxHangAnchor(double dxHangAnchor) => _$this._dxHangAnchor = dxHangAnchor;

  double _dyHangAnchor;
  double get dyHangAnchor => _$this._dyHangAnchor;
  set dyHangAnchor(double dyHangAnchor) => _$this._dyHangAnchor = dyHangAnchor;

  BoardHoldBuilder();

  BoardHoldBuilder get _$this {
    if (_$v != null) {
      _position = _$v.position;
      _rect = _$v.rect;
      _holdType = _$v.holdType;
      _maxAllowedFingers = _$v.maxAllowedFingers;
      _boardSize = _$v.boardSize;
      _sloperDegrees = _$v.sloperDegrees;
      _pocketDepth = _$v.pocketDepth;
      _dxHangAnchor = _$v.dxHangAnchor;
      _dyHangAnchor = _$v.dyHangAnchor;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BoardHold other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$BoardHold;
  }

  @override
  void update(void Function(BoardHoldBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$BoardHold build() {
    final _$result = _$v ??
        new _$BoardHold._(
            position: position,
            rect: rect,
            holdType: holdType,
            maxAllowedFingers: maxAllowedFingers,
            boardSize: boardSize,
            sloperDegrees: sloperDegrees,
            pocketDepth: pocketDepth,
            dxHangAnchor: dxHangAnchor,
            dyHangAnchor: dyHangAnchor);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
