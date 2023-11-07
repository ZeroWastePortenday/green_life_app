import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_life_app/const/secret_consts.dart';
import 'package:green_life_app/utils/logger.dart';

final dioProvider = FutureProvider<Dio>((ref) async {
  final dio = Dio(
    BaseOptions(
      baseUrl: apiServerBaseUrl,
      followRedirects: false,
      // will not throw errors
      validateStatus: (status) => true,
    ),
  );
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        Log.i('uri: ${options.uri}');
        return handler.next(options);
      },
      onResponse: (response, handler) async {
        Log.i('response: ${response.data}');
        return handler.next(response);
      },
    ),
  );
  return dio;
});

// get base headers
Future<Options> getBaseHeaders() async {
  final currentUser = FirebaseAuth.instance.currentUser;
  final firebaseToken = await currentUser?.getIdToken();
  return Options(
    headers: {
      'Firebase-Token': firebaseToken,
      'Content-Type': 'application/json',
    },
  );
}
