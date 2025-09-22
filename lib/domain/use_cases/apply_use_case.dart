import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/domain/entites/apply_response_entity.dart';
import 'package:elevate_tracking_app/domain/entites/request/apply_request_entity.dart';
import 'package:elevate_tracking_app/domain/repo/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class ApplyUseCase {
  final AuthRepo _authRepo;

  ApplyUseCase(this._authRepo);
  Future<ApiResult<ApplyResponseEntity>> call(
    ApplyRequestEntity request,
  ) async {
    return await _authRepo.apply(request: request);
  }
}
