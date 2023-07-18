import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_life_app/const/secret_consts.dart';

final dioProvider = FutureProvider<Dio>((ref) async {
  final currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser == null) return Dio();
  return Dio(
    BaseOptions(
      baseUrl: apiServerBaseUrl,
      headers: {
        'Authorization': await currentUser.getIdToken(),
      },
    ),
  );
});
