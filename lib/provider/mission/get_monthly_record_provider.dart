import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_life_app/models/result.dart';
import 'package:green_life_app/models/score/monthly_record.dart';
import 'package:green_life_app/provider/api/mission_api.dart';

final getMonthlyRecordProvider = StateNotifierProvider<GetMonthlyRecordProvider, Result<MonthlyRecord>>((ref) {
  final missionApi = ref.watch(missionApiProvider);
  return GetMonthlyRecordProvider(missionApi);
});

class GetMonthlyRecordProvider extends StateNotifier<Result<MonthlyRecord>> {
  GetMonthlyRecordProvider(this.missionApi) : super(const Result.empty());

  final AsyncValue<MissionApi> missionApi;

  void getRecordByMonth(DateTime selectedDateTime) {
    missionApi.when(
      data: (api) => api.getRecordByMonth(selectedDateTime).then((value) => state = value),
      error: (e, s) => state = Result.error(e.toString()),
      loading: () => state = const Result.loading(),
    );
  }
}