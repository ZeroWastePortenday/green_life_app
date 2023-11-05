import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_life_app/models/mission/mission.dart';
import 'package:green_life_app/models/result.dart';
import 'package:green_life_app/provider/api/mission_api.dart';
import 'package:green_life_app/utils/date_utils.dart';

final registerMissionsProvider =
    StateNotifierProvider<RegisterMissionsProvider, Result<bool>>((ref) {
  final missionApi = ref.watch(missionApiProvider);
  return RegisterMissionsProvider(missionApi);
});

class RegisterMissionsProvider extends StateNotifier<Result<bool>> {
  RegisterMissionsProvider(this.missionApi) : super(const Result.empty());

  final AsyncValue<MissionApi> missionApi;

  void register({
    required DateTime dateTime,
    required List<Mission?> missionList,
  }) {
    missionApi.whenOrNull(
      data: (api) async {
        final result = await api.registerMissions(
          date: dateTime.toDateString,
          missionList: missionList,
        );

        result.whenOrNull(
          success: (data) {
            state = Result.success(data);
          },
          error: (e) {
            state = Result.error(e);
          },
        );
      },
    );
  }
}
