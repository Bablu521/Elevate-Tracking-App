
import 'package:injectable/injectable.dart';

import '../../core/api_result/api_result.dart';
import '../entites/email_verification_entity.dart';
import '../entites/email_verification_request_entity.dart';
import '../repo/auth_repo.dart';

@injectable
class EmailVerificationUseCase {
  final AuthRepo _authRepo;

  EmailVerificationUseCase(this._authRepo);

  Future<ApiResult<EmailVerificationEntity>> call(EmailVerificationRequestEntity request) async {
    return await _authRepo.verifyResetCode(request);
  }
}