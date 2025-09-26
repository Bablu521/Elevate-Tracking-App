import 'dart:convert';
import 'package:elevate_tracking_app/api/mapper/apply_mapper.dart';
import 'package:elevate_tracking_app/api/models/responses/country_dto.dart';
import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/core/constants/end_points.dart';
import 'package:elevate_tracking_app/data/data_source/auth_local_data_source.dart';
import 'package:elevate_tracking_app/domain/entites/country_entity.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final AssetBundle bundle;
  AuthLocalDataSourceImpl({AssetBundle? testBundle})
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
}
