import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/domain/entites/vehicle_entity.dart';
import 'package:elevate_tracking_app/domain/repo/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetVehicleUseCase {
  final AuthRepo _authRepo;

  GetVehicleUseCase(this._authRepo);

  Future<ApiResult<VehicleEntity>> call(String id) {
    return _authRepo.getVehicle(id);
  }
}
