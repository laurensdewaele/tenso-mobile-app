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
      'holdType',
      serializers.serialize(object.holdType,
          specifiedType: const FullType(HoldType)),
      'maxAllowedFingers',
      serializers.serialize(object.maxAllowedFingers,
          specifiedType: const FullType(int)),
      'dxRelativeHangAnchor',
      serializers.serialize(object.dxRelativeHangAnchor,
          specifiedType: const FullType(double)),
      'dyRelativeHangAnchor',
      serializers.serialize(object.dyRelativeHangAnchor,
          specifiedType: const FullType(double)),
      'relativeLeft',
      serializers.serialize(object.relativeLeft,
          specifiedType: const FullType(double)),
      'relativeTop',
      serializers.serialize(object.relativeTop,
          specifiedType: const FullType(double)),
      'relativeWidth',
      serializers.serialize(object.relativeWidth,
          specifiedType: const FullType(double)),
      'relativeHeight',
      serializers.serialize(object.relativeHeight,
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
    if (object.edgeDepth != null) {
      result
        ..add('edgeDepth')
        ..add(serializers.serialize(object.edgeDepth,
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
        case 'holdType':
          result.holdType = serializers.deserialize(value,
              specifiedType: const FullType(HoldType)) as HoldType;
          break;
        case 'maxAllowedFingers':
          result.maxAllowedFingers = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'sloperDegrees':
          result.sloperDegrees = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'pocketDepth':
          result.pocketDepth = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'edgeDepth':
          result.edgeDepth = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'dxRelativeHangAnchor':
          result.dxRelativeHangAnchor = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'dyRelativeHangAnchor':
          result.dyRelativeHangAnchor = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'relativeLeft':
          result.relativeLeft = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'relativeTop':
          result.relativeTop = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'relativeWidth':
          result.relativeWidth = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'relativeHeight':
          result.relativeHeight = serializers.deserialize(value,
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
  final HoldType holdType;
  @override
  final int maxAllowedFingers;
  @override
  final double sloperDegrees;
  @override
  final double pocketDepth;
  @override
  final double edgeDepth;
  @override
  final double dxRelativeHangAnchor;
  @override
  final double dyRelativeHangAnchor;
  @override
  final double relativeLeft;
  @override
  final double relativeTop;
  @override
  final double relativeWidth;
  @override
  final double relativeHeight;

  factory _$BoardHold([void Function(BoardHoldBuilder) updates]) =>
      (new BoardHoldBuilder()..update(updates)).build();

  _$BoardHold._(
      {this.position,
      this.holdType,
      this.maxAllowedFingers,
      this.sloperDegrees,
      this.pocketDepth,
      this.edgeDepth,
      this.dxRelativeHangAnchor,
      this.dyRelativeHangAnchor,
      this.relativeLeft,
      this.relativeTop,
      this.relativeWidth,
      this.relativeHeight})
      : super._() {
    if (position == null) {
      throw new BuiltValueNullFieldError('BoardHold', 'position');
    }
    if (holdType == null) {
      throw new BuiltValueNullFieldError('BoardHold', 'holdType');
    }
    if (maxAllowedFingers == null) {
      throw new BuiltValueNullFieldError('BoardHold', 'maxAllowedFingers');
    }
    if (dxRelativeHangAnchor == null) {
      throw new BuiltValueNullFieldError('BoardHold', 'dxRelativeHangAnchor');
    }
    if (dyRelativeHangAnchor == null) {
      throw new BuiltValueNullFieldError('BoardHold', 'dyRelativeHangAnchor');
    }
    if (relativeLeft == null) {
      throw new BuiltValueNullFieldError('BoardHold', 'relativeLeft');
    }
    if (relativeTop == null) {
      throw new BuiltValueNullFieldError('BoardHold', 'relativeTop');
    }
    if (relativeWidth == null) {
      throw new BuiltValueNullFieldError('BoardHold', 'relativeWidth');
    }
    if (relativeHeight == null) {
      throw new BuiltValueNullFieldError('BoardHold', 'relativeHeight');
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
        holdType == other.holdType &&
        maxAllowedFingers == other.maxAllowedFingers &&
        sloperDegrees == other.sloperDegrees &&
        pocketDepth == other.pocketDepth &&
        edgeDepth == other.edgeDepth &&
        dxRelativeHangAnchor == other.dxRelativeHangAnchor &&
        dyRelativeHangAnchor == other.dyRelativeHangAnchor &&
        relativeLeft == other.relativeLeft &&
        relativeTop == other.relativeTop &&
        relativeWidth == other.relativeWidth &&
        relativeHeight == other.relativeHeight;
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
                                            $jc($jc(0, position.hashCode),
                                                holdType.hashCode),
                                            maxAllowedFingers.hashCode),
                                        sloperDegrees.hashCode),
                                    pocketDepth.hashCode),
                                edgeDepth.hashCode),
                            dxRelativeHangAnchor.hashCode),
                        dyRelativeHangAnchor.hashCode),
                    relativeLeft.hashCode),
                relativeTop.hashCode),
            relativeWidth.hashCode),
        relativeHeight.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('BoardHold')
          ..add('position', position)
          ..add('holdType', holdType)
          ..add('maxAllowedFingers', maxAllowedFingers)
          ..add('sloperDegrees', sloperDegrees)
          ..add('pocketDepth', pocketDepth)
          ..add('edgeDepth', edgeDepth)
          ..add('dxRelativeHangAnchor', dxRelativeHangAnchor)
          ..add('dyRelativeHangAnchor', dyRelativeHangAnchor)
          ..add('relativeLeft', relativeLeft)
          ..add('relativeTop', relativeTop)
          ..add('relativeWidth', relativeWidth)
          ..add('relativeHeight', relativeHeight))
        .toString();
  }
}

