
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_life_app/models/result.dart';
import 'package:green_life_app/provider/api/user_api.dart';

final deleteUserProvider = StateNotifierProvider<DeleteProvier, Result<bool>>(
      (ref) {
    final userApi = ref.watch(userApiProvider);
    return DeleteProvier(userApi);
  },
);

class DeleteProvier extends StateNotifier<Result<bool>> {
  DeleteProvier(this.userApi) : super(const Result.empty());

  final AsyncValue<UserApi> userApi;

  Future<void> deleteUser() async {
    userApi.when(
      data: (api) => api.deleteUser().then((value) => state = value),
      error: (e, s) => state = Result.error(e.toString()),
      loading: () => state = const Result.loading(),
    );
  }
}