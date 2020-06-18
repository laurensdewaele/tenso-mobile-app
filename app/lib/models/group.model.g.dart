// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Group> _$groupSerializer = new _$GroupSerializer();

class _$GroupSerializer implements StructuredSerializer<Group> {
  @override
  final Iterable<Type> types = const [Group, _$Group];
  @override
  final String wireName = 'Group';

  @override
  Iterable<Object> serialize(Serializers serializers, Group object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'board',
      serializers.serialize(object.board, specifiedType: const FullType(Board)),
      'handHold',
      serializers.serialize(object.handHold,
          specifiedType: const FullType(HandHold)),
      'repeaters',
      serializers.serialize(object.repeaters,
          specifiedType: const FullType(bool)),
      'repetitions',
      serializers.serialize(object.repetitions,
          specifiedType: const FullType(int)),
      'hangTimeS',
      serializers.serialize(object.hangTimeS,
          specifiedType: const FullType(int)),
      'restBetweenRepsFixed',
      serializers.serialize(object.restBetweenRepsFixed,
          specifiedType: const FullType(bool)),
      'restBetweenRepsS',
      serializers.serialize(object.restBetweenRepsS,
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
    if (object.sets != null) {
      result
        ..add('sets')
        ..add(serializers.serialize(object.sets,
            specifiedType: const FullType(int)));
    }
    if (object.restBetweenSetsFixed != null) {
      result
        ..add('restBetweenSetsFixed')
        ..add(serializers.serialize(object.restBetweenSetsFixed,
            specifiedType: const FullType(bool)));
    }
    if (object.restBetweenSetsS != null) {
      result
        ..add('restBetweenSetsS')
        ..add(serializers.serialize(object.restBetweenSetsS,
            specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  Group deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GroupBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'board':
          result.board.replace(serializers.deserialize(value,
              specifiedType: const FullType(Board)) as Board);
          break;
        case 'handHold':
          result.handHold = serializers.deserialize(value,
              specifiedType: const FullType(HandHold)) as HandHold;
          break;
        case 'leftGrip':
          result.leftGrip.replace(serializers.deserialize(value,
              specifiedType: const FullType(Grip)) as Grip);
          break;
        case 'rightGrip':
          result.rightGrip.replace(serializers.deserialize(value,
              specifiedType: const FullType(Grip)) as Grip);
          break;
        case 'leftGripBoardHold':
          result.leftGripBoardHold.replace(serializers.deserialize(value,
              specifiedType: const FullType(BoardHold)) as BoardHold);
          break;
        case 'rightGripBoardHold':
          result.rightGripBoardHold.replace(serializers.deserialize(value,
              specifiedType: const FullType(BoardHold)) as BoardHold);
          break;
        case 'repeaters':
          result.repeaters = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'repetitions':
          result.repetitions = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'hangTimeS':
          result.hangTimeS = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'restBetweenRepsFixed':
          result.restBetweenRepsFixed = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'restBetweenRepsS':
          result.restBetweenRepsS = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'sets':
          result.sets = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'restBetweenSetsFixed':
          result.restBetweenSetsFixed = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'restBetweenSetsS':
          result.restBetweenSetsS = serializers.deserialize(value,
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

class _$Group extends Group {
  @override
  final Board board;
  @override
  final HandHold handHold;
  @override
  final Grip leftGrip;
  @override
  final Grip rightGrip;
  @override
  final BoardHold leftGripBoardHold;
  @override
  final BoardHold rightGripBoardHold;
  @override
  final bool repeaters;
  @override
  final int repetitions;
  @override
  final int hangTimeS;
  @override
  final bool restBetweenRepsFixed;
  @override
  final int restBetweenRepsS;
  @override
  final int sets;
  @override
  final bool restBetweenSetsFixed;
  @override
  final int restBetweenSetsS;
  @override
  final double addedWeight;

  factory _$Group([void Function(GroupBuilder) updates]) =>
      (new GroupBuilder()..update(updates)).build();

  _$Group._(
      {this.board,
      this.handHold,
      this.leftGrip,
      this.rightGrip,
      this.leftGripBoardHold,
      this.rightGripBoardHold,
      this.repeaters,
      this.repetitions,
      this.hangTimeS,
      this.restBetweenRepsFixed,
      this.restBetweenRepsS,
      this.sets,
      this.restBetweenSetsFixed,
      this.restBetweenSetsS,
      this.addedWeight})
      : super._() {
    if (board == null) {
      throw new BuiltValueNullFieldError('Group', 'board');
    }
    if (handHold == null) {
      throw new BuiltValueNullFieldError('Group', 'handHold');
    }
    if (repeaters == null) {
      throw new BuiltValueNullFieldError('Group', 'repeaters');
    }
    if (repetitions == null) {
      throw new BuiltValueNullFieldError('Group', 'repetitions');
    }
    if (hangTimeS == null) {
      throw new BuiltValueNullFieldError('Group', 'hangTimeS');
    }
    if (restBetweenRepsFixed == null) {
      throw new BuiltValueNullFieldError('Group', 'restBetweenRepsFixed');
    }
    if (restBetweenRepsS == null) {
      throw new BuiltValueNullFieldError('Group', 'restBetweenRepsS');
    }
    if (addedWeight == null) {
      throw new BuiltValueNullFieldError('Group', 'addedWeight');
    }
  }

  @override
  Group rebuild(void Function(GroupBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GroupBuilder toBuilder() => new GroupBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Group &&
        board == other.board &&
        handHold == other.handHold &&
        leftGrip == other.leftGrip &&
        rightGrip == other.rightGrip &&
        leftGripBoardHold == other.leftGripBoardHold &&
        rightGripBoardHold == other.rightGripBoardHold &&
        repeaters == other.repeaters &&
        repetitions == other.repetitions &&
        hangTimeS == other.hangTimeS &&
        restBetweenRepsFixed == other.restBetweenRepsFixed &&
        restBetweenRepsS == other.restBetweenRepsS &&
        sets == other.sets &&
        restBetweenSetsFixed == other.restBetweenSetsFixed &&
        restBetweenSetsS == other.restBetweenSetsS &&
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
                                $jc(
                                    $jc(
                                        $jc(
                                            $jc(
                                                $jc(
                                                    $jc(
                                                        $jc(
                                                            $jc(0,
                                                                board.hashCode),
                                                            handHold.hashCode),
                                                        leftGrip.hashCode),
                                                    rightGrip.hashCode),
                                                leftGripBoardHold.hashCode),
                                            rightGripBoardHold.hashCode),
                                        repeaters.hashCode),
                                    repetitions.hashCode),
                                hangTimeS.hashCode),
                            restBetweenRepsFixed.hashCode),
                        restBetweenRepsS.hashCode),
                    sets.hashCode),
                restBetweenSetsFixed.hashCode),
            restBetweenSetsS.hashCode),
        addedWeight.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Group')
          ..add('board', board)
          ..add('handHold', handHold)
          ..add('leftGrip', leftGrip)
          ..add('rightGrip', rightGrip)
          ..add('leftGripBoardHold', leftGripBoardHold)
          ..add('rightGripBoardHold', rightGripBoardHold)
          ..add('repeaters', repeaters)
          ..add('repetitions', repetitions)
          ..add('hangTimeS', hangTimeS)
          ..add('restBetweenRepsFixed', restBetweenRepsFixed)
          ..add('restBetweenRepsS', restBetweenRepsS)
          ..add('sets', sets)
          ..add('restBetweenSetsFixed', restBetweenSetsFixed)
          ..add('restBetweenSetsS', restBetweenSetsS)
          ..add('addedWeight', addedWeight))
        .toString();
  }
}

class GroupBuilder implements Builder<Group, GroupBuilder> {
  _$Group _$v;

