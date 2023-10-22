import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_life_app/models/result.dart';
import 'package:green_life_app/provider/api/user_api.dart';

final signUpProvider = StateNotifierProvider<SignUpProvider, Result<bool>>((ref) {
  final userApi = ref.watch(userApiProvider);
  return SignUpProvider(userApi);
});

class SignUpProvider extends StateNotifier<Result<bool>> {
  SignUpProvider(this.userApi) : super(const Result.empty());

  final AsyncValue<UserApi> userApi;

  Future<void> signUp(String nickname) async {
    userApi.when(
      data: (api) => api.signUp(nickname).then((value) => state = value),
      error: (e, s) => state = Result.error(e.toString()),
      loading: () => state = const Result.loading(),
    );
  }
}
