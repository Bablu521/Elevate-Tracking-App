import 'dart:convert';

import 'package:elevate_tracking_app/api/mapper/apply_mapper.dart';
import 'package:elevate_tracking_app/api/models/responses/country_dto.dart';
import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/core/constants/const_keys.dart';
import 'package:elevate_tracking_app/core/constants/end_points.dart';
import 'package:elevate_tracking_app/data/data_source/auth_local_data_source.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/country_entity.dart';
import '../../domain/entities/requests/login_request_entity.dart';

@Injectable(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final AssetBundle bundle;
  final FlutterSecureStorage _secureStorage;

  AuthLocalDataSourceImpl(this._secureStorage, {AssetBundle? testBundle})
    : bundle = testBundle ?? rootBundle;

  @override
  Future<ApiResult<List<CountryEntity>>> getAllCountry() async {
    try {
      final jsonString = await bundle.loadString(Endpoints.countryLocalData);
      final List<dynamic> decoded = jsonDecode(jsonString);
      final dtoList = decoded
          .map((e) => CountryDto.fromJson(e as Map<String, dynamic>))
          .toList();
      final entities = dtoList.map((c) => c.toEntity()).toList();
      return ApiSuccessResult<List<CountryEntity>>(entities);
    } catch (e) {
      return ApiErrorResult(e.toString());
    }
  }

  @override
  Future<void> saveUserRememberMe({
    required LoginRequestEntity loginRequestEntity,
  }) async {
    final isRememberMe = await _secureStorage.read(
      key: ConstKeys.keyRememberMe,
    );
    if (isRememberMe == ConstKeys.trueKey) {
      await _secureStorage.write(
        key: ConstKeys.kUserLogin,
        value: loginRequestEntity.email,
      );
      await _secureStorage.write(
        key: ConstKeys.kUserPassword,
        value: loginRequestEntity.password,
      );
    } else {
      await _secureStorage.delete(key: ConstKeys.kUserLogin);
      await _secureStorage.delete(key: ConstKeys.kUserPassword);
    }
  }

  @override
  Future<void> saveUserToken({required String token}) async {
    await _secureStorage.write(key: ConstKeys.keyUserToken, value: token);
  }

  @override
  Future<void> userLogout() async {
    await _secureStorage.delete(key: ConstKeys.keyUserToken);
  }
}