  BoardBuilder _board;
  BoardBuilder get board => _$this._board ??= new BoardBuilder();
  set board(BoardBuilder board) => _$this._board = board;

  HandHold _handHold;
  HandHold get handHold => _$this._handHold;
  set handHold(HandHold handHold) => _$this._handHold = handHold;

  GripBuilder _leftGrip;
  GripBuilder get leftGrip => _$this._leftGrip ??= new GripBuilder();
  set leftGrip(GripBuilder leftGrip) => _$this._leftGrip = leftGrip;

  GripBuilder _rightGrip;
  GripBuilder get rightGrip => _$this._rightGrip ??= new GripBuilder();
  set rightGrip(GripBuilder rightGrip) => _$this._rightGrip = rightGrip;

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

  bool _repeaters;
  bool get repeaters => _$this._repeaters;
  set repeaters(bool repeaters) => _$this._repeaters = repeaters;

  int _repetitions;
  int get repetitions => _$this._repetitions;
  set repetitions(int repetitions) => _$this._repetitions = repetitions;

  int _hangTimeS;
  int get hangTimeS => _$this._hangTimeS;
  set hangTimeS(int hangTimeS) => _$this._hangTimeS = hangTimeS;

  bool _restBetweenRepsFixed;
  bool get restBetweenRepsFixed => _$this._restBetweenRepsFixed;
  set restBetweenRepsFixed(bool restBetweenRepsFixed) =>
      _$this._restBetweenRepsFixed = restBetweenRepsFixed;

