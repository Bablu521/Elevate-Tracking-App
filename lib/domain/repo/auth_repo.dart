import '../../core/api_result/api_result.dart';
import '../entities/email_verification_entity.dart';
import '../entities/forget_password_entity.dart';
import '../entities/requests/email_verification_request_entity.dart';
import '../entities/requests/forget_password_request_entity.dart';
import '../entities/requests/reset_password_request_entity.dart';
import '../entities/reset_password_entity.dart';

abstract interface class AuthRepo {
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
