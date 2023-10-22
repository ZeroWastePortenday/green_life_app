import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:green_life_app/models/net/api_result.dart';

part 'api_user.freezed.dart';

part 'api_user.g.dart';

@freezed
class ApiUser with _$ApiUser {
  const factory ApiUser({
    required int status,
    required int? id,
    required String? nickname,
  }) = _ApiUser;

  factory ApiUser.fromJson(Map<String, dynamic> json) => _$ApiUserFromJson(json);

  factory ApiUser.fromDynamic(dynamic data) =>
      ApiUser.fromJson(ApiResult.fromDynamic(data).data!);
}
