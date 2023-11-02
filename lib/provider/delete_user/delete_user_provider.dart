
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_life_app/provider/api/user_api.dart';

final deleteUserProvider = FutureProvider<bool>((ref) async {
  final userApi = await ref.read(userApiProvider.future);
  return userApi.deleteUser();
});
