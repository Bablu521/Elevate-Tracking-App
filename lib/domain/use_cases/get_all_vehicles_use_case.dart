import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/domain/repo/auth_repo.dart';
import 'package:injectable/injectable.dart';
import '../entities/vehicles_entity.dart';



@injectable
class GetAllVehiclesUseCase {
  final AuthRepo _authRepo;

  GetAllVehiclesUseCase(this._authRepo);


  Future<ApiResult<List<VehiclesEntity>>> call() async {
    return await _authRepo.getAllVehicles();
  }
}


