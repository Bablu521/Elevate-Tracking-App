import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/data/repo/auth_repo_impl.dart';
import 'package:elevate_tracking_app/domain/entities/country_entity.dart';
import 'package:elevate_tracking_app/domain/use_cases/get_all_country_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../fixture/apply_fixture.dart';
import 'get_all_country_use_case_test.mocks.dart';

@GenerateMocks([AuthRepoImpl])
void main() {
  group("Test get all country use case", () {
    final List<CountryEntity> fakeListCountry =
        ApplyFixture.fakeCountryEntityList();
    late MockAuthRepoImpl mockAuthRepoImpl;
    late GetAllCountryUseCase useCase;
    final Exception fakeException = Exception();
    setUp(() {
      mockAuthRepoImpl = MockAuthRepoImpl();
      useCase = GetAllCountryUseCase(mockAuthRepoImpl);
      provideDummy<ApiResult<List<CountryEntity>>>(
        ApiSuccessResult<List<CountryEntity>>(fakeListCountry),
      );
      provideDummy<ApiResult<List<CountryEntity>>>(
        ApiErrorResult<List<CountryEntity>>(fakeException),
      );
    });
    test("get all country use case success", () async {
      final expectResult = ApiSuccessResult<List<CountryEntity>>(
        fakeListCountry,
      );
      when(
        mockAuthRepoImpl.getAllCountries(),
      ).thenAnswer((_) async => expectResult);

      final result = await useCase.call();
      expect(result, isA<ApiSuccessResult<List<CountryEntity>>>());
      expect(
        (result as ApiSuccessResult<List<CountryEntity>>).data.length,
        equals(fakeListCountry.length),
      );

      verify(mockAuthRepoImpl.getAllCountries()).called(1);
    });
    test("get all country use case failure ApiResult Exception", () async {
      final expectResult = ApiErrorResult<List<CountryEntity>>(fakeException);
      when(
        mockAuthRepoImpl.getAllCountries(),
      ).thenAnswer((_) async => expectResult);

      final result = await useCase.call();
      expect(result, isA<ApiErrorResult<List<CountryEntity>>>());
      expect(
        (result as ApiErrorResult<List<CountryEntity>>).error,
        equals(fakeException),
      );

      verify(mockAuthRepoImpl.getAllCountries()).called(1);
    });
  });
}
