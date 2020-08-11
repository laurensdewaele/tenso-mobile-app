// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback.dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Feedback> _$feedbackSerializer = new _$FeedbackSerializer();

class _$FeedbackSerializer implements StructuredSerializer<Feedback> {
  @override
  final Iterable<Type> types = const [Feedback, _$Feedback];
  @override
  final String wireName = 'Feedback';

  @override
  Iterable<Object> serialize(Serializers serializers, Feedback object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'type',
      serializers.serialize(object.type, specifiedType: const FullType(String)),
      'message',
      serializers.serialize(object.message,
          specifiedType: const FullType(String)),
    ];
    if (object.email != null) {
      result
        ..add('email')
        ..add(serializers.serialize(object.email,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  Feedback deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new FeedbackBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'type':
          result.type = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'message':
          result.message = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$Feedback extends Feedback {
  @override
  final String type;
  @override
  final String message;
  @override
  final String email;

  factory _$Feedback([void Function(FeedbackBuilder) updates]) =>
      (new FeedbackBuilder()..update(updates)).build();

  _$Feedback._({this.type, this.message, this.email}) : super._() {
    if (type == null) {
      throw new BuiltValueNullFieldError('Feedback', 'type');
    }
    if (message == null) {
      throw new BuiltValueNullFieldError('Feedback', 'message');
    }
  }

  @override
  Feedback rebuild(void Function(FeedbackBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FeedbackBuilder toBuilder() => new FeedbackBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Feedback &&
        type == other.type &&
        message == other.message &&
        email == other.email;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, type.hashCode), message.hashCode), email.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Feedback')
          ..add('type', type)
          ..add('message', message)
          ..add('email', email))
        .toString();
  }
}

class FeedbackBuilder implements Builder<Feedback, FeedbackBuilder> {
  _$Feedback _$v;

  String _type;
  String get type => _$this._type;
  set type(String type) => _$this._type = type;

  String _message;
  String get message => _$this._message;
  set message(String message) => _$this._message = message;

  String _email;
  String get email => _$this._email;
  set email(String email) => _$this._email = email;

  FeedbackBuilder();

  FeedbackBuilder get _$this {
    if (_$v != null) {
      _type = _$v.type;
      _message = _$v.message;
      _email = _$v.email;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Feedback other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Feedback;
  }

  @override
  void update(void Function(FeedbackBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Feedback build() {
    final _$result =
        _$v ?? new _$Feedback._(type: type, message: message, email: email);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
