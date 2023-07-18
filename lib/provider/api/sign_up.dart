import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_life_app/models/net/api_result.dart';
import 'package:green_life_app/provider/http_client_provider.dart';
import 'package:green_life_app/utils/logger.dart';

final userApiProvider = FutureProvider<UserApi>((ref) async {
  final dio = ref.watch(dioProvider).value ?? Dio();
  return UserApi(dio);
});

class UserApi {

  UserApi(this._dio);

  final Dio _dio;

  Future<void> signUp(String nickname) async {
    try {
      final result = await _dio.post(
        '/api/v1/signup',
      );
      final data = ApiResult.fromJson(result.data as Map<String, dynamic>);
      Log.i(data);

    } catch (e) {
      Log.e(e);
    }
  }

  Future<void> login() async {
    try {
      final result = await _dio.post<dynamic>(
        '/api/v1/login',
      );
      final data = ApiResult.fromJson(result.data as Map<String, dynamic>);
      Log.i(data);

    } catch (e) {
      Log.e(e);
    }
  }
}