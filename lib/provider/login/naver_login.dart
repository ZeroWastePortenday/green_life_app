import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:green_life_app/provider/login/create _firebase_custom_token.dart';
import 'package:green_life_app/utils/logger.dart';

class Naver {
  static Future<bool> login() async {
    final result = await FlutterNaverLogin.logIn();

    if (result.status == NaverLoginStatus.loggedIn) {
      final customToken = await createFirebaseCustomToken(
        accessToken: (await FlutterNaverLogin.currentAccessToken).accessToken,
        loginType: 'naverCustomAuth',
      );
      final userCredential =
          await FirebaseAuth.instance.signInWithCustomToken(customToken);
      return userCredential.user != null;
    } else {
      return false;
    }
  }

  static Future<void> logout() async {
    final result = await FlutterNaverLogin.logOutAndDeleteToken();
    if (result.status == NaverLoginStatus.cancelledByUser) {
      Log.i('네이버 로그아웃');
    } else {
      Log.e('네이버 로그아웃 실패: ${result.status.name}');
    }
  }
}
