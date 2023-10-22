import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_life_app/const/secret_consts.dart';

final dioProvider = FutureProvider<Dio>((ref) async {
  final currentUser = FirebaseAuth.instance.currentUser;

  final dio = _makeDio();

  if (currentUser == null) return dio;

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final firebaseToken = await currentUser.getIdToken();
        options.headers['Firebase-Token'] = firebaseToken?.substring(0, 600);
        options.headers['Content-Type'] = 'application/json';
        return handler.next(options);
      },
    ),
  );
  return dio;
});

Dio _makeDio() {
  final dio = Dio(
    BaseOptions(
      baseUrl: apiServerBaseUrl,
      followRedirects: false,
      // will not throw errors
      validateStatus: (status) => true,
      responseType: ResponseType.json,
    ),
  );
  return dio;
}
