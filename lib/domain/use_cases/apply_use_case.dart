import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/domain/repo/auth_repo.dart';
import 'package:injectable/injectable.dart';

import '../entities/apply_response_entity.dart';
import '../entities/request/apply_request_entity.dart';

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
