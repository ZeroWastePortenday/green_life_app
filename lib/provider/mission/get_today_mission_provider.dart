import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_life_app/models/result.dart';
import 'package:green_life_app/models/score/today_score.dart';
import 'package:green_life_app/provider/api/mission_api.dart';

final getTodayMissionProvider =
    StateNotifierProvider<GetTodayMissionProvider, Result<TodayScore>>((ref) {
  final missionApi = ref.watch(missionApiProvider);
  return GetTodayMissionProvider(missionApi);
});

class GetTodayMissionProvider extends StateNotifier<Result<TodayScore>> {
  GetTodayMissionProvider(this.missionApi) : super(const Result.empty());

  final AsyncValue<MissionApi> missionApi;

  void getTodayMission() {
    missionApi.when(
      data: (api) => api.getRecord(DateTime.now()).then((value) => state = value),
      error: (e, s) => state = Result.error(e.toString()),
      loading: () => state = const Result.loading(),
    );
  }

  void getSelectedDateMission(DateTime selectedDateTime) {
    missionApi.when(
      data: (api) => api.getRecord(selectedDateTime).then((value) => state = value),
      error: (e, s) => state = Result.error(e.toString()),
      loading: () => state = const Result.loading(),
    );
  }
}
