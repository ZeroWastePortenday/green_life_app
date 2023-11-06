import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_life_app/models/mission/mission.dart';
import 'package:green_life_app/provider/api/mission_api.dart';

final registerCheckProvider =
    StateNotifierProvider<RegisterCheckProvider, List<Mission?>>(
  (ref) {
    final missionApi = ref.watch(missionApiProvider);
    return RegisterCheckProvider(missionApi);
  },
);

class RegisterCheckProvider extends StateNotifier<List<Mission?>> {
  RegisterCheckProvider(this.missionApi)
      : super(List.generate(10, (index) => null));

  final AsyncValue<MissionApi> missionApi;

  void init(int length) {
    state = List.generate(length, (index) => null);
  }

  void check({required int index, required bool hasTrue}) {
    state = [
      ...state.sublist(0, index),
      state[index]?.copyWith(answer: hasTrue ? 'Y' : 'N'),
      ...state.sublist(index + 1),
    ];
  }

  void load(DateTime selectedDateTime, {void Function()? hasAnswered}) {
    missionApi.whenOrNull(
      data: (api) {
        final date =
            '${selectedDateTime.year}'
            '${selectedDateTime.month.toString().padLeft(2, '0')}'
            '${selectedDateTime.day.toString().padLeft(2, '0')}';
        api.getMissionList(date).then((result) {
          result.whenOrNull(
            success: (data) {
              state = List.generate(data.length, (i) => data[i]);
              if (hasAllAnswer) hasAnswered?.call();
            },
            error: (e) {
              state = List.generate(10, (index) => null);
            },
          );
        });
      },
    );
  }

  bool get hasAllAnswer => state.every((element) => element?.answer != null);
}
