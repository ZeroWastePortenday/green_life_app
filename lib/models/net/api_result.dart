import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_result.g.dart';

@JsonSerializable(explicitToJson: true)
class ApiResult {
  ApiResult({this.status, this.message, this.data});

  factory ApiResult.fromJson(Map<String, dynamic> json) =>
      _$ApiResultFromJson(json);

  factory ApiResult.fromDynamic(dynamic data) =>
      ApiResult.fromJson(data as Map<String, dynamic>);

  final int? status;
  final String? message;
  final Map<String, dynamic>? data;

  Map<String, dynamic> toJson() => _$ApiResultToJson(this);
}
