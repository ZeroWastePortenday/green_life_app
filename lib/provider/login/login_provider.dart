import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_life_app/provider/login/apple_login.dart';
import 'package:green_life_app/provider/login/google_login.dart';
import 'package:green_life_app/provider/login/kakao_login.dart';
import 'package:green_life_app/provider/login/login_state.dart';
import 'package:green_life_app/provider/login/login_type.dart';
import 'package:green_life_app/provider/login/naver_login.dart';
import 'package:green_life_app/utils/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

final loginProvider = StateNotifierProvider<LoginProvider, LoginState>(
  (ref) => LoginProvider(),
);

class LoginProvider extends StateNotifier<LoginState> {
  LoginProvider() : super(LoginInitialState());

  void login(LoginType loginType) {
    state = LoginLoadingState();

    // shared_preferences를 사용하여 로그인 정보를 저장하고, 로그인 상태를 유지하도록 구현
    // 로그인 상태를 유지하는 방법은 다음과 같다.
    // 1. shared_preferences를 사용하여 로그인 정보를 저장한다.

    // 2. 로그인 상태를 유지하는 방법은 다음과 같다.

    SharedPreferences.getInstance().then(
      (prefs) => unawaited(prefs.setString('loginType', loginType.name)),
    );

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

  void logout() {
    state = LoginInitialState();
  }

  // ignore: avoid_positional_boolean_parameters
  Future<void> sendResult(bool isSuccess) async {
    if (isSuccess) {
      unawaited(
        FirebaseAuth.instance.currentUser
            ?.getIdToken()
            .then((token) {
          Clipboard.setData(ClipboardData(text: token));
        }),
      );
      Log.i('로그인 성공');
    } else {
      Log.e('login fail');
      state = LoginErrorState('login fail');
    }
  }

  // function to save login info into shared_preferences
  void saveLoginInfo() {}
}