  int _restBetweenRepsS;
  int get restBetweenRepsS => _$this._restBetweenRepsS;
  set restBetweenRepsS(int restBetweenRepsS) =>
      _$this._restBetweenRepsS = restBetweenRepsS;

  int _sets;
  int get sets => _$this._sets;
  set sets(int sets) => _$this._sets = sets;

  bool _restBetweenSetsFixed;
  bool get restBetweenSetsFixed => _$this._restBetweenSetsFixed;
  set restBetweenSetsFixed(bool restBetweenSetsFixed) =>
      _$this._restBetweenSetsFixed = restBetweenSetsFixed;

  int _restBetweenSetsS;
  int get restBetweenSetsS => _$this._restBetweenSetsS;
  set restBetweenSetsS(int restBetweenSetsS) =>
      _$this._restBetweenSetsS = restBetweenSetsS;

  double _addedWeight;
  double get addedWeight => _$this._addedWeight;
  set addedWeight(double addedWeight) => _$this._addedWeight = addedWeight;

  GroupBuilder();

  GroupBuilder get _$this {
    if (_$v != null) {
      _board = _$v.board?.toBuilder();
      _handHold = _$v.handHold;
      _leftGrip = _$v.leftGrip?.toBuilder();
      _rightGrip = _$v.rightGrip?.toBuilder();
      _leftGripBoardHold = _$v.leftGripBoardHold?.toBuilder();
      _rightGripBoardHold = _$v.rightGripBoardHold?.toBuilder();
      _repeaters = _$v.repeaters;
      _repetitions = _$v.repetitions;
      _hangTimeS = _$v.hangTimeS;
      _restBetweenRepsFixed = _$v.restBetweenRepsFixed;
      _restBetweenRepsS = _$v.restBetweenRepsS;
      _sets = _$v.sets;
      _restBetweenSetsFixed = _$v.restBetweenSetsFixed;
      _restBetweenSetsS = _$v.restBetweenSetsS;
      _addedWeight = _$v.addedWeight;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Group other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Group;
  }

  @override
  void update(void Function(GroupBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Group build() {
    _$Group _$result;
    try {
      _$result = _$v ??
          new _$Group._(
              board: board.build(),
              handHold: handHold,
              leftGrip: _leftGrip?.build(),
              rightGrip: _rightGrip?.build(),
              leftGripBoardHold: _leftGripBoardHold?.build(),
              rightGripBoardHold: _rightGripBoardHold?.build(),
              repeaters: repeaters,
              repetitions: repetitions,
              hangTimeS: hangTimeS,
              restBetweenRepsFixed: restBetweenRepsFixed,
              restBetweenRepsS: restBetweenRepsS,
              sets: sets,
              restBetweenSetsFixed: restBetweenSetsFixed,
              restBetweenSetsS: restBetweenSetsS,
              addedWeight: addedWeight);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'board';
        board.build();

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
            'Group', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
