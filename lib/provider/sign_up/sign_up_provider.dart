import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_life_app/provider/api/user_api.dart';

final signUpProvider = StateNotifierProvider<SignUpProvider, bool>((ref) {
  final userApi = ref.watch(userApiProvider);
  return SignUpProvider(userApi);
});

class SignUpProvider extends StateNotifier<bool> {
  SignUpProvider(this.userApi) : super(false);

  final AsyncValue<UserApi> userApi;

  Future<void> signUp(String nickname) async {
    // final signUpResult = await userApi.signUp(nickname);
    // state = signUpResult;

    userApi.when(
      data: (api) => api.signUp(nickname).then((value) => state = value),
      error: (e, s) => state = false,
      loading: () => state = false,
    );
  }
}
