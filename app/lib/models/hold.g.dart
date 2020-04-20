// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hold.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Hold> _$holdSerializer = new _$HoldSerializer();

class _$HoldSerializer implements StructuredSerializer<Hold> {
  @override
  final Iterable<Type> types = const [Hold, _$Hold];
  @override
  final String wireName = 'Hold';

  @override
  Iterable<Object> serialize(Serializers serializers, Hold object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'handHold',
      serializers.serialize(object.handHold,
          specifiedType: const FullType(HandHold)),
      'repetitions',
      serializers.serialize(object.repetitions,
          specifiedType: const FullType(int)),
      'hangTime',
      serializers.serialize(object.hangTime,
          specifiedType: const FullType(int)),
      'addedWeight',
      serializers.serialize(object.addedWeight,
          specifiedType: const FullType(double)),
    ];
    if (object.leftGrip != null) {
      result
        ..add('leftGrip')
        ..add(serializers.serialize(object.leftGrip,
            specifiedType: const FullType(Grip)));
    }
    if (object.rightGrip != null) {
      result
        ..add('rightGrip')
        ..add(serializers.serialize(object.rightGrip,
            specifiedType: const FullType(Grip)));
    }
    if (object.leftGripBoardHold != null) {
      result
        ..add('leftGripBoardHold')
        ..add(serializers.serialize(object.leftGripBoardHold,
            specifiedType: const FullType(BoardHold)));
    }
    if (object.rightGripBoardHold != null) {
      result
        ..add('rightGripBoardHold')
        ..add(serializers.serialize(object.rightGripBoardHold,
            specifiedType: const FullType(BoardHold)));
    }
    if (object.restBetweenRepetitions != null) {
      result
        ..add('restBetweenRepetitions')
        ..add(serializers.serialize(object.restBetweenRepetitions,
            specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  Hold deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new HoldBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'leftGrip':
          result.leftGrip.replace(serializers.deserialize(value,
              specifiedType: const FullType(Grip)) as Grip);
          break;
        case 'rightGrip':
          result.rightGrip.replace(serializers.deserialize(value,
              specifiedType: const FullType(Grip)) as Grip);
          break;
        case 'handHold':
          result.handHold = serializers.deserialize(value,
              specifiedType: const FullType(HandHold)) as HandHold;
          break;
        case 'leftGripBoardHold':
          result.leftGripBoardHold.replace(serializers.deserialize(value,
              specifiedType: const FullType(BoardHold)) as BoardHold);
          break;
        case 'rightGripBoardHold':
          result.rightGripBoardHold.replace(serializers.deserialize(value,
              specifiedType: const FullType(BoardHold)) as BoardHold);
          break;
        case 'repetitions':
          result.repetitions = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'restBetweenRepetitions':
          result.restBetweenRepetitions = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'hangTime':
          result.hangTime = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'addedWeight':
          result.addedWeight = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
      }
    }

    return result.build();
  }
}

class _$Hold extends Hold {
  @override
  final Grip leftGrip;
  @override
  final Grip rightGrip;
  @override
  final HandHold handHold;
  @override
  final BoardHold leftGripBoardHold;
  @override
  final BoardHold rightGripBoardHold;
  @override
  final int repetitions;
  @override
  final int restBetweenRepetitions;
  @override
  final int hangTime;
  @override
  final double addedWeight;

  factory _$Hold([void Function(HoldBuilder) updates]) =>
      (new HoldBuilder()..update(updates)).build();

  _$Hold._(
      {this.leftGrip,
      this.rightGrip,
      this.handHold,
      this.leftGripBoardHold,
      this.rightGripBoardHold,
      this.repetitions,
      this.restBetweenRepetitions,
      this.hangTime,
      this.addedWeight})
      : super._() {
    if (handHold == null) {
      throw new BuiltValueNullFieldError('Hold', 'handHold');
    }
    if (repetitions == null) {
      throw new BuiltValueNullFieldError('Hold', 'repetitions');
    }
    if (hangTime == null) {
      throw new BuiltValueNullFieldError('Hold', 'hangTime');
    }
    if (addedWeight == null) {
      throw new BuiltValueNullFieldError('Hold', 'addedWeight');
    }
  }

