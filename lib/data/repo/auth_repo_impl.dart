import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/domain/entites/email_verification_entity.dart';
import 'package:elevate_tracking_app/domain/entites/forget_password_request_entity.dart';
import 'package:elevate_tracking_app/domain/entites/forget_password_response_entity.dart';
import 'package:elevate_tracking_app/domain/repo/auth_repo.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entites/email_verification_request_entity.dart';
import '../../domain/entites/reset_password_request_entity.dart';
import '../../domain/entites/reset_password_response_entity.dart';
import '../data_source/auth_remote_data_source.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements  AuthRepo {
  AuthRemoteDataSource authRemoteDataSource;
  AuthRepoImpl( this.authRemoteDataSource);
  @override
  Future<ApiResult<ForgetPasswordResponseEntity>>
  forgetPassword(ForgetPasswordRequestEntity request) {
    return authRemoteDataSource.forgetPassword(request);
  }
  @override
  Future<ApiResult<EmailVerificationEntity>> verifyResetCode(
      EmailVerificationRequestEntity request,
      ) {
    return authRemoteDataSource.verifyResetCode(request);
  }

  @override
  Future<ApiResult<ResetPasswordResponseEntity>> resetPassword(
      ResetPasswordRequestEntity request,
      ) {
    return authRemoteDataSource.resetPassword(request);
  }
  
}