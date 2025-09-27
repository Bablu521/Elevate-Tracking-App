import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/domain/repo/auth_repo.dart';
import 'package:injectable/injectable.dart';

import '../entities/country_entity.dart';

@injectable
class GetAllCountryUseCase {
  final AuthRepo _authRepo;

  GetAllCountryUseCase(this._authRepo);

  Future<ApiResult<List<CountryEntity>>> call() async {
    return await _authRepo.getAllCountries();
  }
}
