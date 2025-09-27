import 'package:elevate_tracking_app/domain/entites/requests/login_request_entity.dart';

abstract interface class AuthLocalDataSource {
  Future<void> saveUserToken({required String token});

  Future<void> saveUserRememberMe({
    required LoginRequestEntity loginRequestEntity,
  });
}
