import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:green_life_app/provider/login/create_firebase_custom_token.dart';
import 'package:green_life_app/utils/logger.dart';

class Naver {
  static Future<bool> login() async {
    final result = await FlutterNaverLogin.logIn();

    return getLoginResultIfStatusIsLoggedIn(result);
  }

  static Future<bool> getLoginResultIfStatusIsLoggedIn(
    NaverLoginResult result,
  ) async {
    if (result.status == NaverLoginStatus.loggedIn) {
      final customToken = await getFirebaseCustomToken();
      final userCredential = await getFirebaseUserCredentialByCustomToken(customToken);
      return isFirebaseUserNotNull(userCredential);
    }
    return false;
  }

  static bool isFirebaseUserNotNull(UserCredential userCredential) => userCredential.user != null;

  static Future<UserCredential> getFirebaseUserCredentialByCustomToken(String customToken) async {
    final userCredential = await FirebaseAuth.instance.signInWithCustomToken(customToken);
    return userCredential;
  }

  static Future<String> getFirebaseCustomToken() async {
    final customToken = await createFirebaseCustomToken(
      accessToken: (await FlutterNaverLogin.currentAccessToken).accessToken,
      loginType: 'naverCustomAuth',
    );
    return customToken;
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
