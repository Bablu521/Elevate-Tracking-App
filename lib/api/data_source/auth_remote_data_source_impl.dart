import 'package:elevate_tracking_app/api/client/api_client.dart';
import 'package:elevate_tracking_app/api/mapper/apply_mapper.dart';
import 'package:elevate_tracking_app/api/mapper/login_mapper.dart';
import 'package:elevate_tracking_app/api/models/requests/apply_request_dto.dart';
import 'package:elevate_tracking_app/api/models/responses/apply_response_dto.dart';
import 'package:elevate_tracking_app/api/models/responses/vehicles_response.dart';
import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/core/api_result/safe_api_call.dart';
import 'package:elevate_tracking_app/data/data_source/auth_remote_data_source.dart';
import 'package:elevate_tracking_app/domain/entites/apply_response_entity.dart';
import 'package:elevate_tracking_app/domain/entites/request/apply_request_entity.dart';
import 'package:elevate_tracking_app/domain/entites/vehicles_entity.dart';
import 'package:elevate_tracking_app/domain/entites/login_entity.dart';
import 'package:elevate_tracking_app/domain/entites/requests/login_request_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient _apiClient;

  AuthRemoteDataSourceImpl(this._apiClient);

  @override
  Future<ApiResult<ApplyResponseEntity>> apply({
    required ApplyRequestEntity request,
  }) async {
    return safeApiCall<ApplyResponseDto, ApplyResponseEntity>(() async {
      final ApplyRequestDto dto = request.toDto();
      final formData = await dto.toFormData();
      return await _apiClient.apply(formData);
    }, (dto) => dto.toEntity());
  }

  @override
  Future<ApiResult<List<VehicleEntity>>> getAllVehicles() async {
    return safeApiCall<VehiclesResponse, List<VehicleEntity>>(
      () => _apiClient.getAllVehicles(),
      (dto) => dto.vehicles?.map((v) => v.toEntity()).toList() ?? [],
    );
  }

  @override
  Future<ApiResult<LoginEntity>> login(LoginRequestEntity loginRequestEntity) {
    return safeApiCall(
      () => _apiClient.login(loginRequestEntity.toRequest()),
      (response) => response.toEntity(),
    );
  }
}
