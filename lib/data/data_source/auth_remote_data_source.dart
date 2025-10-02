import '../../core/api_result/api_result.dart';
import '../../domain/entites/login_entity.dart';
import '../../domain/entites/requests/change_password_request_entity.dart';
import '../../domain/entites/requests/login_request_entity.dart';
import '../../domain/entites/response/change_password_response_entity.dart';

abstract interface class AuthRemoteDataSource {
  Future<ApiResult<LoginEntity>> login(LoginRequestEntity loginRequestEntity);

  Future<ApiResult<ChangePasswordResponseEntity>> changePassword(
      ChangePasswordRequestEntity request,
      );

}
