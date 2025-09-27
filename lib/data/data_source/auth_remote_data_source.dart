import 'package:elevate_tracking_app/core/api_result/api_result.dart';

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

abstract interface class AuthRemoteDataSource {
  Future<ApiResult<ApplyResponseEntity>> apply({
    required ApplyRequestEntity request,
  });

  Future<ApiResult<List<VehicleEntity>>> getAllVehicles();

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
