import 'dart:io';
import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/domain/entities/driver_entity.dart';
import 'package:elevate_tracking_app/domain/entities/logout_response_entity.dart';
import 'package:elevate_tracking_app/domain/entities/requests/update_profile_info_request_entity.dart';
import 'package:elevate_tracking_app/domain/entities/requests/update_vehicle_request_entity.dart';
import 'package:elevate_tracking_app/domain/entities/upload_profile_image_response_entity.dart';
import 'package:elevate_tracking_app/domain/entities/vehicle_entity.dart';
import 'package:elevate_tracking_app/domain/entities/vehicles_entity.dart';
import '../entities/apply_response_entity.dart';
import '../entities/country_entity.dart';
import '../entities/email_verification_entity.dart';
import '../entities/forget_password_entity.dart';
import '../entities/login_entity.dart';
import '../entities/request/apply_request_entity.dart';
import '../entities/requests/email_verification_request_entity.dart';
import '../entities/requests/forget_password_request_entity.dart';
import '../entities/requests/login_request_entity.dart';
import '../entities/requests/reset_password_request_entity.dart';
import '../entities/reset_password_entity.dart';

abstract interface class AuthRepo {
  Future<ApiResult<ApplyResponseEntity>> apply({
    required ApplyRequestEntity request,
  });

  Future<ApiResult<List<VehiclesEntity>>> getAllVehicles();

  Future<ApiResult<List<CountryEntity>>> getAllCountries();

  Future<ApiResult<LoginEntity>> login(LoginRequestEntity loginRequestEntity);

  Future<ApiResult<ForgetPasswordEntity>> forgetPassword(
      ForgetPasswordRequestEntity request,
      );

  Future<ApiResult<EmailVerificationEntity>> emailVerification(
      EmailVerificationRequestEntity request,
      );

  Future<ApiResult<ResetPasswordEntity>> resetPassword(
      ResetPasswordRequestEntity request,
      );

  Future<ApiResult<DriverEntity>> getLoggedDriverData();

  Future<ApiResult<DriverEntity>> editProfile(
      UpdateProfileInfoRequestEntity updateProfileInfoRequestEntity,
      );

  Future<ApiResult<UploadProfileImageResponseEntity>> uploadProfilePhoto(
      File file,
      );

  Future<ApiResult<VehicleEntity>> getVehicle(String id);

  Future<ApiResult<LogoutResponseEntity>> logout();

  Future<ApiResult<DriverEntity>> updateVehicleInfo(
      UpdateVehicleRequestEntity request,
      );

  Future<ApiResult<ChangePasswordResponseEntity>> changePassword(
      ChangePasswordRequestEntity request,
      );
}
