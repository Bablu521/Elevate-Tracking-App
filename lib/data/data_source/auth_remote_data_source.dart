import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/domain/entites/apply_response_entity.dart';
import 'package:elevate_tracking_app/domain/entites/request/apply_request_entity.dart';
import 'package:elevate_tracking_app/domain/entites/vehicles_entity.dart';

abstract interface class AuthRemoteDataSource {
  Future<ApiResult<ApplyResponseEntity>> apply({
    required ApplyRequestEntity request,
  });
  Future<ApiResult<List<VehicleEntity>>> getAllVehicles();
}
