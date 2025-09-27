import 'package:elevate_tracking_app/core/api_result/api_result.dart';

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
import '../entities/vehicles_entity.dart';

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
