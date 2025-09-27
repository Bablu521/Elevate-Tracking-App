import 'package:injectable/injectable.dart';

import '../../core/api_result/api_result.dart';

import '../entities/email_verification_entity.dart';
import '../entities/requests/email_verification_request_entity.dart';
import '../repo/auth_repo.dart';

@injectable
class EmailVerificationUseCase {
  final AuthRepo _authRepo;

  EmailVerificationUseCase(this._authRepo);

  Future<ApiResult<EmailVerificationEntity>> call(
    EmailVerificationRequestEntity request,
  ) async {
    return await _authRepo.emailVerification(request);
  }
}
