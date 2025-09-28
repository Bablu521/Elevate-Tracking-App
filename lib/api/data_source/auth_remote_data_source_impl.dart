import 'dart:io';
import 'package:dio/dio.dart';
import 'package:elevate_tracking_app/api/client/api_client.dart';
import 'package:elevate_tracking_app/api/mapper/login_mapper.dart';
import 'package:elevate_tracking_app/api/mapper/profile_info_mapper.dart';
import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/core/api_result/safe_api_call.dart';
import 'package:elevate_tracking_app/data/data_source/auth_remote_data_source.dart';
import 'package:elevate_tracking_app/domain/entites/driver_entity.dart';
import 'package:elevate_tracking_app/domain/entites/login_entity.dart';
import 'package:elevate_tracking_app/domain/entites/requests/login_request_entity.dart';
import 'package:elevate_tracking_app/domain/entites/requests/update_profile_info_request_entity.dart';
import 'package:elevate_tracking_app/domain/entites/upload_profile_image_response_entity.dart';
import 'package:elevate_tracking_app/domain/entites/vehicle_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient _apiClient;

  AuthRemoteDataSourceImpl(this._apiClient);

  @override
  Future<ApiResult<LoginEntity>> login(LoginRequestEntity loginRequestEntity) {
    return safeApiCall(
      () => _apiClient.login(loginRequestEntity.toRequest()),
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
  Future<ApiResult<VehicleEntity>> getVehicle(String id) {
    return safeApiCall(
      () => _apiClient.getVehicle(id),
      (response) => response.vehicle!.toEntity(),
    );
  }
}
