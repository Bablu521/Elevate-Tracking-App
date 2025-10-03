import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/domain/entities/logout_response_entity.dart';
import 'package:elevate_tracking_app/domain/repo/auth_repo.dart';

import 'package:injectable/injectable.dart';

@injectable
class LogoutUseCase {
  final AuthRepo _authRepo;
  LogoutUseCase(this._authRepo);

  Future<ApiResult<LogoutResponseEntity>> call() async {
    return await _authRepo.logout();
  }
}
