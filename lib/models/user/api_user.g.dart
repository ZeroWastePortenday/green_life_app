// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ApiUser _$$_ApiUserFromJson(Map<String, dynamic> json) => _$_ApiUser(
      status: json['status'] as int,
      id: json['id'] as int?,
      nickname: json['nickname'] as String?,
    );

Map<String, dynamic> _$$_ApiUserToJson(_$_ApiUser instance) =>
    <String, dynamic>{
      'status': instance.status,
      'id': instance.id,
      'nickname': instance.nickname,
    };
