import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/data/data_source/auth_local_data_source.dart';
import 'package:elevate_tracking_app/data/data_source/auth_remote_data_source.dart';
import 'package:elevate_tracking_app/domain/repo/auth_repo.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/apply_response_entity.dart';
import '../../domain/entities/country_entity.dart';
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

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource _authRemoteDataSource;
  final AuthLocalDataSource _authLocalDataSource;

  AuthRepoImpl(this._authRemoteDataSource, this._authLocalDataSource);

  @override
  Future<ApiResult<ApplyResponseEntity>> apply({
    required ApplyRequestEntity request,
  }) async {
    return await _authRemoteDataSource.apply(request: request);
  }

  @override
  Future<ApiResult<List<VehicleEntity>>> getAllVehicles() async {
    return await _authRemoteDataSource.getAllVehicles();
  }

  @override
  Future<ApiResult<List<CountryEntity>>> getAllCountries() async {
    return await _authLocalDataSource.getAllCountry();
  }

  @override
  Future<ApiResult<LoginEntity>> login(
    LoginRequestEntity loginRequestEntity,
  ) async {
    final result = await _authRemoteDataSource.login(loginRequestEntity);
    switch (result) {
      case ApiSuccessResult<LoginEntity>():
        _authLocalDataSource.saveUserToken(token: result.data.token);
        _authLocalDataSource.saveUserRememberMe(
          loginRequestEntity: loginRequestEntity,
        );
        break;
      case ApiErrorResult<LoginEntity>():
        _authLocalDataSource.saveUserRememberMe(
          loginRequestEntity: loginRequestEntity,
        );
        break;
    }
    return result;
  }

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
