import '../../core/api_result/api_result.dart';
import '../../domain/entites/login_entity.dart';
import '../../domain/entites/requests/login_request_entity.dart';

abstract interface class AuthRemoteDataSource {
  Future<ApiResult<LoginEntity>> login(LoginRequestEntity loginRequestEntity);
}
