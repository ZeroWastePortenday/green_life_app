import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:green_life_app/provider/login/social/kakao_login.dart';
import 'package:green_life_app/provider/login/social/naver_login.dart';
import 'package:green_life_app/utils/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

void socialLogout(void Function() callback) {
  SharedPreferences.getInstance().then((prefs) {
    final loginType = prefs.getString('loginType') ?? '';
    switch (loginType) {
      case 'google':
        GoogleSignIn(
          scopes: [
            'email',
          ],
        ).signOut().then((value) {
          firebaseLogout(callback);
        });
      case 'naver':
        firebaseLogout(Naver.logout);
        // Naver.logout().then((value) => firebaseLogout(callback));
      case 'kakao':
        firebaseLogout(Kakao.logout);
        // Kakao.logout().then((value) => firebaseLogout(callback));
      default:
        firebaseLogout(callback);
    }
  });
}

void firebaseLogout(void Function() callback) {
  FirebaseAuth.instance.signOut().then((value) {
    Log.i('로그아웃');
    callback();
  });
}