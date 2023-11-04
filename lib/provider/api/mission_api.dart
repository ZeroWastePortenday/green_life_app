import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_life_app/models/result.dart';
import 'package:green_life_app/models/score/today_score.dart';
import 'package:green_life_app/provider/http_client_provider.dart';

final missionApiProvider = FutureProvider<MissionApi>((ref) async {
  final dio = await ref.read(dioProvider.future);
  return MissionApi(dio);
});

class MissionApi {
  MissionApi(this._dio);

  final Dio _dio;

  Future<Result<TodayScore>> getTodayRecord() async {
    // get Today year(yyyy), month(MM), day(dd)
    final now = DateTime.now();
    final year = now.year.toString();
    final month = now.month.toString().padLeft(2, '0');
    final day = now.day.toString().padLeft(2, '0');

    final result = await _dio.get(
      '/v2/recordByDay',
      queryParameters: {
        'year': year,
        'month': month,
        'day': day,
      },
      options: await getBaseHeaders(),
    );

    if (result.statusCode == 200) {
      return Result.success(TodayScore.fromDynamic(result.data));
    }
    return Result.error('code: ${result.statusCode}, 오늘의 기록을 가져오는데 실패했습니다.');
  }
}
