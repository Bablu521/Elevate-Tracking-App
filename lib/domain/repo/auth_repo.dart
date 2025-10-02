import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/domain/entites/login_entity.dart';
import 'package:elevate_tracking_app/domain/entites/requests/login_request_entity.dart';

import '../entites/requests/change_password_request_entity.dart';
import '../entites/response/change_password_response_entity.dart';

abstract interface class AuthRepo {
  Future<ApiResult<LoginEntity>> login(LoginRequestEntity loginRequestEntity);

  Future<ApiResult<ChangePasswordResponseEntity>> changePassword(
      ChangePasswordRequestEntity request,
      );
}