  @override
  Hold rebuild(void Function(HoldBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HoldBuilder toBuilder() => new HoldBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hold &&
        leftGrip == other.leftGrip &&
        rightGrip == other.rightGrip &&
        handHold == other.handHold &&
        leftGripBoardHold == other.leftGripBoardHold &&
        rightGripBoardHold == other.rightGripBoardHold &&
        repetitions == other.repetitions &&
        restBetweenRepetitions == other.restBetweenRepetitions &&
        hangTime == other.hangTime &&
        addedWeight == other.addedWeight;
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
                                $jc($jc(0, leftGrip.hashCode),
                                    rightGrip.hashCode),
                                handHold.hashCode),
                            leftGripBoardHold.hashCode),
                        rightGripBoardHold.hashCode),
                    repetitions.hashCode),
                restBetweenRepetitions.hashCode),
            hangTime.hashCode),
        addedWeight.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Hold')
          ..add('leftGrip', leftGrip)
          ..add('rightGrip', rightGrip)
          ..add('handHold', handHold)
          ..add('leftGripBoardHold', leftGripBoardHold)
          ..add('rightGripBoardHold', rightGripBoardHold)
          ..add('repetitions', repetitions)
          ..add('restBetweenRepetitions', restBetweenRepetitions)
          ..add('hangTime', hangTime)
          ..add('addedWeight', addedWeight))
        .toString();
  }
}

class HoldBuilder implements Builder<Hold, HoldBuilder> {
  _$Hold _$v;

  GripBuilder _leftGrip;
  GripBuilder get leftGrip => _$this._leftGrip ??= new GripBuilder();
  set leftGrip(GripBuilder leftGrip) => _$this._leftGrip = leftGrip;

  GripBuilder _rightGrip;
  GripBuilder get rightGrip => _$this._rightGrip ??= new GripBuilder();
  set rightGrip(GripBuilder rightGrip) => _$this._rightGrip = rightGrip;

  HandHold _handHold;
  HandHold get handHold => _$this._handHold;
  set handHold(HandHold handHold) => _$this._handHold = handHold;

  BoardHoldBuilder _leftGripBoardHold;
  BoardHoldBuilder get leftGripBoardHold =>
      _$this._leftGripBoardHold ??= new BoardHoldBuilder();
  set leftGripBoardHold(BoardHoldBuilder leftGripBoardHold) =>
      _$this._leftGripBoardHold = leftGripBoardHold;

  BoardHoldBuilder _rightGripBoardHold;
  BoardHoldBuilder get rightGripBoardHold =>
      _$this._rightGripBoardHold ??= new BoardHoldBuilder();
  set rightGripBoardHold(BoardHoldBuilder rightGripBoardHold) =>
      _$this._rightGripBoardHold = rightGripBoardHold;

  int _repetitions;
  int get repetitions => _$this._repetitions;
  set repetitions(int repetitions) => _$this._repetitions = repetitions;

  int _restBetweenRepetitions;
  int get restBetweenRepetitions => _$this._restBetweenRepetitions;
  set restBetweenRepetitions(int restBetweenRepetitions) =>
      _$this._restBetweenRepetitions = restBetweenRepetitions;

  int _hangTime;
  int get hangTime => _$this._hangTime;
  set hangTime(int hangTime) => _$this._hangTime = hangTime;

  double _addedWeight;
  double get addedWeight => _$this._addedWeight;
  set addedWeight(double addedWeight) => _$this._addedWeight = addedWeight;

  HoldBuilder();

  HoldBuilder get _$this {
    if (_$v != null) {
      _leftGrip = _$v.leftGrip?.toBuilder();
      _rightGrip = _$v.rightGrip?.toBuilder();
      _handHold = _$v.handHold;
      _leftGripBoardHold = _$v.leftGripBoardHold?.toBuilder();
      _rightGripBoardHold = _$v.rightGripBoardHold?.toBuilder();
      _repetitions = _$v.repetitions;
      _restBetweenRepetitions = _$v.restBetweenRepetitions;
      _hangTime = _$v.hangTime;
      _addedWeight = _$v.addedWeight;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hold other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Hold;
  }

  @override
  void update(void Function(HoldBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Hold build() {
    _$Hold _$result;
    try {
      _$result = _$v ??
          new _$Hold._(
              leftGrip: _leftGrip?.build(),
              rightGrip: _rightGrip?.build(),
              handHold: handHold,
              leftGripBoardHold: _leftGripBoardHold?.build(),
              rightGripBoardHold: _rightGripBoardHold?.build(),
              repetitions: repetitions,
              restBetweenRepetitions: restBetweenRepetitions,
              hangTime: hangTime,
              addedWeight: addedWeight);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'leftGrip';
        _leftGrip?.build();
        _$failedField = 'rightGrip';
        _rightGrip?.build();

        _$failedField = 'leftGripBoardHold';
        _leftGripBoardHold?.build();
        _$failedField = 'rightGripBoardHold';
        _rightGripBoardHold?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Hold', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
