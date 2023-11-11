import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_life_app/models/is_new_user.dart';
import 'package:green_life_app/provider/api/user_api.dart';
import 'package:green_life_app/provider/login/login_state.dart';
import 'package:green_life_app/provider/login/login_type.dart';
import 'package:green_life_app/provider/login/social/apple_login.dart';
import 'package:green_life_app/provider/login/social/google_login.dart';
import 'package:green_life_app/provider/login/social/kakao_login.dart';
import 'package:green_life_app/provider/login/social/naver_login.dart';
import 'package:green_life_app/utils/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

final loginProvider = StateNotifierProvider<LoginProvider, LoginState>((ref) {
  final userApi = ref.watch(userApiProvider);
  return LoginProvider(userApi);
});

class LoginProvider extends StateNotifier<LoginState> {
  LoginProvider(this.userApi) : super(LoginInitialState());

  final AsyncValue<UserApi> userApi;

  void login(LoginType loginType) {
    state = LoginLoadingState();
    saveLoginInfo(loginType);
    loginByLoginType(loginType);
  }

  void loginByLoginType(LoginType loginType) {
    switch (loginType) {
      case LoginType.google:
        Google.login().then(sendResult);
      case LoginType.apple:
        Apple.login().then(sendResult);
      case LoginType.kakao:
        Kakao.login().then(sendResult);
      case LoginType.naver:
        Naver.login().then(sendResult);
    }
  }

  // shared_preferences를 사용하여 로그인 정보를 저장하고, 로그인 상태를 유지하도록 구현
  Future<void> saveLoginInfo(LoginType loginType) {
    return SharedPreferences.getInstance().then(
      (prefs) => unawaited(prefs.setString('loginType', loginType.name)),
    );
  }

  void logout() {
    state = LoginInitialState();
  }

  // ignore: avoid_positional_boolean_parameters
  void sendResult(bool isSuccess) {
    if (isSuccess) {
      userApi.when(
        data: checkUser,
        loading: () {
          state = LoginLoadingState();
        },
        error: (e, s) {
          state = LoginErrorState('로그인 실패');
        },
      );
    } else {
      Log.e('login fail');
      state = LoginErrorState('login fail');
    }
  }

  Future<void> checkUser(UserApi api) async {
    (await api.checkUser()).whenOrNull(
      success: (data) {
        setToSignUpStateIfNewUser(data);
        loginIfIsNotNewUser(data, api);
      },
      error: (message) {
        Log.e(message);
      },
    );
  }

  void loginIfIsNotNewUser(IsNewUser data, UserApi api) {
    if (data != IsNewUser.isNew) {
      api.login().then((value) => state = value);
    }
  }

  void setToSignUpStateIfNewUser(IsNewUser data) {
    if (data == IsNewUser.isNew) {
      state = LoginNeedToSignUpState();
    }
  }

  void autoLogin() {
    if (FirebaseAuth.instance.currentUser != null) {
      sendResult(true);
    } else {
      state = LoginNeededState();
    }
  }
}
