import 'dart:io';
import 'package:elevate_tracking_app/domain/entites/driver_entity.dart';
import 'package:elevate_tracking_app/domain/entites/requests/update_profile_info_request_entity.dart';
import 'package:elevate_tracking_app/domain/entites/upload_profile_image_response_entity.dart';
import 'package:elevate_tracking_app/domain/entites/vehicle_entity.dart';
import 'package:elevate_tracking_app/domain/entites/logout_response_entity.dart';
import '../../core/api_result/api_result.dart';
import '../../domain/entites/login_entity.dart';
import '../../domain/entites/requests/login_request_entity.dart';

abstract interface class AuthRemoteDataSource {
  Future<ApiResult<LoginEntity>> login(LoginRequestEntity loginRequestEntity);

  Future<ApiResult<DriverEntity>> getLoggedDriverData();

  Future<ApiResult<DriverEntity>> editProfile(
    UpdateProfileInfoRequestEntity updateProfileInfoRequestEntity,
  );

  Future<ApiResult<UploadProfileImageResponseEntity>> uploadProfilePhoto(File file);

  Future<ApiResult<VehicleEntity>> getVehicle(String id);

  Future<ApiResult<LogoutResponseEntity>> logout();

}
