import 'package:injectable/injectable.dart';

import '../../core/api_result/api_result.dart';
import '../entities/requests/reset_password_request_entity.dart';
import '../entities/reset_password_entity.dart';
import '../repo/auth_repo.dart';

@injectable
class ResetPasswordUseCase {
  final AuthRepo _authRepo;

  ResetPasswordUseCase(this._authRepo);

  Future<ApiResult<ResetPasswordEntity>> call(
    ResetPasswordRequestEntity request,
  ) async {
    return await _authRepo.resetPassword(request);
  }
}
