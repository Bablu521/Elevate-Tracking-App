import 'package:injectable/injectable.dart';

import '../../core/api_result/api_result.dart';
import '../entities/forget_password_entity.dart';
import '../entities/requests/forget_password_request_entity.dart';
import '../repo/auth_repo.dart';

@injectable
class ForgetPasswordUseCase {
  final AuthRepo _authRepo;

  ForgetPasswordUseCase(this._authRepo);

  Future<ApiResult<ForgetPasswordEntity>> call(
    ForgetPasswordRequestEntity request,
  ) {
    return _authRepo.forgetPassword(request);
  }
}
