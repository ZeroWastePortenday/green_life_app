import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_life_app/models/net/api_result.dart';
import 'package:green_life_app/models/user/user.dart' as user;
import 'package:green_life_app/provider/http_client_provider.dart';
import 'package:green_life_app/provider/login/login_state.dart';
import 'package:green_life_app/utils/logger.dart';

final userApiProvider = FutureProvider<UserApi>((ref) async {
  final dio = await ref.read(dioProvider.future);
  return UserApi(dio);
});

class UserApi {

  UserApi(this._dio);

  final Dio _dio;

  Future<bool> signUp(String nickname) async {
    try {
      final result = await _dio.post<dynamic>(
        '/signup',
        data: {
          'nickname': nickname, // TODO api 문서 확인 필요
        },
      );

      if (result.statusCode == 200) {
        return true;
      }
      Log.e(result);
      return false;
    } catch (e) {
      Log.e(e);
      return false;
    }
  }

  Future<LoginState> login() async {
    try {
      return LoginNeedToSignUpState();
      // final result = await _dio.post<dynamic>(
      //   '/login',
      // );
      // if (result.statusCode == 200) {
      //   final data = ApiResult.fromDynamic(result.data);
      //   Log.i(data.toJson());
      //   return LoginSuccessState(user.User.fromDynamic(data.data));
      // }
      // return LoginErrorState('로그인에 실패했습니다.');
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return LoginNeedToSignUpState();
      }
      Log.e(e);
      return LoginErrorState('로그인에 실패했습니다.');
    }
  }
}
