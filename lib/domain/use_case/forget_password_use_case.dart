import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/domain/entites/forget_password_request_entity.dart';
import 'package:elevate_tracking_app/domain/entites/forget_password_response_entity.dart';
import 'package:elevate_tracking_app/domain/repo/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class ForgetPasswordUseCase{
  AuthRepo authRepo;
  ForgetPasswordUseCase(this.authRepo);

  Future<ApiResult<ForgetPasswordResponseEntity>>
  call(ForgetPasswordRequestEntity request){
    return authRepo.forgetPassword(request);
  }
}