import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/domain/entites/driver_entity.dart';
import 'package:elevate_tracking_app/domain/entites/requests/update_vehicle_request_entity.dart';
import 'package:elevate_tracking_app/domain/repo/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateVehicleUseCase {
  final AuthRepo _authRepo;

  UpdateVehicleUseCase(this._authRepo);
  Future<ApiResult<DriverEntity>> call(
    UpdateVehicleRequestEntity request,
  ) async {
    return await _authRepo.updateVehicleInfo(request: request);
  }
}
