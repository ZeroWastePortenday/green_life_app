import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:green_life_app/models/net/api_result.dart';

part 'today_score.g.dart';

@JsonSerializable()
class TodayScore {
  TodayScore({
    required this.date,
    required this.totalScoreByDay,
    required this.averageScore,
    required this.recordDayCount,
    required this.missionStatus,
  });

  factory TodayScore.fromJson(Map<String, dynamic> json) =>
      _$TodayScoreFromJson(json);

  factory TodayScore.fromDynamic(dynamic data) =>
      TodayScore.fromJson(ApiResult.fromDynamic(data).data!);

  final String date;
  final int totalScoreByDay;
  final double averageScore;
  final int recordDayCount;
  final String missionStatus;

  bool hasRecord() {
    return missionStatus == 'Y';
  }

  String getScoreText() {
    return missionStatus == 'Y' ? '$totalScoreByDay점' : '클릭';
  }
}
