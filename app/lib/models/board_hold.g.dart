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
      'holdType',
      serializers.serialize(object.holdType,
          specifiedType: const FullType(HoldType)),
      'anchorLeftPercent',
      serializers.serialize(object.anchorLeftPercent,
          specifiedType: const FullType(double)),
      'anchorTopPercent',
      serializers.serialize(object.anchorTopPercent,
          specifiedType: const FullType(double)),
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
    ];
    if (object.position != null) {
      result
        ..add('position')
        ..add(serializers.serialize(object.position,
            specifiedType: const FullType(int)));
    }
    if (object.depth != null) {
      result
        ..add('depth')
        ..add(serializers.serialize(object.depth,
            specifiedType: const FullType(double)));
    }
    if (object.supportedFingers != null) {
      result
        ..add('supportedFingers')
        ..add(serializers.serialize(object.supportedFingers,
            specifiedType: const FullType(int)));
    }
    if (object.sloperDegrees != null) {
      result
        ..add('sloperDegrees')
        ..add(serializers.serialize(object.sloperDegrees,
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
        case 'depth':
          result.depth = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'supportedFingers':
          result.supportedFingers = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'sloperDegrees':
          result.sloperDegrees = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'anchorLeftPercent':
          result.anchorLeftPercent = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'anchorTopPercent':
          result.anchorTopPercent = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
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
  final double depth;
  @override
  final int supportedFingers;
  @override
  final double sloperDegrees;
  @override
  final double anchorLeftPercent;
  @override
  final double anchorTopPercent;
  @override
  final double leftPercent;
  @override
  final double topPercent;
  @override
  final double widthPercent;
  @override
  final double heightPercent;

  factory _$BoardHold([void Function(BoardHoldBuilder) updates]) =>
      (new BoardHoldBuilder()..update(updates)).build();

  _$BoardHold._(
      {this.position,
      this.holdType,
      this.depth,
      this.supportedFingers,
      this.sloperDegrees,
      this.anchorLeftPercent,
      this.anchorTopPercent,
      this.leftPercent,
      this.topPercent,
      this.widthPercent,
      this.heightPercent})
      : super._() {
    if (holdType == null) {
      throw new BuiltValueNullFieldError('BoardHold', 'holdType');
    }
    if (anchorLeftPercent == null) {
      throw new BuiltValueNullFieldError('BoardHold', 'anchorLeftPercent');
    }
    if (anchorTopPercent == null) {
      throw new BuiltValueNullFieldError('BoardHold', 'anchorTopPercent');
    }
    if (leftPercent == null) {
      throw new BuiltValueNullFieldError('BoardHold', 'leftPercent');
    }
    if (topPercent == null) {
      throw new BuiltValueNullFieldError('BoardHold', 'topPercent');
    }
    if (widthPercent == null) {
      throw new BuiltValueNullFieldError('BoardHold', 'widthPercent');
    }
    if (heightPercent == null) {
      throw new BuiltValueNullFieldError('BoardHold', 'heightPercent');
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
        depth == other.depth &&
        supportedFingers == other.supportedFingers &&
        sloperDegrees == other.sloperDegrees &&
        anchorLeftPercent == other.anchorLeftPercent &&
        anchorTopPercent == other.anchorTopPercent &&
        leftPercent == other.leftPercent &&
        topPercent == other.topPercent &&
        widthPercent == other.widthPercent &&
        heightPercent == other.heightPercent;
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
                                        $jc($jc(0, position.hashCode),
                                            holdType.hashCode),
                                        depth.hashCode),
                                    supportedFingers.hashCode),
                                sloperDegrees.hashCode),
                            anchorLeftPercent.hashCode),
                        anchorTopPercent.hashCode),
                    leftPercent.hashCode),
                topPercent.hashCode),
            widthPercent.hashCode),
        heightPercent.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('BoardHold')
          ..add('position', position)
          ..add('holdType', holdType)
          ..add('depth', depth)
          ..add('supportedFingers', supportedFingers)
          ..add('sloperDegrees', sloperDegrees)
          ..add('anchorLeftPercent', anchorLeftPercent)
          ..add('anchorTopPercent', anchorTopPercent)
          ..add('leftPercent', leftPercent)
          ..add('topPercent', topPercent)
          ..add('widthPercent', widthPercent)
          ..add('heightPercent', heightPercent))
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

  double _depth;
  double get depth => _$this._depth;
  set depth(double depth) => _$this._depth = depth;

  int _supportedFingers;
  int get supportedFingers => _$this._supportedFingers;
  set supportedFingers(int supportedFingers) =>
      _$this._supportedFingers = supportedFingers;

  double _sloperDegrees;
  double get sloperDegrees => _$this._sloperDegrees;
  set sloperDegrees(double sloperDegrees) =>
      _$this._sloperDegrees = sloperDegrees;

  double _anchorLeftPercent;
  double get anchorLeftPercent => _$this._anchorLeftPercent;
  set anchorLeftPercent(double anchorLeftPercent) =>
      _$this._anchorLeftPercent = anchorLeftPercent;

  double _anchorTopPercent;
  double get anchorTopPercent => _$this._anchorTopPercent;
  set anchorTopPercent(double anchorTopPercent) =>
      _$this._anchorTopPercent = anchorTopPercent;

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

  BoardHoldBuilder();

  BoardHoldBuilder get _$this {
    if (_$v != null) {
      _position = _$v.position;
      _holdType = _$v.holdType;
      _depth = _$v.depth;
      _supportedFingers = _$v.supportedFingers;
      _sloperDegrees = _$v.sloperDegrees;
      _anchorLeftPercent = _$v.anchorLeftPercent;
      _anchorTopPercent = _$v.anchorTopPercent;
      _leftPercent = _$v.leftPercent;
      _topPercent = _$v.topPercent;
      _widthPercent = _$v.widthPercent;
      _heightPercent = _$v.heightPercent;
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
            depth: depth,
            supportedFingers: supportedFingers,
            sloperDegrees: sloperDegrees,
            anchorLeftPercent: anchorLeftPercent,
            anchorTopPercent: anchorTopPercent,
            leftPercent: leftPercent,
            topPercent: topPercent,
            widthPercent: widthPercent,
            heightPercent: heightPercent);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
