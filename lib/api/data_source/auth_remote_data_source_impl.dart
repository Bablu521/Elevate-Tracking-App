import 'package:elevate_tracking_app/api/mapper/auth/forget_password/forget_password_mapper.dart';
import 'package:elevate_tracking_app/data/data_source/auth_remote_data_source.dart';
import 'package:injectable/injectable.dart';

import '../../core/api_result/api_result.dart';
import '../../core/api_result/safe_api_call.dart';
import '../../domain/entities/email_verification_entity.dart';
import '../../domain/entities/forget_password_entity.dart';
import '../../domain/entities/requests/email_verification_request_entity.dart';
import '../../domain/entities/requests/forget_password_request_entity.dart';
import '../../domain/entities/requests/reset_password_request_entity.dart';
import '../../domain/entities/reset_password_entity.dart';
import '../client/api_client.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient _apiClient;

  AuthRemoteDataSourceImpl(this._apiClient);

  @override
  Future<ApiResult<ForgetPasswordEntity>> forgetPassword(
    ForgetPasswordRequestEntity request,
  ) async {
    return safeApiCall(
      () => _apiClient.forgetPassword(request.toRequest()),
      (response) => response.toEntity(),
    );
  }

  @override
  Future<ApiResult<ResetPasswordEntity>> resetPassword(
    ResetPasswordRequestEntity request,
  ) async {
    return safeApiCall(
      () => _apiClient.resetPassword(request.toRequest()),
      (response) => response.toEntity(),
    );
  }

  @override
  Future<ApiResult<EmailVerificationEntity>> emailVerification(
    EmailVerificationRequestEntity request,
  ) async {
    return safeApiCall(
      () => _apiClient.emailVerification(request.toRequest()),
      (response) => response.toEntity(),
    );
  }
}
