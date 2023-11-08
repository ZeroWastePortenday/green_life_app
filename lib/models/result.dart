import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:green_life_app/models/api_data.dart';
import 'package:green_life_app/models/net/api_result_list.dart';

part 'result.freezed.dart';

@freezed
class Result<T> with _$Result<T> {
  const factory Result.success(T data) = Success;

  const factory Result.error(String message) = Error;

  const factory Result.loading({T? data}) = Loading;

  const factory Result.empty() = Empty;

  static Result<List<T>> getList<T>(
    Response<dynamic> result,
    ApiData<T> fromDynamic,
    String message,
  ) {
    return Result.getExpectedList(
      result,
      ApiResultList.fromDynamic<T>(result.data, fromDynamic),
      message,
    );
  }

  static Result<T> getResult<T>(
    Response<dynamic> result,
    ApiData<T> fromDynamic,
    String message,
  ) {
    return Result.getExpected(result, fromDynamic(result.data), message);
  }

  static Result<List<T>> getExpectedList<T>(
    Response<dynamic> result,
    List<T> expected,
    String message,
  ) {
    if (result.statusCode == 200 || result.statusCode == 201) {
      return Result.success(expected);
    }
    return Result.error('code: ${result.statusCode}, $message');
  }

  static Result<T> getExpected<T>(
    Response<dynamic> result,
    T expected,
    String message,
  ) {
    if (result.statusCode == 200 || result.statusCode == 201) {
      return Result.success(expected);
    }
    return Result.error('code: ${result.statusCode}, $message');
  }
}
