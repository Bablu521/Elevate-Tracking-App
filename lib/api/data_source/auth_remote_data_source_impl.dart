import 'dart:io';
import 'package:dio/dio.dart';
import 'package:elevate_tracking_app/api/client/api_client.dart';
import 'package:elevate_tracking_app/api/mapper/apply_mapper.dart';
import 'package:elevate_tracking_app/api/mapper/auth/forget_password/forget_password_mapper.dart';
import 'package:elevate_tracking_app/api/mapper/change_password_mapper.dart';
import 'package:elevate_tracking_app/api/mapper/login_mapper.dart';
import 'package:elevate_tracking_app/api/models/requests/apply_request_dto.dart';
import 'package:elevate_tracking_app/api/models/requests/auth/update_vehicle_request_dto.dart';
import 'package:elevate_tracking_app/api/models/responses/apply_response_dto.dart';
import 'package:elevate_tracking_app/api/models/responses/profile_info_response_dto/profile_info_response_dto.dart';
import 'package:elevate_tracking_app/api/models/responses/vehicles_response.dart';
import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/core/api_result/safe_api_call.dart';
import 'package:elevate_tracking_app/data/data_source/auth_remote_data_source.dart';
import 'package:elevate_tracking_app/api/mapper/profile_info_mapper.dart';
import 'package:elevate_tracking_app/api/models/responses/logout_response_dto.dart';
import 'package:elevate_tracking_app/domain/entities/logout_response_entity.dart';
import 'package:elevate_tracking_app/domain/entities/requests/update_profile_info_request_entity.dart';
import 'package:elevate_tracking_app/domain/entities/requests/update_vehicle_request_entity.dart';
import 'package:elevate_tracking_app/domain/entities/upload_profile_image_response_entity.dart';
import 'package:elevate_tracking_app/domain/entities/vehicle_entity.dart';
import 'package:elevate_tracking_app/domain/entities/vehicles_entity.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entites/driver_entity.dart';
import '../../domain/entites/response/change_password_response_entity.dart';
import '../../domain/entities/apply_response_entity.dart';
import '../../domain/entities/email_verification_entity.dart';
import '../../domain/entities/forget_password_entity.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/entities/request/apply_request_entity.dart';
import '../../domain/entities/requests/change_password_request_entity.dart';
import '../../domain/entities/requests/email_verification_request_entity.dart';
import '../../domain/entities/requests/forget_password_request_entity.dart';
import '../../domain/entities/requests/login_request_entity.dart';
import '../../domain/entities/requests/reset_password_request_entity.dart';
import '../../domain/entities/reset_password_entity.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient _apiClient;

  AuthRemoteDataSourceImpl(this._apiClient);

  @override
  Future<ApiResult<ApplyResponseEntity>> apply({
    required ApplyRequestEntity request,
  }) async {
    return safeApiCall<ApplyResponseDto, ApplyResponseEntity>(() async {
      final ApplyRequestDto dto = ApplyRequestMapper(request).toDto();
      final formData = await dto.toFormData();
      return await _apiClient.apply(formData);
    }, (dto) => dto.toEntity());
  }

  @override
  Future<ApiResult<List<VehiclesEntity>>> getAllVehicles() async {
    return safeApiCall<VehiclesResponse, List<VehiclesEntity>>(
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
  Future<ApiResult<DriverEntity>> getLoggedDriverData() {
    return safeApiCall(
          () => _apiClient.getLoggedDriverData(),
          (response) => response.driver!.toEntity(),
    );
  }

  @override
  Future<ApiResult<DriverEntity>> editProfile(
      UpdateProfileInfoRequestEntity updateProfileInfoRequestEntity,
      ) {
    return safeApiCall(
          () => _apiClient.editProfile(updateProfileInfoRequestEntity.toDto()),
          (response) => response.driver!.toEntity(),
    );
  }

  @override
  Future<ApiResult<UploadProfileImageResponseEntity>> uploadProfilePhoto(
      File file,
      ) async {
    final multipartFile = await MultipartFile.fromFile(
      file.path,
      filename: file.uri.pathSegments.last,
    );
    return safeApiCall(
          () => _apiClient.uploadProfilePhoto(multipartFile),
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

  @override
  Future<ApiResult<VehicleEntity>> getVehicle(String id) {
    return safeApiCall(
          () => _apiClient.getVehicle(id),
          (response) => response.vehicle!.toEntity(),
    );
  }

  @override
  Future<ApiResult<LogoutResponseEntity>> logout() async {
    return safeApiCall<LogoutResponseDto, LogoutResponseEntity>(
          () => _apiClient.logout(),
          (dto) => dto.toEntity(),
    );
  }

  @override
  Future<ApiResult<DriverEntity>> updateVehicleInfo(
      UpdateVehicleRequestEntity request,
      ) async {
    return safeApiCall<ProfileInfoResponseDto, DriverEntity>(() async {
      final UpdateVehicleRequestDto dto = request.toDto();
      final formData = await dto.toFormData();
      return await _apiClient.updateVehicleInfo(formData);
    }, (dto) => dto.driver!.toEntity());
  }

  @override
  Future<ApiResult<ChangePasswordResponseEntity>> changePassword(
      ChangePasswordRequestEntity request,
      ) async {
    return safeApiCall(
          () => _apiClient.changePassword(request.fromDomain()),
          (response) => response.toEntity(),
    );
  }
}
