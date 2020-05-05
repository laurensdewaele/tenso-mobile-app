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
      'type',
      serializers.serialize(object.type,
          specifiedType: const FullType(HoldType)),
      'hangAnchorXPercent',
      serializers.serialize(object.hangAnchorXPercent,
          specifiedType: const FullType(double)),
      'hangAnchorYPercent',
      serializers.serialize(object.hangAnchorYPercent,
          specifiedType: const FullType(double)),
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
    ];
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
        case 'type':
          result.type = serializers.deserialize(value,
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
        case 'hangAnchorXPercent':
          result.hangAnchorXPercent = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'hangAnchorYPercent':
          result.hangAnchorYPercent = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
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
      }
    }

    return result.build();
  }
}

class _$BoardHold extends BoardHold {
  @override
  final int position;
  @override
  final HoldType type;
  @override
  final double depth;
  @override
  final int supportedFingers;
  @override
  final double sloperDegrees;
  @override
  final double hangAnchorXPercent;
  @override
  final double hangAnchorYPercent;
  @override
  final double topLeftXPercent;
  @override
  final double topLeftYPercent;
  @override
  final double widthPercent;
  @override
  final double heightPercent;

  factory _$BoardHold([void Function(BoardHoldBuilder) updates]) =>
      (new BoardHoldBuilder()..update(updates)).build();

  _$BoardHold._(
      {this.position,
      this.type,
      this.depth,
      this.supportedFingers,
      this.sloperDegrees,
      this.hangAnchorXPercent,
      this.hangAnchorYPercent,
      this.topLeftXPercent,
      this.topLeftYPercent,
      this.widthPercent,
      this.heightPercent})
      : super._() {
    if (position == null) {
      throw new BuiltValueNullFieldError('BoardHold', 'position');
    }
    if (type == null) {
      throw new BuiltValueNullFieldError('BoardHold', 'type');
    }
    if (hangAnchorXPercent == null) {
      throw new BuiltValueNullFieldError('BoardHold', 'hangAnchorXPercent');
    }
    if (hangAnchorYPercent == null) {
      throw new BuiltValueNullFieldError('BoardHold', 'hangAnchorYPercent');
    }
    if (topLeftXPercent == null) {
      throw new BuiltValueNullFieldError('BoardHold', 'topLeftXPercent');
    }
    if (topLeftYPercent == null) {
      throw new BuiltValueNullFieldError('BoardHold', 'topLeftYPercent');
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
        type == other.type &&
        depth == other.depth &&
        supportedFingers == other.supportedFingers &&
        sloperDegrees == other.sloperDegrees &&
        hangAnchorXPercent == other.hangAnchorXPercent &&
        hangAnchorYPercent == other.hangAnchorYPercent &&
        topLeftXPercent == other.topLeftXPercent &&
        topLeftYPercent == other.topLeftYPercent &&
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
                                            type.hashCode),
                                        depth.hashCode),
                                    supportedFingers.hashCode),
                                sloperDegrees.hashCode),
                            hangAnchorXPercent.hashCode),
                        hangAnchorYPercent.hashCode),
                    topLeftXPercent.hashCode),
                topLeftYPercent.hashCode),
            widthPercent.hashCode),
        heightPercent.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('BoardHold')
          ..add('position', position)
          ..add('type', type)
          ..add('depth', depth)
          ..add('supportedFingers', supportedFingers)
          ..add('sloperDegrees', sloperDegrees)
          ..add('hangAnchorXPercent', hangAnchorXPercent)
          ..add('hangAnchorYPercent', hangAnchorYPercent)
          ..add('topLeftXPercent', topLeftXPercent)
          ..add('topLeftYPercent', topLeftYPercent)
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

  HoldType _type;
  HoldType get type => _$this._type;
  set type(HoldType type) => _$this._type = type;

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

  double _hangAnchorXPercent;
  double get hangAnchorXPercent => _$this._hangAnchorXPercent;
  set hangAnchorXPercent(double hangAnchorXPercent) =>
      _$this._hangAnchorXPercent = hangAnchorXPercent;

  double _hangAnchorYPercent;
  double get hangAnchorYPercent => _$this._hangAnchorYPercent;
  set hangAnchorYPercent(double hangAnchorYPercent) =>
      _$this._hangAnchorYPercent = hangAnchorYPercent;

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

  BoardHoldBuilder();

  BoardHoldBuilder get _$this {
    if (_$v != null) {
      _position = _$v.position;
      _type = _$v.type;
      _depth = _$v.depth;
      _supportedFingers = _$v.supportedFingers;
      _sloperDegrees = _$v.sloperDegrees;
      _hangAnchorXPercent = _$v.hangAnchorXPercent;
      _hangAnchorYPercent = _$v.hangAnchorYPercent;
      _topLeftXPercent = _$v.topLeftXPercent;
      _topLeftYPercent = _$v.topLeftYPercent;
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
            type: type,
            depth: depth,
            supportedFingers: supportedFingers,
            sloperDegrees: sloperDegrees,
            hangAnchorXPercent: hangAnchorXPercent,
            hangAnchorYPercent: hangAnchorYPercent,
            topLeftXPercent: topLeftXPercent,
            topLeftYPercent: topLeftYPercent,
            widthPercent: widthPercent,
            heightPercent: heightPercent);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
