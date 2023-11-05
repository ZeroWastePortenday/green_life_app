// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mission.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Mission _$MissionFromJson(Map<String, dynamic> json) => Mission(
      mission_id: json['mission_id'] as int,
      user_mission_id: json['user_mission_id'] as int?,
      content: json['content'] as String,
      stage: json['stage'] as String,
      answer: json['answer'] as String?,
    );

Map<String, dynamic> _$MissionToJson(Mission instance) => <String, dynamic>{
      'mission_id': instance.mission_id,
      'user_mission_id': instance.user_mission_id,
      'content': instance.content,
      'stage': instance.stage,
      'answer': instance.answer,
    };
