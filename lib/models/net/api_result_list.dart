import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_result_list.g.dart';

@JsonSerializable(explicitToJson: true)
class ApiResultList {
  ApiResultList({this.status, this.message, this.data});

  factory ApiResultList.fromJson(Map<String, dynamic> json) =>
      _$ApiResultListFromJson(json);

  factory ApiResultList.fromDynamic(dynamic data) =>
      ApiResultList.fromJson(data as Map<String, dynamic>);

  final int? status;
  final String? message;
  final List<Map<String, dynamic>>? data;

  Map<String, dynamic> toJson() => _$ApiResultListToJson(this);
}
