import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/domain/entites/country_entity.dart';

import 'package:elevate_tracking_app/domain/entites/requests/login_request_entity.dart';

abstract interface class AuthLocalDataSource {
  Future<void> saveUserToken({required String token});
Future<ApiResult<List<CountryEntity>>> getAllCountry();
  Future<void> saveUserRememberMe({
    required LoginRequestEntity loginRequestEntity,
  });
}
