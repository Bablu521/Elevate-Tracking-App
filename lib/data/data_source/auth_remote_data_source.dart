import '../../core/api_result/api_result.dart';
import '../../domain/entites/email_verification_entity.dart';
import '../../domain/entites/email_verification_request_entity.dart';
import '../../domain/entites/forget_password_request_entity.dart';
import '../../domain/entites/forget_password_response_entity.dart';
import '../../domain/entites/reset_password_request_entity.dart';
import '../../domain/entites/reset_password_response_entity.dart';

abstract interface class AuthRemoteDataSource {

  Future<ApiResult<ForgetPasswordResponseEntity>>forgetPassword(
      ForgetPasswordRequestEntity request,
      );

  Future<ApiResult<EmailVerificationEntity>> verifyResetCode(
      EmailVerificationRequestEntity request,
      );

  Future<ApiResult<ResetPasswordResponseEntity>> resetPassword(
      ResetPasswordRequestEntity request,
      );


}