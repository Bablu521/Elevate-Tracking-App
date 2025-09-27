import 'package:elevate_tracking_app/api/client/api_client.dart';
import 'package:elevate_tracking_app/api/mapper/apply_mapper.dart';
import 'package:elevate_tracking_app/api/mapper/auth/forget_password/forget_password_mapper.dart';
import 'package:elevate_tracking_app/api/mapper/login_mapper.dart';
import 'package:elevate_tracking_app/api/models/requests/apply_request_dto.dart';
import 'package:elevate_tracking_app/api/models/responses/apply_response_dto.dart';
import 'package:elevate_tracking_app/api/models/responses/vehicles_response.dart';
import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/core/api_result/safe_api_call.dart';
import 'package:elevate_tracking_app/data/data_source/auth_remote_data_source.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/apply_response_entity.dart';
import '../../domain/entities/email_verification_entity.dart';
import '../../domain/entities/forget_password_entity.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/entities/request/apply_request_entity.dart';
import '../../domain/entities/requests/email_verification_request_entity.dart';
import '../../domain/entities/requests/forget_password_request_entity.dart';
import '../../domain/entities/requests/login_request_entity.dart';
import '../../domain/entities/requests/reset_password_request_entity.dart';
import '../../domain/entities/reset_password_entity.dart';
import '../../domain/entities/vehicles_entity.dart';

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

  @override
  Future<ApiResult<ForgetPasswordEntity>> forgetPassword(
    ForgetPasswordRequestEntity request,
  ) async {
    return safeApiCall(
      () => _apiClient.forgetPassword(request.toRequest()),
      (response) => response.toEntity(),
    );
  }

  @override
  Future<ApiResult<ResetPasswordEntity>> resetPassword(
    ResetPasswordRequestEntity request,
  ) async {
    return safeApiCall(
      () => _apiClient.resetPassword(request.toRequest()),
      (response) => response.toEntity(),
    );
  }

  @override
  Future<ApiResult<EmailVerificationEntity>> emailVerification(
    EmailVerificationRequestEntity request,
  ) async {
    return safeApiCall(
      () => _apiClient.emailVerification(request.toRequest()),
      (response) => response.toEntity(),
    );
  }
}
