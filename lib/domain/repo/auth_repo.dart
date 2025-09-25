import 'package:elevate_tracking_app/domain/entites/email_verification_request_entity.dart';
import 'package:elevate_tracking_app/domain/entites/forget_password_request_entity.dart';
import 'package:elevate_tracking_app/domain/entites/forget_password_response_entity.dart';

import '../../core/api_result/api_result.dart';
import '../entites/email_verification_entity.dart';
import '../entites/reset_password_request_entity.dart';
import '../entites/reset_password_response_entity.dart';

abstract interface class AuthRepo {

   Future <ApiResult<ForgetPasswordResponseEntity>>forgetPassword(
       ForgetPasswordRequestEntity request,
       );

   Future<ApiResult<EmailVerificationEntity>> verifyResetCode(
       EmailVerificationRequestEntity request,
       );

   Future<ApiResult<ResetPasswordResponseEntity>> resetPassword(
       ResetPasswordRequestEntity request,
       );

}