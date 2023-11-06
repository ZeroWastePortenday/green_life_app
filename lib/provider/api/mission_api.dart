import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_life_app/models/mission/mission.dart';
import 'package:green_life_app/models/net/api_result_list.dart';
import 'package:green_life_app/models/result.dart';
import 'package:green_life_app/models/score/today_score.dart';
import 'package:green_life_app/provider/http_client_provider.dart';
import 'package:green_life_app/utils/logger.dart';

final missionApiProvider = FutureProvider<MissionApi>((ref) async {
  final dio = await ref.read(dioProvider.future);
  return MissionApi(dio);
});

class MissionApi {
  MissionApi(this._dio);

  final Dio _dio;

  Future<Result<TodayScore>> getRecord(DateTime dateTime) async {
    final now = dateTime;
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

  Future<Result<List<Mission>>> getMissionList(String date) async {
    final result = await _dio.get(
      '/v2/mission',
      queryParameters: {
        'date': date,
      },
      options: await getBaseHeaders(),
    );
    if (result.statusCode == 200) {
      Log.i(result.data);
      final apiResultList = ApiResultList.fromDynamic(result.data);
      final body = (apiResultList.data!).map(Mission.fromDynamic).toList();
      return Result.success(body);
    }
    return Result.error('code: ${result.statusCode}, 미션 목록을 가져오는데 실패했습니다.');
  }

  Future<Result<bool>> registerMissions({
    required String date,
    required List<Mission?> missionList,
  }) async {
    final result = await _dio.post(
      '/v2/mission',
      queryParameters: {
        'date': date,
      },
      options: await getBaseHeaders(),
      data: jsonEncode({
        'date': date,
        'answers': Mission.makeMissionListToMap(missionList),
      }),
    );

    if (result.statusCode == 201) {
      return const Result.success(true);
    }

    return Result.error('code: ${result.statusCode}, 미션 등록에 실패했습니다.');
  }

  Future<Result<bool>> resetMissions({required String date}) async {
    final result = await _dio.delete(
      '/v2/mission',
      queryParameters: {
        'date': date,
      },
      options: await getBaseHeaders(),
    );

    if (result.statusCode == 201) {
      return const Result.success(true);
    }

    return Result.error('code: ${result.statusCode}, 미션 초기화에 실패했습니다.');
  }
}