class BoardHoldBuilder implements Builder<BoardHold, BoardHoldBuilder> {
  _$BoardHold _$v;

  int _position;
  int get position => _$this._position;
  set position(int position) => _$this._position = position;

  HoldType _holdType;
  HoldType get holdType => _$this._holdType;
  set holdType(HoldType holdType) => _$this._holdType = holdType;

  int _maxAllowedFingers;
  int get maxAllowedFingers => _$this._maxAllowedFingers;
  set maxAllowedFingers(int maxAllowedFingers) =>
      _$this._maxAllowedFingers = maxAllowedFingers;

  double _sloperDegrees;
  double get sloperDegrees => _$this._sloperDegrees;
  set sloperDegrees(double sloperDegrees) =>
      _$this._sloperDegrees = sloperDegrees;

  double _pocketDepth;
  double get pocketDepth => _$this._pocketDepth;
  set pocketDepth(double pocketDepth) => _$this._pocketDepth = pocketDepth;

  double _edgeDepth;
  double get edgeDepth => _$this._edgeDepth;
  set edgeDepth(double edgeDepth) => _$this._edgeDepth = edgeDepth;

  double _dxRelativeHangAnchor;
  double get dxRelativeHangAnchor => _$this._dxRelativeHangAnchor;
  set dxRelativeHangAnchor(double dxRelativeHangAnchor) =>
      _$this._dxRelativeHangAnchor = dxRelativeHangAnchor;

  double _dyRelativeHangAnchor;
  double get dyRelativeHangAnchor => _$this._dyRelativeHangAnchor;
  set dyRelativeHangAnchor(double dyRelativeHangAnchor) =>
      _$this._dyRelativeHangAnchor = dyRelativeHangAnchor;

  double _relativeLeft;
  double get relativeLeft => _$this._relativeLeft;
  set relativeLeft(double relativeLeft) => _$this._relativeLeft = relativeLeft;

  double _relativeTop;
  double get relativeTop => _$this._relativeTop;
  set relativeTop(double relativeTop) => _$this._relativeTop = relativeTop;

  double _relativeWidth;
  double get relativeWidth => _$this._relativeWidth;
  set relativeWidth(double relativeWidth) =>
      _$this._relativeWidth = relativeWidth;

  double _relativeHeight;
  double get relativeHeight => _$this._relativeHeight;
  set relativeHeight(double relativeHeight) =>
      _$this._relativeHeight = relativeHeight;

  BoardHoldBuilder();

  BoardHoldBuilder get _$this {
    if (_$v != null) {
      _position = _$v.position;
      _holdType = _$v.holdType;
      _maxAllowedFingers = _$v.maxAllowedFingers;
      _sloperDegrees = _$v.sloperDegrees;
      _pocketDepth = _$v.pocketDepth;
      _edgeDepth = _$v.edgeDepth;
      _dxRelativeHangAnchor = _$v.dxRelativeHangAnchor;
      _dyRelativeHangAnchor = _$v.dyRelativeHangAnchor;
      _relativeLeft = _$v.relativeLeft;
      _relativeTop = _$v.relativeTop;
      _relativeWidth = _$v.relativeWidth;
      _relativeHeight = _$v.relativeHeight;
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
            holdType: holdType,
            maxAllowedFingers: maxAllowedFingers,
            sloperDegrees: sloperDegrees,
            pocketDepth: pocketDepth,
            edgeDepth: edgeDepth,
            dxRelativeHangAnchor: dxRelativeHangAnchor,
            dyRelativeHangAnchor: dyRelativeHangAnchor,
            relativeLeft: relativeLeft,
            relativeTop: relativeTop,
            relativeWidth: relativeWidth,
            relativeHeight: relativeHeight);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
