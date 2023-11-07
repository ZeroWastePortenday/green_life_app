import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:green_life_app/models/net/api_result.dart';

part 'monthly_record.g.dart';

@JsonSerializable()
class MonthlyRecord {
  MonthlyRecord({
    required this.achievementDayCountByMonth,
    required this.averageScoreByMonth,
    required this.scoreCount50ByMonth,
    required this.scoreCount80ByMonth,
  });

  factory MonthlyRecord.fromJson(Map<String, dynamic> json) =>
      _$MonthlyRecordFromJson(json);

  factory MonthlyRecord.fromDynamic(dynamic data) =>
      MonthlyRecord.fromJson(ApiResult.fromDynamic(data).data!);

  final int achievementDayCountByMonth;
  final double averageScoreByMonth;
  final int scoreCount50ByMonth;
  final int scoreCount80ByMonth;

  Map<String, dynamic> toJson() => _$MonthlyRecordToJson(this);
}
