// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Settings> _$settingsSerializer = new _$SettingsSerializer();

class _$SettingsSerializer implements StructuredSerializer<Settings> {
  @override
  final Iterable<Type> types = const [Settings, _$Settings];
  @override
  final String wireName = 'Settings';

  @override
  Iterable<Object> serialize(Serializers serializers, Settings object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'defaultBoard',
      serializers.serialize(object.defaultBoard,
          specifiedType: const FullType(Board)),
      'preparationTimer',
      serializers.serialize(object.preparationTimer,
          specifiedType: const FullType(int)),
      'hangSound',
      serializers.serialize(object.hangSound,
          specifiedType: const FullType(Sound)),
      'beepSound',
      serializers.serialize(object.beepSound,
          specifiedType: const FullType(Sound)),
      'restSound',
      serializers.serialize(object.restSound,
          specifiedType: const FullType(Sound)),
      'beepsBeforeHang',
      serializers.serialize(object.beepsBeforeHang,
          specifiedType: const FullType(int)),
      'beepsBeforeRest',
      serializers.serialize(object.beepsBeforeRest,
          specifiedType: const FullType(int)),
      'weightSystem',
      serializers.serialize(object.weightSystem,
          specifiedType: const FullType(WeightSystem)),
      'tempUnit',
      serializers.serialize(object.tempUnit,
          specifiedType: const FullType(TempUnit)),
    ];

    return result;
  }

  @override
  Settings deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SettingsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'defaultBoard':
          result.defaultBoard.replace(serializers.deserialize(value,
              specifiedType: const FullType(Board)) as Board);
          break;
        case 'preparationTimer':
          result.preparationTimer = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'hangSound':
          result.hangSound.replace(serializers.deserialize(value,
              specifiedType: const FullType(Sound)) as Sound);
          break;
        case 'beepSound':
          result.beepSound.replace(serializers.deserialize(value,
              specifiedType: const FullType(Sound)) as Sound);
          break;
        case 'restSound':
          result.restSound.replace(serializers.deserialize(value,
              specifiedType: const FullType(Sound)) as Sound);
          break;
        case 'beepsBeforeHang':
          result.beepsBeforeHang = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'beepsBeforeRest':
          result.beepsBeforeRest = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'weightSystem':
          result.weightSystem = serializers.deserialize(value,
              specifiedType: const FullType(WeightSystem)) as WeightSystem;
          break;
        case 'tempUnit':
          result.tempUnit = serializers.deserialize(value,
              specifiedType: const FullType(TempUnit)) as TempUnit;
          break;
      }
    }

    return result.build();
  }
}

class _$Settings extends Settings {
  @override
  final Board defaultBoard;
  @override
  final int preparationTimer;
  @override
  final Sound hangSound;
  @override
  final Sound beepSound;
  @override
  final Sound restSound;
  @override
  final int beepsBeforeHang;
  @override
  final int beepsBeforeRest;
  @override
  final WeightSystem weightSystem;
  @override
  final TempUnit tempUnit;

  factory _$Settings([void Function(SettingsBuilder) updates]) =>
      (new SettingsBuilder()..update(updates)).build();

  _$Settings._(
      {this.defaultBoard,
      this.preparationTimer,
      this.hangSound,
      this.beepSound,
      this.restSound,
      this.beepsBeforeHang,
      this.beepsBeforeRest,
      this.weightSystem,
      this.tempUnit})
      : super._() {
    if (defaultBoard == null) {
      throw new BuiltValueNullFieldError('Settings', 'defaultBoard');
    }
    if (preparationTimer == null) {
      throw new BuiltValueNullFieldError('Settings', 'preparationTimer');
    }
    if (hangSound == null) {
      throw new BuiltValueNullFieldError('Settings', 'hangSound');
    }
    if (beepSound == null) {
      throw new BuiltValueNullFieldError('Settings', 'beepSound');
    }
    if (restSound == null) {
      throw new BuiltValueNullFieldError('Settings', 'restSound');
    }
    if (beepsBeforeHang == null) {
      throw new BuiltValueNullFieldError('Settings', 'beepsBeforeHang');
    }
    if (beepsBeforeRest == null) {
      throw new BuiltValueNullFieldError('Settings', 'beepsBeforeRest');
    }
    if (weightSystem == null) {
      throw new BuiltValueNullFieldError('Settings', 'weightSystem');
    }
    if (tempUnit == null) {
      throw new BuiltValueNullFieldError('Settings', 'tempUnit');
    }
  }

