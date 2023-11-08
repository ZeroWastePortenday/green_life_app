import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_life_app/models/mission/mission.dart';
import 'package:green_life_app/models/result.dart';
import 'package:green_life_app/models/score/monthly_record.dart';
import 'package:green_life_app/models/score/today_score.dart';
import 'package:green_life_app/provider/http_client_provider.dart';
import 'package:green_life_app/utils/strings.dart';

final missionApiProvider = FutureProvider<MissionApi>((ref) async {
  final dio = await ref.read(dioProvider.future);
  return MissionApi(dio);
});

class MissionApi {
  MissionApi(this._dio);

  final Dio _dio;

  Future<Result<TodayScore>> getRecord(DateTime dateTime) async {
    final result = await _dio.get(
      '/v2/recordByDay',
      queryParameters: {
        'year': getYearString(dateTime),
        'month': getMonthString2Length(dateTime),
        'day': getDayString(dateTime),
      },
      options: await getBaseHeaders(),
    );

    return Result.getResult(
      result,
      TodayScore.fromDynamic,
      '오늘의 기록을 가져오는데 실패했습니다.',
    );
  }

  Future<Result<List<Mission>>> getMissionList(String date) async {
    final result = await _dio.get(
      '/v2/mission',
      queryParameters: {
        'date': date,
      },
      options: await getBaseHeaders(),
    );

    return Result.getList(
      result,
      Mission.fromDynamic,
      '미션 목록을 가져오는데 실패했습니다.',
    );
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

    return Result.getExpected(result, true, '미션 등록에 실패했습니다.');
  }

  Future<Result<bool>> resetMissions({required String date}) async {
    final result = await _dio.delete(
      '/v2/mission',
      queryParameters: {
        'date': date,
      },
      options: await getBaseHeaders(),
    );

    return Result.getExpected(result, true, '미션 초기화에 실패했습니다.');
  }

  Future<Result<MonthlyRecord>> getRecordByMonth(DateTime dateTime) async {
    final year = dateTime.year.toString();
    final month = dateTime.month.toString();

    final result = await _dio.get(
      '/v2/recordByMonth',
      queryParameters: {
        'year': year,
        'month': month,
      },
      options: await getBaseHeaders(),
    );

    return Result.getResult(
      result,
      MonthlyRecord.fromDynamic,
      '월별 기록을 가져오는데 실패했습니다.',
    );
  }
}
