import 'dart:io';
import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/domain/entites/driver_entity.dart';
import 'package:elevate_tracking_app/domain/entites/login_entity.dart';
import 'package:elevate_tracking_app/domain/entites/logout_response_entity.dart';
import 'package:elevate_tracking_app/domain/entites/requests/login_request_entity.dart';
import 'package:elevate_tracking_app/domain/entites/requests/update_profile_info_request_entity.dart';
import 'package:elevate_tracking_app/domain/entites/upload_profile_image_response_entity.dart';
import 'package:elevate_tracking_app/domain/entites/vehicle_entity.dart';
import 'package:elevate_tracking_app/domain/repo/auth_repo.dart';
import 'package:injectable/injectable.dart';
import '../data_source/auth_local_data_source.dart';
import '../data_source/auth_remote_data_source.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource _authRemoteDataSource;
  final AuthLocalDataSource _authLocalDataSource;

  AuthRepoImpl(this._authRemoteDataSource, this._authLocalDataSource);

  @override
  Future<ApiResult<LoginEntity>> login(
    LoginRequestEntity loginRequestEntity,
  ) async {
    final result = await _authRemoteDataSource.login(loginRequestEntity);
    switch (result) {
      case ApiSuccessResult<LoginEntity>():
        _authLocalDataSource.saveUserToken(token: result.data.token);
        _authLocalDataSource.saveUserRememberMe(
          loginRequestEntity: loginRequestEntity,
        );
        break;
      case ApiErrorResult<LoginEntity>():
        _authLocalDataSource.saveUserRememberMe(
          loginRequestEntity: loginRequestEntity,
        );
        break;
    }
    return result;
  }

  @override
  Future<ApiResult<DriverEntity>> getLoggedDriverData() {
    return _authRemoteDataSource.getLoggedDriverData();
  }

  @override
  Future<ApiResult<DriverEntity>> editProfile(
    UpdateProfileInfoRequestEntity updateProfileInfoRequestEntity,
  ) {
    return _authRemoteDataSource.editProfile(updateProfileInfoRequestEntity);
  }

  @override
  Future<ApiResult<UploadProfileImageResponseEntity>> uploadProfilePhoto(
    File file,
  ) {
    return _authRemoteDataSource.uploadProfilePhoto(file);
  }

  @override
  Future<ApiResult<VehicleEntity>> getVehicle(String id) {
    return _authRemoteDataSource.getVehicle(id);
  }

  @override
  Future<ApiResult<LogoutResponseEntity>> logout() async {
    final response = await _authRemoteDataSource.logout();
    await _authLocalDataSource.userLogout();
    return response;
  }
}
