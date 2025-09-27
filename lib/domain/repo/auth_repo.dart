import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/domain/entites/apply_response_entity.dart';
import 'package:elevate_tracking_app/domain/entites/country_entity.dart';
import 'package:elevate_tracking_app/domain/entites/request/apply_request_entity.dart';
import 'package:elevate_tracking_app/domain/entites/vehicles_entity.dart';
import 'package:elevate_tracking_app/domain/entites/login_entity.dart';
import 'package:elevate_tracking_app/domain/entites/requests/login_request_entity.dart';

abstract interface class AuthRepo {
  Future<ApiResult<ApplyResponseEntity>> apply({
    required ApplyRequestEntity request,
  });

  Future<ApiResult<List<VehicleEntity>>> getAllVehicles();

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
}
