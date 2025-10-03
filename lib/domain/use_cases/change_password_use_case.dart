import 'package:elevate_tracking_app/domain/entites/response/change_password_response_entity.dart';
import 'package:elevate_tracking_app/domain/repo/auth_repo.dart';
import 'package:injectable/injectable.dart';
import '../../core/api_result/api_result.dart';
import '../entites/requests/change_password_request_entity.dart';

@injectable
class ChangePasswordUseCase {
  final AuthRepo _authRepo;

  ChangePasswordUseCase(this._authRepo);

  Future<ApiResult<ChangePasswordResponseEntity>> call(
      ChangePasswordRequestEntity changePasswordEntity,
      ) async {
    return await _authRepo.changePassword(changePasswordEntity);
  }
}
