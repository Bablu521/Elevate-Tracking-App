import 'package:elevate_tracking_app/api/client/api_client.dart';
import 'package:elevate_tracking_app/api/mapper/change_password_mapper.dart';
import 'package:elevate_tracking_app/api/mapper/login_mapper.dart';
import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/core/api_result/safe_api_call.dart';
import 'package:elevate_tracking_app/data/data_source/auth_remote_data_source.dart';
import 'package:elevate_tracking_app/domain/entites/login_entity.dart';
import 'package:elevate_tracking_app/domain/entites/requests/login_request_entity.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entites/requests/change_password_request_entity.dart';
import '../../domain/entites/response/change_password_response_entity.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient _apiClient;

  AuthRemoteDataSourceImpl(this._apiClient);

  @override
  Future<ApiResult<LoginEntity>> login(LoginRequestEntity loginRequestEntity) {
    return safeApiCall(
      () => _apiClient.login(loginRequestEntity.toRequest()),
      (response) => response.toEntity(),
    );
  }

  @override
  Future<ApiResult<ChangePasswordResponseEntity>> changePassword(
      ChangePasswordRequestEntity request,
      ) async {
    return safeApiCall(
          () => _apiClient.changePassword(request.fromDomain()),
          (response) => response.toEntity(),
    );
  }
}
