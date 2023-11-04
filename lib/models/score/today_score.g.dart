// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'today_score.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodayScore _$TodayScoreFromJson(Map<String, dynamic> json) => TodayScore(
      date: json['date'] as String,
      totalScoreByDay: json['totalScoreByDay'] as int,
      averageScore: (json['averageScore'] as num).toDouble(),
      recordDayCount: json['recordDayCount'] as int,
      missionStatus: json['missionStatus'] as String,
    );

Map<String, dynamic> _$TodayScoreToJson(TodayScore instance) =>
    <String, dynamic>{
      'date': instance.date,
      'totalScoreByDay': instance.totalScoreByDay,
      'averageScore': instance.averageScore,
      'recordDayCount': instance.recordDayCount,
      'missionStatus': instance.missionStatus,
    };
