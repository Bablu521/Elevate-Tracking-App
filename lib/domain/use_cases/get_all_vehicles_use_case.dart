import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/domain/entites/vehicle_entity.dart';
import 'package:elevate_tracking_app/domain/repo/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllVehiclesUseCase {
  final AuthRepo _authRepo;

  GetAllVehiclesUseCase(this._authRepo);
  Future<ApiResult<List<VehicleEntity>>> call() async {
    return await _authRepo.getAllVehicles();
  }
}