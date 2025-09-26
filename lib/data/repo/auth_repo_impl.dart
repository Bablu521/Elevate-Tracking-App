import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/data/data_source/auth_local_data_source.dart';
import 'package:elevate_tracking_app/data/data_source/auth_remote_data_source.dart';
import 'package:elevate_tracking_app/domain/entites/apply_response_entity.dart';
import 'package:elevate_tracking_app/domain/entites/country_entity.dart';
import 'package:elevate_tracking_app/domain/entites/request/apply_request_entity.dart';
import 'package:elevate_tracking_app/domain/entites/vehicles_entity.dart';
import 'package:elevate_tracking_app/domain/entites/login_entity.dart';
import 'package:elevate_tracking_app/domain/entites/requests/login_request_entity.dart';
import 'package:elevate_tracking_app/domain/repo/auth_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource _authRemoteDataSource;
  final AuthLocalDataSource _authLocalDataSource;

  AuthRepoImpl(this._authRemoteDataSource, this._authLocalDataSource);
  
  @override
  Future<ApiResult<ApplyResponseEntity>> apply({
    required ApplyRequestEntity request,
  }) async {
    return await _authRemoteDataSource.apply(request: request);
  }

  @override
  Future<ApiResult<List<VehicleEntity>>> getAllVehicles() async {
    return await _authRemoteDataSource.getAllVehicles();
  }

  @override
  Future<ApiResult<List<CountryEntity>>> getAllCountries() async {
    return await _authLocalDataSource.getAllCountry();


  }

  @override
  Future<ApiResult<LoginEntity>> login(
    LoginRequestEntity loginRequestEntity,
  ) async {
    final result = await _authRemoteDataSource.login(loginRequestEntity);
    switch (result) {
      case ApiSuccessResult<LoginEntity>():
        _authLocalDataSource.saveUserToken(token: result.data.token);
        _authLocalDataSource.saveUserRememberMe(
          loginRequestEntity: loginRequestEntity,
        );
        break;
      case ApiErrorResult<LoginEntity>():
        _authLocalDataSource.saveUserRememberMe(
          loginRequestEntity: loginRequestEntity,
        );
        break;
    }
    return result;
  }
}
