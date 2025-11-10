import 'package:dio/dio.dart';
import 'package:elevate_tracking_app/core/api_result/dio_error_handler.dart';

sealed class ApiResult<T> {}

class ApiSuccessResult<T> extends ApiResult<T> {
  T data;
  ApiSuccessResult(this.data);
}

class ApiErrorResult<T> extends ApiResult<T> {
  Object error;
  late String errorMessage;
  ApiErrorResult(this.error) {
    if (error is DioException) {
      errorMessage = handleDioError(error as DioException);
    } else {
      errorMessage = error.toString();
    }
  }
}



