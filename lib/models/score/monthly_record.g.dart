// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monthly_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MonthlyRecord _$MonthlyRecordFromJson(Map<String, dynamic> json) =>
    MonthlyRecord(
      achievementDayCountByMonth: json['achievementDayCountByMonth'] as int,
      averageScoreByMonth: (json['averageScoreByMonth'] as num).toDouble(),
      scoreCount50ByMonth: json['scoreCount50ByMonth'] as int,
      scoreCount80ByMonth: json['scoreCount80ByMonth'] as int,
    );

Map<String, dynamic> _$MonthlyRecordToJson(MonthlyRecord instance) =>
    <String, dynamic>{
      'achievementDayCountByMonth': instance.achievementDayCountByMonth,
      'averageScoreByMonth': instance.averageScoreByMonth,
      'scoreCount50ByMonth': instance.scoreCount50ByMonth,
      'scoreCount80ByMonth': instance.scoreCount80ByMonth,
    };
