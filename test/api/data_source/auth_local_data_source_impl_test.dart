import 'package:elevate_tracking_app/api/data_source/auth_local_data_source_impl.dart';
import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/domain/entites/country_entity.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:elevate_tracking_app/core/constants/const_keys.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mockito/mockito.dart';

import '../../dummy/login_dummy_data.dart';
import 'auth_local_data_source_impl_test.mocks.dart';
import '../../fixture/apply_fixture.dart';
import '../../fixture/fake_file_json.dart';

@GenerateMocks([AssetBundle,FlutterSecureStorage])
void main() {
  group("test get all country", () {
    late MockFlutterSecureStorage mockStorage;
    late AuthLocalDataSourceImpl dataSource;
    late FakeAssetBundle fakeBundle;
    setUp(() {
      mockStorage = MockFlutterSecureStorage();
      fakeBundle = ApplyFixture.fakeBundle;
      dataSource = AuthLocalDataSourceImpl(mockStorage,testBundle: fakeBundle);
    });

    test('returns List<CountryEntity> when fixture is valid', () async {
      final result = await dataSource.getAllCountry();
      expect(result, isA<ApiSuccessResult<List<CountryEntity>>>());
      if (result is ApiSuccessResult<List<CountryEntity>>) {
        final countries = result.data;
        expect(countries, isNotEmpty);
        expect(countries.first.name, equals('Turkey'));
        expect(countries.first.flag, equals('🇹🇷'));
      } else {
        fail('Expected success result');
      }
    });

    test('returns error when asset is missing', () async {
      final emptyBundle = FakeAssetBundle({});
      final ds = AuthLocalDataSourceImpl(mockStorage, testBundle: emptyBundle);

      final result = await ds.getAllCountry();

      expect(result, isA<ApiErrorResult>());
    });

    group("test AuthLocalDataSourceImpl", () {
    late MockFlutterSecureStorage mockStorage;
    late AuthLocalDataSourceImpl dataSource;

    setUp(() {
      mockStorage = MockFlutterSecureStorage();
      dataSource = AuthLocalDataSourceImpl(mockStorage);
    });

    group("saveUserRememberMe", () {
      final loginRequestEntity = LoginDummyData().fakeLoginRequestEntity;

      test("should save email & password when remember me is true", () async {
        when(
          mockStorage.read(key: ConstKeys.keyRememberMe),
        ).thenAnswer((_) async => ConstKeys.trueKey);

        await dataSource.saveUserRememberMe(
          loginRequestEntity: loginRequestEntity,
        );

        verify(mockStorage.read(key: ConstKeys.keyRememberMe)).called(1);
        verify(
          mockStorage.write(
            key: ConstKeys.kUserLogin,
            value: loginRequestEntity.email,
          ),
        ).called(1);
        verify(
          mockStorage.write(
            key: ConstKeys.kUserPassword,
            value: loginRequestEntity.password,
          ),
        ).called(1);
      });

      test(
        "should delete email & password when remember me is not true",
        () async {
          when(
            mockStorage.read(key: ConstKeys.keyRememberMe),
          ).thenAnswer((_) async => "false");

          await dataSource.saveUserRememberMe(
            loginRequestEntity: loginRequestEntity,
          );

          verify(mockStorage.read(key: ConstKeys.keyRememberMe)).called(1);
          verify(mockStorage.delete(key: ConstKeys.kUserLogin)).called(1);
          verify(mockStorage.delete(key: ConstKeys.kUserPassword)).called(1);
        },
      );
    });

    group("saveUserToken", () {
      test("should write token to storage", () async {
        const token = "fake-token";

        await dataSource.saveUserToken(token: token);

        verify(
          mockStorage.write(key: ConstKeys.keyUserToken, value: token),
        ).called(1);
      });
    });
  });
  });
}
