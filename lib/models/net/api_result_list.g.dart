// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_result_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResultList _$ApiResultListFromJson(Map<String, dynamic> json) =>
    ApiResultList(
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$ApiResultListToJson(ApiResultList instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
