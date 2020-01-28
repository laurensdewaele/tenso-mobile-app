// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fingers.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Fingers> _$fingersSerializer = new _$FingersSerializer();

class _$FingersSerializer implements StructuredSerializer<Fingers> {
  @override
  final Iterable<Type> types = const [Fingers, _$Fingers];
  @override
  final String wireName = 'Fingers';

  @override
  Iterable<Object> serialize(Serializers serializers, Fingers object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'pinky',
      serializers.serialize(object.pinky, specifiedType: const FullType(bool)),
      'ring',
      serializers.serialize(object.ring, specifiedType: const FullType(bool)),
      'middle',
      serializers.serialize(object.middle, specifiedType: const FullType(bool)),
      'index',
      serializers.serialize(object.index, specifiedType: const FullType(bool)),
      'thumb',
      serializers.serialize(object.thumb, specifiedType: const FullType(bool)),
      'count',
      serializers.serialize(object.count, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  Fingers deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new FingersBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'pinky':
          result.pinky = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'ring':
          result.ring = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'middle':
          result.middle = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'index':
          result.index = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'thumb':
          result.thumb = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'count':
          result.count = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$Fingers extends Fingers {
  @override
  final bool pinky;
  @override
  final bool ring;
  @override
  final bool middle;
  @override
  final bool index;
  @override
  final bool thumb;
  @override
  final int count;

  factory _$Fingers([void Function(FingersBuilder) updates]) =>
      (new FingersBuilder()..update(updates)).build();

  _$Fingers._(
      {this.pinky, this.ring, this.middle, this.index, this.thumb, this.count})
      : super._() {
    if (pinky == null) {
      throw new BuiltValueNullFieldError('Fingers', 'pinky');
    }
    if (ring == null) {
      throw new BuiltValueNullFieldError('Fingers', 'ring');
    }
    if (middle == null) {
      throw new BuiltValueNullFieldError('Fingers', 'middle');
    }
    if (index == null) {
      throw new BuiltValueNullFieldError('Fingers', 'index');
    }
    if (thumb == null) {
      throw new BuiltValueNullFieldError('Fingers', 'thumb');
    }
    if (count == null) {
      throw new BuiltValueNullFieldError('Fingers', 'count');
    }
  }

  @override
  Fingers rebuild(void Function(FingersBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FingersBuilder toBuilder() => new FingersBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Fingers &&
        pinky == other.pinky &&
        ring == other.ring &&
        middle == other.middle &&
        index == other.index &&
        thumb == other.thumb &&
        count == other.count;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, pinky.hashCode), ring.hashCode),
                    middle.hashCode),
                index.hashCode),
            thumb.hashCode),
        count.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Fingers')
          ..add('pinky', pinky)
          ..add('ring', ring)
          ..add('middle', middle)
          ..add('index', index)
          ..add('thumb', thumb)
          ..add('count', count))
        .toString();
  }
}

class FingersBuilder implements Builder<Fingers, FingersBuilder> {
  _$Fingers _$v;

  bool _pinky;
  bool get pinky => _$this._pinky;
  set pinky(bool pinky) => _$this._pinky = pinky;

  bool _ring;
  bool get ring => _$this._ring;
  set ring(bool ring) => _$this._ring = ring;

  bool _middle;
  bool get middle => _$this._middle;
  set middle(bool middle) => _$this._middle = middle;

  bool _index;
  bool get index => _$this._index;
  set index(bool index) => _$this._index = index;

  bool _thumb;
  bool get thumb => _$this._thumb;
  set thumb(bool thumb) => _$this._thumb = thumb;

  int _count;
  int get count => _$this._count;
  set count(int count) => _$this._count = count;

  FingersBuilder();

  FingersBuilder get _$this {
    if (_$v != null) {
      _pinky = _$v.pinky;
      _ring = _$v.ring;
      _middle = _$v.middle;
      _index = _$v.index;
      _thumb = _$v.thumb;
      _count = _$v.count;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Fingers other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Fingers;
  }

  @override
  void update(void Function(FingersBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Fingers build() {
    final _$result = _$v ??
        new _$Fingers._(
            pinky: pinky,
            ring: ring,
            middle: middle,
            index: index,
            thumb: thumb,
            count: count);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
