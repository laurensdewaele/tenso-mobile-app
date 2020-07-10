// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workouts.model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Workouts> _$workoutsSerializer = new _$WorkoutsSerializer();

class _$WorkoutsSerializer implements StructuredSerializer<Workouts> {
  @override
  final Iterable<Type> types = const [Workouts, _$Workouts];
  @override
  final String wireName = 'Workouts';

  @override
  Iterable<Object> serialize(Serializers serializers, Workouts object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'workouts',
      serializers.serialize(object.workouts,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Workout)])),
    ];

    return result;
  }

  @override
  Workouts deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new WorkoutsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'workouts':
          result.workouts.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(Workout)]))
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$Workouts extends Workouts {
  @override
  final BuiltList<Workout> workouts;

  factory _$Workouts([void Function(WorkoutsBuilder) updates]) =>
      (new WorkoutsBuilder()..update(updates)).build();

  _$Workouts._({this.workouts}) : super._() {
    if (workouts == null) {
      throw new BuiltValueNullFieldError('Workouts', 'workouts');
    }
  }

  @override
  Workouts rebuild(void Function(WorkoutsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WorkoutsBuilder toBuilder() => new WorkoutsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Workouts && workouts == other.workouts;
  }

  @override
  int get hashCode {
    return $jf($jc(0, workouts.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Workouts')..add('workouts', workouts))
        .toString();
  }
}

class WorkoutsBuilder implements Builder<Workouts, WorkoutsBuilder> {
  _$Workouts _$v;

  ListBuilder<Workout> _workouts;
  ListBuilder<Workout> get workouts =>
      _$this._workouts ??= new ListBuilder<Workout>();
  set workouts(ListBuilder<Workout> workouts) => _$this._workouts = workouts;

  WorkoutsBuilder();

  WorkoutsBuilder get _$this {
    if (_$v != null) {
      _workouts = _$v.workouts?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Workouts other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Workouts;
  }

  @override
  void update(void Function(WorkoutsBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Workouts build() {
    _$Workouts _$result;
    try {
      _$result = _$v ?? new _$Workouts._(workouts: workouts.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'workouts';
        workouts.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Workouts', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