  @override
  Settings rebuild(void Function(SettingsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SettingsBuilder toBuilder() => new SettingsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Settings &&
        defaultBoard == other.defaultBoard &&
        preparationTimer == other.preparationTimer &&
        hangSound == other.hangSound &&
        beepSound == other.beepSound &&
        restSound == other.restSound &&
        beepsBeforeHang == other.beepsBeforeHang &&
        beepsBeforeRest == other.beepsBeforeRest &&
        weightSystem == other.weightSystem &&
        tempUnit == other.tempUnit;
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
                                $jc($jc(0, defaultBoard.hashCode),
                                    preparationTimer.hashCode),
                                hangSound.hashCode),
                            beepSound.hashCode),
                        restSound.hashCode),
                    beepsBeforeHang.hashCode),
                beepsBeforeRest.hashCode),
            weightSystem.hashCode),
        tempUnit.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Settings')
          ..add('defaultBoard', defaultBoard)
          ..add('preparationTimer', preparationTimer)
          ..add('hangSound', hangSound)
          ..add('beepSound', beepSound)
          ..add('restSound', restSound)
          ..add('beepsBeforeHang', beepsBeforeHang)
          ..add('beepsBeforeRest', beepsBeforeRest)
          ..add('weightSystem', weightSystem)
          ..add('tempUnit', tempUnit))
        .toString();
  }
}

class SettingsBuilder implements Builder<Settings, SettingsBuilder> {
  _$Settings _$v;

  BoardBuilder _defaultBoard;
  BoardBuilder get defaultBoard => _$this._defaultBoard ??= new BoardBuilder();
  set defaultBoard(BoardBuilder defaultBoard) =>
      _$this._defaultBoard = defaultBoard;

  int _preparationTimer;
  int get preparationTimer => _$this._preparationTimer;
  set preparationTimer(int preparationTimer) =>
      _$this._preparationTimer = preparationTimer;

  SoundBuilder _hangSound;
  SoundBuilder get hangSound => _$this._hangSound ??= new SoundBuilder();
  set hangSound(SoundBuilder hangSound) => _$this._hangSound = hangSound;

  SoundBuilder _beepSound;
  SoundBuilder get beepSound => _$this._beepSound ??= new SoundBuilder();
  set beepSound(SoundBuilder beepSound) => _$this._beepSound = beepSound;

  SoundBuilder _restSound;
  SoundBuilder get restSound => _$this._restSound ??= new SoundBuilder();
  set restSound(SoundBuilder restSound) => _$this._restSound = restSound;

  int _beepsBeforeHang;
  int get beepsBeforeHang => _$this._beepsBeforeHang;
  set beepsBeforeHang(int beepsBeforeHang) =>
      _$this._beepsBeforeHang = beepsBeforeHang;

  int _beepsBeforeRest;
  int get beepsBeforeRest => _$this._beepsBeforeRest;
  set beepsBeforeRest(int beepsBeforeRest) =>
      _$this._beepsBeforeRest = beepsBeforeRest;

  WeightSystem _weightSystem;
  WeightSystem get weightSystem => _$this._weightSystem;
  set weightSystem(WeightSystem weightSystem) =>
      _$this._weightSystem = weightSystem;

  TempUnit _tempUnit;
  TempUnit get tempUnit => _$this._tempUnit;
  set tempUnit(TempUnit tempUnit) => _$this._tempUnit = tempUnit;

  SettingsBuilder();

  SettingsBuilder get _$this {
    if (_$v != null) {
      _defaultBoard = _$v.defaultBoard?.toBuilder();
      _preparationTimer = _$v.preparationTimer;
      _hangSound = _$v.hangSound?.toBuilder();
      _beepSound = _$v.beepSound?.toBuilder();
      _restSound = _$v.restSound?.toBuilder();
      _beepsBeforeHang = _$v.beepsBeforeHang;
      _beepsBeforeRest = _$v.beepsBeforeRest;
      _weightSystem = _$v.weightSystem;
      _tempUnit = _$v.tempUnit;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Settings other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Settings;
  }

  @override
  void update(void Function(SettingsBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Settings build() {
    _$Settings _$result;
    try {
      _$result = _$v ??
          new _$Settings._(
              defaultBoard: defaultBoard.build(),
              preparationTimer: preparationTimer,
              hangSound: hangSound.build(),
              beepSound: beepSound.build(),
              restSound: restSound.build(),
              beepsBeforeHang: beepsBeforeHang,
              beepsBeforeRest: beepsBeforeRest,
              weightSystem: weightSystem,
              tempUnit: tempUnit);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'defaultBoard';
        defaultBoard.build();

        _$failedField = 'hangSound';
        hangSound.build();
        _$failedField = 'beepSound';
        beepSound.build();
        _$failedField = 'restSound';
        restSound.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Settings', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
