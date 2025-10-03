import 'package:elevate_tracking_app/core/api_result/api_result.dart';

import '../../domain/entities/country_entity.dart';
import '../../domain/entities/requests/login_request_entity.dart';

abstract interface class AuthLocalDataSource {
  Future<ApiResult<List<CountryEntity>>> getAllCountry();

  Future<void> saveUserToken({required String token});

  Future<void> saveUserRememberMe({
    required LoginRequestEntity loginRequestEntity,
  });
  Future<void> userLogout();
}
