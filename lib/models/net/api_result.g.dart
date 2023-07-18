// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResult _$ApiResultFromJson(Map<String, dynamic> json) => ApiResult(
      code: json['code'] as int?,
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'],
    );

Map<String, dynamic> _$ApiResultToJson(ApiResult instance) => <String, dynamic>{
      'code': instance.code,
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
