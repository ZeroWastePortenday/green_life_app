import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:green_life_app/models/api_data.dart';

part 'api_result_list.g.dart';

@JsonSerializable(explicitToJson: true)
class ApiResultList {
  ApiResultList({this.status, this.message, this.data});

  factory ApiResultList.fromJson(Map<String, dynamic> json) =>
      _$ApiResultListFromJson(json);

  static List<T> fromDynamic<T>(dynamic data, ApiData<T> fromDynamic) {
    final jsonList = ApiResultList.fromJson(data as Map<String, dynamic>);
    return (jsonList.data!).map(fromDynamic).toList();
  }

  final int? status;
  final String? message;
  final List<Map<String, dynamic>>? data;

  Map<String, dynamic> toJson() => _$ApiResultListToJson(this);
}
