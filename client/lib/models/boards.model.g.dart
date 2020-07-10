// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'boards.model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Boards> _$boardsSerializer = new _$BoardsSerializer();

class _$BoardsSerializer implements StructuredSerializer<Boards> {
  @override
  final Iterable<Type> types = const [Boards, _$Boards];
  @override
  final String wireName = 'Boards';

  @override
  Iterable<Object> serialize(Serializers serializers, Boards object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'boards',
      serializers.serialize(object.boards,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Board)])),
    ];

    return result;
  }

  @override
  Boards deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BoardsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'boards':
          result.boards.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(Board)]))
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$Boards extends Boards {
  @override
  final BuiltList<Board> boards;

  factory _$Boards([void Function(BoardsBuilder) updates]) =>
      (new BoardsBuilder()..update(updates)).build();

  _$Boards._({this.boards}) : super._() {
    if (boards == null) {
      throw new BuiltValueNullFieldError('Boards', 'boards');
    }
  }

  @override
  Boards rebuild(void Function(BoardsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BoardsBuilder toBuilder() => new BoardsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Boards && boards == other.boards;
  }

  @override
  int get hashCode {
    return $jf($jc(0, boards.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Boards')..add('boards', boards))
        .toString();
  }
}

class BoardsBuilder implements Builder<Boards, BoardsBuilder> {
  _$Boards _$v;

  ListBuilder<Board> _boards;
  ListBuilder<Board> get boards => _$this._boards ??= new ListBuilder<Board>();
  set boards(ListBuilder<Board> boards) => _$this._boards = boards;

  BoardsBuilder();

  BoardsBuilder get _$this {
    if (_$v != null) {
      _boards = _$v.boards?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Boards other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Boards;
  }

  @override
  void update(void Function(BoardsBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Boards build() {
    _$Boards _$result;
    try {
      _$result = _$v ?? new _$Boards._(boards: boards.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'boards';
        boards.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Boards', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
