import 'package:elevate_tracking_app/domain/repo/auth_repo.dart';
import 'package:injectable/injectable.dart';

import '../../core/api_result/api_result.dart';
import '../entities/login_entity.dart';
import '../entities/requests/login_request_entity.dart';

@injectable
class LoginUseCase {
  final AuthRepo _authRepo;

  LoginUseCase(this._authRepo);

  Future<ApiResult<LoginEntity>> call(
    LoginRequestEntity loginRequestEntity,
  ) async {
    return await _authRepo.login(loginRequestEntity);
  }
}
