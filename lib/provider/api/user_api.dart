import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_life_app/models/is_new_user.dart';
import 'package:green_life_app/models/result.dart';
import 'package:green_life_app/models/user/api_user.dart';
import 'package:green_life_app/provider/global_data.dart';
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

  Future<Result<IsNewUser>> checkUser() async {
    final result = await _dio.get<dynamic>('/v1/user', options: await getBaseHeaders());
    Log.i(result);
    if (result.statusCode == 200) {
      final user = ApiUser.fromDynamic(result.data);
      return Result.success(IsNewUser.fromStatus(user.status));
    }
    return Result.error('code: ${result.statusCode}, 유저 정보를 가져오는데 실패했습니다.');
  }

  Future<Result<bool>> signUp(String nickname) async {
    final result = await _dio.post<dynamic>(
      '/v1/signup',
      data: FormData.fromMap({
        'nickname': nickname,
      }),
      options: await getBaseHeaders(),
    );

    if (result.statusCode == 201) {
      Log.i(result.data);
      return const Result.success(true);
    } else if (result.statusCode == 400) {
      return const Result.success(false); // 중복된 닉네임
    }
    return Result.error('회원가입에 실패했습니다: ${result.data}');
  }

  Future<LoginState> login() async {
    final result = await _dio.post<dynamic>(
      '/v1/login',
      options: await getBaseHeaders(),
    );
    if (result.statusCode == 200) {
      final apiUser = ApiUser.fromDynamic(result.data);
      GlobalData.nickname = apiUser.nickname ?? '';
      return LoginSuccessState(apiUser);
    }
    return LoginErrorState('${result.statusCode} 로그인에 실패했습니다.');
  }

  Future<Result<bool>> deleteUser() async {
    final result = await _dio.delete<dynamic>(
      '/v1/user',
      options: await getBaseHeaders(),
    );
    if (result.statusCode == 200) {
      return const Result.success(true);
    }
    return Result.error('회원탈퇴에 실패했습니다: ${result.data}');
  }
}
