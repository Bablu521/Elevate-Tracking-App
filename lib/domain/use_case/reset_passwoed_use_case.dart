import 'package:injectable/injectable.dart';

import '../../core/api_result/api_result.dart';
import '../entites/reset_password_request_entity.dart';
import '../entites/reset_password_response_entity.dart';
import '../repo/auth_repo.dart';

@injectable
class ResetPasswordUseCase {
  final AuthRepo _authRepo;

  ResetPasswordUseCase(this._authRepo);

  Future<ApiResult<ResetPasswordResponseEntity>> call(ResetPasswordRequestEntity request) async {
    return await _authRepo.resetPassword(request);
  }
}