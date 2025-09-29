import 'package:elevate_tracking_app/api/client/api_client.dart';
import 'package:elevate_tracking_app/api/mapper/login_mapper.dart';
import 'package:elevate_tracking_app/api/mapper/profile_info_mapper.dart';
import 'package:elevate_tracking_app/api/models/responses/logout_response_dto.dart';
import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/core/api_result/safe_api_call.dart';
import 'package:elevate_tracking_app/data/data_source/auth_remote_data_source.dart';
import 'package:elevate_tracking_app/domain/entites/login_entity.dart';
import 'package:elevate_tracking_app/domain/entites/logout_response_entity.dart';
import 'package:elevate_tracking_app/domain/entites/requests/login_request_entity.dart';
import 'package:injectable/injectable.dart';

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
  Future<ApiResult<LogoutResponseEntity>> logout() async {
    return safeApiCall<LogoutResponseDto, LogoutResponseEntity>(
      () => _apiClient.logout(),
      (dto) => dto.toEntity(),
    );
  }
}
