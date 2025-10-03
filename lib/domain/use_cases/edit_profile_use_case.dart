import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/domain/entities/driver_entity.dart';
import 'package:elevate_tracking_app/domain/entities/requests/update_profile_info_request_entity.dart';
import 'package:elevate_tracking_app/domain/repo/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class EditProfileUseCase {
  final AuthRepo _authRepo;

  EditProfileUseCase(this._authRepo);

  Future<ApiResult<DriverEntity>> call(
      UpdateProfileInfoRequestEntity updateProfileInfoRequestEntity) {
    return _authRepo.editProfile(updateProfileInfoRequestEntity);
  }
}