import 'package:elevate_tracking_app/domain/repo/auth_repo.dart';
import 'package:injectable/injectable.dart';

import '../../core/api_result/api_result.dart';
import '../../domain/entities/email_verification_entity.dart';
import '../../domain/entities/forget_password_entity.dart';
import '../../domain/entities/requests/email_verification_request_entity.dart';
import '../../domain/entities/requests/forget_password_request_entity.dart';
import '../../domain/entities/requests/reset_password_request_entity.dart';
import '../../domain/entities/reset_password_entity.dart';
import '../data_source/auth_remote_data_source.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRepoImpl(this._authRemoteDataSource);

  @override
  Future<ApiResult<ForgetPasswordEntity>> forgetPassword(
    ForgetPasswordRequestEntity request,
  ) {
    return _authRemoteDataSource.forgetPassword(request);
  }

  @override
  Future<ApiResult<ResetPasswordEntity>> resetPassword(
    ResetPasswordRequestEntity request,
  ) {
    return _authRemoteDataSource.resetPassword(request);
  }

  @override
  Future<ApiResult<EmailVerificationEntity>> emailVerification(
    EmailVerificationRequestEntity request,
  ) {
    return _authRemoteDataSource.emailVerification(request);
  }
}
