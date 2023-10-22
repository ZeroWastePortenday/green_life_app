// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ApiUser _$ApiUserFromJson(Map<String, dynamic> json) {
  return _ApiUser.fromJson(json);
}

/// @nodoc
mixin _$ApiUser {
  int get status => throw _privateConstructorUsedError;
  int? get id => throw _privateConstructorUsedError;
  String? get nickname => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ApiUserCopyWith<ApiUser> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiUserCopyWith<$Res> {
  factory $ApiUserCopyWith(ApiUser value, $Res Function(ApiUser) then) =
      _$ApiUserCopyWithImpl<$Res, ApiUser>;
  @useResult
  $Res call({int status, int? id, String? nickname});
}

/// @nodoc
class _$ApiUserCopyWithImpl<$Res, $Val extends ApiUser>
    implements $ApiUserCopyWith<$Res> {
  _$ApiUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? id = freezed,
    Object? nickname = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      nickname: freezed == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ApiUserCopyWith<$Res> implements $ApiUserCopyWith<$Res> {
  factory _$$_ApiUserCopyWith(
          _$_ApiUser value, $Res Function(_$_ApiUser) then) =
      __$$_ApiUserCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int status, int? id, String? nickname});
}

/// @nodoc
class __$$_ApiUserCopyWithImpl<$Res>
    extends _$ApiUserCopyWithImpl<$Res, _$_ApiUser>
    implements _$$_ApiUserCopyWith<$Res> {
  __$$_ApiUserCopyWithImpl(_$_ApiUser _value, $Res Function(_$_ApiUser) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? id = freezed,
    Object? nickname = freezed,
  }) {
    return _then(_$_ApiUser(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      nickname: freezed == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ApiUser implements _ApiUser {
  const _$_ApiUser(
      {required this.status, required this.id, required this.nickname});

  factory _$_ApiUser.fromJson(Map<String, dynamic> json) =>
      _$$_ApiUserFromJson(json);

  @override
  final int status;
  @override
  final int? id;
  @override
  final String? nickname;

  @override
  String toString() {
    return 'ApiUser(status: $status, id: $id, nickname: $nickname)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ApiUser &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, status, id, nickname);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ApiUserCopyWith<_$_ApiUser> get copyWith =>
      __$$_ApiUserCopyWithImpl<_$_ApiUser>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ApiUserToJson(
      this,
    );
  }
}

abstract class _ApiUser implements ApiUser {
  const factory _ApiUser(
      {required final int status,
      required final int? id,
      required final String? nickname}) = _$_ApiUser;

  factory _ApiUser.fromJson(Map<String, dynamic> json) = _$_ApiUser.fromJson;

  @override
  int get status;
  @override
  int? get id;
  @override
  String? get nickname;
  @override
  @JsonKey(ignore: true)
  _$$_ApiUserCopyWith<_$_ApiUser> get copyWith =>
      throw _privateConstructorUsedError;
}
