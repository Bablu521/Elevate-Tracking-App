import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/domain/entites/country_entity.dart';

abstract interface class AuthLocalDataSource {
  Future<ApiResult<List<CountryEntity>>> getAllCountry();
}
