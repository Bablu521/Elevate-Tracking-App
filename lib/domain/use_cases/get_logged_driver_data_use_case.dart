import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/domain/repo/auth_repo.dart';
import 'package:injectable/injectable.dart';

import '../entites/driver_entity.dart';

@injectable
class GetLoggedDriverDataUseCase {
  final AuthRepo _authRepo;
  
  GetLoggedDriverDataUseCase(this._authRepo);

  Future<ApiResult<DriverEntity>> call() {
    return _authRepo.getLoggedDriverData();
  }
}
