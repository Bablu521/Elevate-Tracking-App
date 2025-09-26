import 'package:dio/dio.dart';
import 'package:elevate_tracking_app/api/data_source/auth_local_data_source_impl.dart';
import 'package:elevate_tracking_app/api/data_source/auth_remote_data_source_impl.dart';
import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/data/repo/auth_repo_impl.dart';
import 'package:elevate_tracking_app/domain/entites/apply_response_entity.dart';
import 'package:elevate_tracking_app/domain/entites/country_entity.dart';
import 'package:elevate_tracking_app/domain/entites/vehicles_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../fixture/apply_fixture.dart';
import 'auth_repo_impl_test.mocks.dart';

@GenerateMocks([AuthRemoteDataSourceImpl, AuthLocalDataSourceImpl])
void main() {
  group("Test Apply", () {
    final fakeApplyRequestEntity = ApplyFixture.fakeRequestEntity();
    final fakeApplyResponseEntity = ApplyFixture.fakeResponseEntity();
    final fakeAllCountry = ApplyFixture.fakeCountryEntityList();
    final List<VehicleEntity> fakeListVehicles =
        ApplyFixture.fakeVehicleEntity();
    late MockAuthRemoteDataSourceImpl mockAuthRemoteDataSourceImpl;
    late MockAuthLocalDataSourceImpl mockAuthLocalDataSourceImpl;
    late AuthRepoImpl authRepoImpl;
    final DioException dioException = DioException(
      requestOptions: RequestOptions(),
      message: "fake_dio_message",
    );
    final Exception fakeException = Exception();
    setUp(() {
      mockAuthRemoteDataSourceImpl = MockAuthRemoteDataSourceImpl();
      mockAuthLocalDataSourceImpl = MockAuthLocalDataSourceImpl();
      authRepoImpl = AuthRepoImpl(
        mockAuthRemoteDataSourceImpl,
        mockAuthLocalDataSourceImpl,
      );
      provideDummy<ApiResult<ApplyResponseEntity>>(
        ApiSuccessResult<ApplyResponseEntity>(fakeApplyResponseEntity),
      );
      provideDummy<ApiResult<ApplyResponseEntity>>(
        ApiErrorResult<ApplyResponseEntity>(fakeException),
      );
      provideDummy<ApiResult<List<VehicleEntity>>>(
        ApiSuccessResult<List<VehicleEntity>>(fakeListVehicles),
      );
      provideDummy<ApiResult<List<VehicleEntity>>>(
        ApiErrorResult<List<VehicleEntity>>(fakeException),
      );
      provideDummy<ApiResult<List<CountryEntity>>>(
        ApiSuccessResult<List<CountryEntity>>(fakeAllCountry),
      );
      provideDummy<ApiResult<List<CountryEntity>>>(
        ApiErrorResult<List<CountryEntity>>(fakeException),
      );
    });
    test("apply success ApiResult ApplyResponseEntity", () async {
      final fakeRequestEn = await fakeApplyRequestEntity;
      final expectResult = ApiSuccessResult<ApplyResponseEntity>(
        fakeApplyResponseEntity,
      );
      when(
        mockAuthRemoteDataSourceImpl.apply(request: fakeRequestEn),
      ).thenAnswer((_) async => expectResult);

      final result = await authRepoImpl.apply(request: fakeRequestEn);
      expect(result, isA<ApiSuccessResult<ApplyResponseEntity>>());
      expect(
        (result as ApiSuccessResult<ApplyResponseEntity>).data.id,
        equals(fakeApplyResponseEntity.id),
      );

      verify(
        mockAuthRemoteDataSourceImpl.apply(request: fakeRequestEn),
      ).called(1);
    });
    test("apply failure ApiResult DioError", () async {
      final fakeRequestEn = await fakeApplyRequestEntity;
      final expectResult = ApiErrorResult<ApplyResponseEntity>(dioException);
      when(
        mockAuthRemoteDataSourceImpl.apply(request: fakeRequestEn),
      ).thenAnswer((_) async => expectResult);

      final result = await authRepoImpl.apply(request: fakeRequestEn);
      expect(result, isA<ApiErrorResult<ApplyResponseEntity>>());
      expect(
        (result as ApiErrorResult<ApplyResponseEntity>).errorMessage,
        contains(dioException.message),
      );

      verify(
        mockAuthRemoteDataSourceImpl.apply(request: fakeRequestEn),
      ).called(1);
    });
    test("apply failure ApiResult Exception", () async {
      final fakeRequestEn = await fakeApplyRequestEntity;
      final expectResult = ApiErrorResult<ApplyResponseEntity>(fakeException);
      when(
        mockAuthRemoteDataSourceImpl.apply(request: fakeRequestEn),
      ).thenAnswer((_) async => expectResult);

      final result = await authRepoImpl.apply(request: fakeRequestEn);
      expect(result, isA<ApiErrorResult<ApplyResponseEntity>>());
      expect(
        (result as ApiErrorResult<ApplyResponseEntity>).error,
        equals(fakeException),
      );

      verify(
        mockAuthRemoteDataSourceImpl.apply(request: fakeRequestEn),
      ).called(1);
    });
    test("get all vehicles success ApiResult List<VehicleEntity>", () async {
      final expectResult = ApiSuccessResult<List<VehicleEntity>>(
        fakeListVehicles,
      );
      when(
        mockAuthRemoteDataSourceImpl.getAllVehicles(),
      ).thenAnswer((_) async => expectResult);

      final result = await authRepoImpl.getAllVehicles();
      expect(result, isA<ApiSuccessResult<List<VehicleEntity>>>());
      expect(
        (result as ApiSuccessResult<List<VehicleEntity>>).data.last.type,
        equals(fakeListVehicles.last.type),
      );

      verify(mockAuthRemoteDataSourceImpl.getAllVehicles()).called(1);
    });
    test("get all vehicles failure ApiResult DioError", () async {
      final expectResult = ApiErrorResult<List<VehicleEntity>>(dioException);
      when(
        mockAuthRemoteDataSourceImpl.getAllVehicles(),
      ).thenAnswer((_) async => expectResult);

      final result = await authRepoImpl.getAllVehicles();
      expect(result, isA<ApiErrorResult<List<VehicleEntity>>>());
      expect(
        (result as ApiErrorResult<List<VehicleEntity>>).errorMessage,
        contains(dioException.message),
      );

      verify(mockAuthRemoteDataSourceImpl.getAllVehicles()).called(1);
    });
    test("get all vehicles failure ApiResult Exception", () async {
      final expectResult = ApiErrorResult<List<VehicleEntity>>(fakeException);
      when(
        mockAuthRemoteDataSourceImpl.getAllVehicles(),
      ).thenAnswer((_) async => expectResult);

      final result = await authRepoImpl.getAllVehicles();
      expect(result, isA<ApiErrorResult<List<VehicleEntity>>>());
      expect(
        (result as ApiErrorResult<List<VehicleEntity>>).error,
        equals(fakeException),
      );

      verify(mockAuthRemoteDataSourceImpl.getAllVehicles()).called(1);
    });
    test("get all country success ApiResult List<CountyEntity>", () async {
      final expectResult = ApiSuccessResult<List<CountryEntity>>(
        fakeAllCountry,
      );
      when(
        mockAuthLocalDataSourceImpl.getAllCountry(),
      ).thenAnswer((_) async => expectResult);

      final result = await authRepoImpl.getAllCountries();
      expect(result, isA<ApiSuccessResult<List<CountryEntity>>>());
      expect(
        (result as ApiSuccessResult<List<CountryEntity>>).data.last.currency,
        equals(fakeAllCountry.last.currency),
      );

      verify(mockAuthLocalDataSourceImpl.getAllCountry()).called(1);
    });
    test("get all country failure ApiResult Exception", () async {
      final expectResult = ApiErrorResult<List<CountryEntity>>(fakeException);
      when(
        mockAuthLocalDataSourceImpl.getAllCountry(),
      ).thenAnswer((_) async => expectResult);

      final result = await authRepoImpl.getAllCountries();
      expect(result, isA<ApiErrorResult<List<CountryEntity>>>());
      expect(
        (result as ApiErrorResult<List<CountryEntity>>).error,
        equals(fakeException),
      );

      verify(mockAuthLocalDataSourceImpl.getAllCountry()).called(1);
    });
  });
}
