import 'dart:io';

import 'package:dio/dio.dart';
import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/data/repo/auth_repo_impl.dart';
import 'package:elevate_tracking_app/data/data_source/auth_local_data_source.dart';
import 'package:elevate_tracking_app/data/data_source/auth_remote_data_source.dart';
import 'package:elevate_tracking_app/domain/entities/apply_response_entity.dart';
import 'package:elevate_tracking_app/domain/entities/country_entity.dart';
import 'package:elevate_tracking_app/domain/entities/driver_entity.dart';
import 'package:elevate_tracking_app/domain/entities/login_entity.dart';
import 'package:elevate_tracking_app/domain/entities/logout_response_entity.dart';
import 'package:elevate_tracking_app/domain/entities/requests/update_profile_info_request_entity.dart';
import 'package:elevate_tracking_app/domain/entities/upload_profile_image_response_entity.dart';
import 'package:elevate_tracking_app/domain/entities/vehicle_entity.dart';
import 'package:elevate_tracking_app/domain/entities/vehicles_entity.dart';
import '../../dummy/login_dummy_data.dart';
import '../../dummy/profile_info_dummy.dart';
import 'auth_repo_impl_test.mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../fixture/apply_fixture.dart';

@GenerateMocks([AuthRemoteDataSource, AuthLocalDataSource])
void main() {
  group("Test Apply", () {
    final fakeApplyRequestEntity = ApplyFixture.fakeRequestEntity();
    final fakeApplyResponseEntity = ApplyFixture.fakeResponseEntity();
    final fakeAllCountry = ApplyFixture.fakeCountryEntityList();
    final List<VehiclesEntity> fakeListVehicles =
        ApplyFixture.fakeVehicleEntity();
    late MockAuthRemoteDataSource mockAuthRemoteDataSource;
    late MockAuthLocalDataSource mockAuthLocalDataSource;
    late AuthRepoImpl authRepoImpl;
    final DioException dioException = DioException(
      requestOptions: RequestOptions(),
      message: "fake_dio_message",
    );
    final Exception fakeException = Exception();
    setUp(() {
      mockAuthRemoteDataSource = MockAuthRemoteDataSource();
      mockAuthLocalDataSource = MockAuthLocalDataSource();
      authRepoImpl = AuthRepoImpl(
        mockAuthRemoteDataSource,
        mockAuthLocalDataSource,
      );
      provideDummy<ApiResult<ApplyResponseEntity>>(
        ApiSuccessResult<ApplyResponseEntity>(fakeApplyResponseEntity),
      );
      provideDummy<ApiResult<ApplyResponseEntity>>(
        ApiErrorResult<ApplyResponseEntity>(fakeException),
      );
      provideDummy<ApiResult<List<VehiclesEntity>>>(
        ApiSuccessResult<List<VehiclesEntity>>(fakeListVehicles),
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
        mockAuthRemoteDataSource.apply(request: fakeRequestEn),
      ).thenAnswer((_) async => expectResult);

      final result = await authRepoImpl.apply(request: fakeRequestEn);
      expect(result, isA<ApiSuccessResult<ApplyResponseEntity>>());
      expect(
        (result as ApiSuccessResult<ApplyResponseEntity>).data.id,
        equals(fakeApplyResponseEntity.id),
      );

      verify(mockAuthRemoteDataSource.apply(request: fakeRequestEn)).called(1);
    });
    test("apply failure ApiResult DioError", () async {
      final fakeRequestEn = await fakeApplyRequestEntity;
      final expectResult = ApiErrorResult<ApplyResponseEntity>(dioException);
      when(
        mockAuthRemoteDataSource.apply(request: fakeRequestEn),
      ).thenAnswer((_) async => expectResult);

      final result = await authRepoImpl.apply(request: fakeRequestEn);
      expect(result, isA<ApiErrorResult<ApplyResponseEntity>>());
      expect(
        (result as ApiErrorResult<ApplyResponseEntity>).errorMessage,
        contains(dioException.message),
      );

      verify(mockAuthRemoteDataSource.apply(request: fakeRequestEn)).called(1);
    });
    test("apply failure ApiResult Exception", () async {
      final fakeRequestEn = await fakeApplyRequestEntity;
      final expectResult = ApiErrorResult<ApplyResponseEntity>(fakeException);
      when(
        mockAuthRemoteDataSource.apply(request: fakeRequestEn),
      ).thenAnswer((_) async => expectResult);

      final result = await authRepoImpl.apply(request: fakeRequestEn);
      expect(result, isA<ApiErrorResult<ApplyResponseEntity>>());
      expect(
        (result as ApiErrorResult<ApplyResponseEntity>).error,
        equals(fakeException),
      );

      verify(mockAuthRemoteDataSource.apply(request: fakeRequestEn)).called(1);
    });
    test("get all vehicles success ApiResult List<VehicleEntity>", () async {
      final expectResult = ApiSuccessResult<List<VehiclesEntity>>(
        fakeListVehicles,
      );
      when(
        mockAuthRemoteDataSource.getAllVehicles(),
      ).thenAnswer((_) async => expectResult);

      final result = await authRepoImpl.getAllVehicles();
      expect(result, isA<ApiSuccessResult<List<VehiclesEntity>>>());
      expect(
        (result as ApiSuccessResult<List<VehiclesEntity>>).data.last.type,
        equals(fakeListVehicles.last.type),
      );

      verify(mockAuthRemoteDataSource.getAllVehicles()).called(1);
    });
    test("get all vehicles failure ApiResult DioError", () async {
      final expectResult = ApiErrorResult<List<VehiclesEntity>>(dioException);
      when(
        mockAuthRemoteDataSource.getAllVehicles(),
      ).thenAnswer((_) async => expectResult);

      final result = await authRepoImpl.getAllVehicles();
      expect(result, isA<ApiErrorResult<List<VehiclesEntity>>>());
      expect(
        (result as ApiErrorResult<List<VehiclesEntity>>).errorMessage,
        contains(dioException.message),
      );

      verify(mockAuthRemoteDataSource.getAllVehicles()).called(1);
    });
    test("get all vehicles failure ApiResult Exception", () async {
      final expectResult = ApiErrorResult<List<VehiclesEntity>>(fakeException);
      when(
        mockAuthRemoteDataSource.getAllVehicles(),
      ).thenAnswer((_) async => expectResult);

      final result = await authRepoImpl.getAllVehicles();
      expect(result, isA<ApiErrorResult<List<VehiclesEntity>>>());
      expect(
        (result as ApiErrorResult<List<VehiclesEntity>>).error,
        equals(fakeException),
      );

      verify(mockAuthRemoteDataSource.getAllVehicles()).called(1);
    });
    test("get all country success ApiResult List<CountyEntity>", () async {
      final expectResult = ApiSuccessResult<List<CountryEntity>>(
        fakeAllCountry,
      );
      when(
        mockAuthLocalDataSource.getAllCountry(),
      ).thenAnswer((_) async => expectResult);

      final result = await authRepoImpl.getAllCountries();
      expect(result, isA<ApiSuccessResult<List<CountryEntity>>>());
      expect(
        (result as ApiSuccessResult<List<CountryEntity>>).data.last.currency,
        equals(fakeAllCountry.last.currency),
      );

      verify(mockAuthLocalDataSource.getAllCountry()).called(1);
    });
    test("get all country failure ApiResult Exception", () async {
      final expectResult = ApiErrorResult<List<CountryEntity>>(fakeException);
      when(
        mockAuthLocalDataSource.getAllCountry(),
      ).thenAnswer((_) async => expectResult);

      final result = await authRepoImpl.getAllCountries();
      expect(result, isA<ApiErrorResult<List<CountryEntity>>>());
      expect(
        (result as ApiErrorResult<List<CountryEntity>>).error,
        equals(fakeException),
      );

      verify(mockAuthLocalDataSource.getAllCountry()).called(1);
    });

    group("test AuthRepoImpl", () {
      late MockAuthRemoteDataSource mockAuthRemoteDataSource;
      late MockAuthLocalDataSource mockAuthLocalDataSource;
      late AuthRepoImpl authRepoImpl;
      setUp(() {
        mockAuthRemoteDataSource = MockAuthRemoteDataSource();
        mockAuthLocalDataSource = MockAuthLocalDataSource();
        authRepoImpl = AuthRepoImpl(
          mockAuthRemoteDataSource,
          mockAuthLocalDataSource,
        );
      });

      group("test login", () {
        final loginRequestEntity = LoginDummyData().fakeLoginRequestEntity;

        test(
          "when call login should return LoginEntity with right data",
          () async {
            final expectedEntity = LoginDummyData().fakeLoginEntity;
            final expectedResult = ApiSuccessResult<LoginEntity>(
              expectedEntity,
            );

            provideDummy<ApiResult<LoginEntity>>(expectedResult);
            when(
              mockAuthRemoteDataSource.login(loginRequestEntity),
            ).thenAnswer((_) async => expectedResult);

            final result = await authRepoImpl.login(loginRequestEntity);

            verify(
              mockAuthRemoteDataSource.login(loginRequestEntity),
            ).called(1);
            verify(
              mockAuthLocalDataSource.saveUserToken(
                token: expectedEntity.token,
              ),
            ).called(1);
            verify(
              mockAuthLocalDataSource.saveUserRememberMe(
                loginRequestEntity: loginRequestEntity,
              ),
            ).called(1);

            expect(result, isA<ApiSuccessResult<LoginEntity>>());
            result as ApiSuccessResult<LoginEntity>;
            expect(result.data, expectedEntity);
          },
        );

        test("when login failed should return error result", () async {
          final expectedError = "fake-error";
          final expectedResult = ApiErrorResult<LoginEntity>(expectedError);

          provideDummy<ApiResult<LoginEntity>>(expectedResult);
          when(
            mockAuthRemoteDataSource.login(loginRequestEntity),
          ).thenAnswer((_) async => expectedResult);

          final result = await authRepoImpl.login(loginRequestEntity);

          verify(mockAuthRemoteDataSource.login(loginRequestEntity)).called(1);
          verify(
            mockAuthLocalDataSource.saveUserRememberMe(
              loginRequestEntity: loginRequestEntity,
            ),
          ).called(1);

          expect(result, isA<ApiErrorResult<LoginEntity>>());
          result as ApiErrorResult<LoginEntity>;
          expect(result.errorMessage, expectedError);
        });
      });

      group("test getLoggedDriverData", () {
        test(
          "when call it should return DriverEntity from data source with correct parameters",
          () async {
            //Arrange
            final expectedEntity = ProfileInfoDummy.dummyDriverEntityFake;
            final expectedResult = ApiSuccessResult<DriverEntity>(
              expectedEntity,
            );

            provideDummy<ApiResult<DriverEntity>>(expectedResult);
            when(
              mockAuthRemoteDataSource.getLoggedDriverData(),
            ).thenAnswer((_) async => expectedResult);

            //Act
            final result = await mockAuthRemoteDataSource.getLoggedDriverData();

            //Assert
            verify(mockAuthRemoteDataSource.getLoggedDriverData()).called(1);
            expect(result, isA<ApiSuccessResult<DriverEntity>>());
            result as ApiSuccessResult<DriverEntity>;
            expect(result.data, expectedEntity);
          },
        );

        test("when call failed it should return an error result", () async {
          //Arrange
          final expectedError = "Server-Error";
          final expectedResult = ApiErrorResult<DriverEntity>(expectedError);

          provideDummy<ApiResult<DriverEntity>>(expectedResult);
          when(
            mockAuthRemoteDataSource.getLoggedDriverData(),
          ).thenAnswer((_) async => expectedResult);

          //Act
          final result = await mockAuthRemoteDataSource.getLoggedDriverData();

          //Assert
          verify(mockAuthRemoteDataSource.getLoggedDriverData()).called(1);
          expect(result, isA<ApiErrorResult<DriverEntity>>());
          result as ApiErrorResult<DriverEntity>;
          expect(result.errorMessage, expectedError);
        });
      });

      group("test editProfile", () {
        late UpdateProfileInfoRequestEntity updateProfileInfoRequestEntity;
        setUp(() {
          updateProfileInfoRequestEntity =
              ProfileInfoDummy.dummyUpdateProfileInfoRequestEntityFake;
        });
        test(
          "when call it should return DriverEntity from data source with correct parameters",
          () async {
            //Arrange
            final expectedEntity = ProfileInfoDummy.dummyDriverEntityFake;
            final expectedResult = ApiSuccessResult<DriverEntity>(
              expectedEntity,
            );

            provideDummy<ApiResult<DriverEntity>>(expectedResult);
            when(
              mockAuthRemoteDataSource.editProfile(
                updateProfileInfoRequestEntity,
              ),
            ).thenAnswer((_) async => expectedResult);

            //Act
            final result = await mockAuthRemoteDataSource.editProfile(
              updateProfileInfoRequestEntity,
            );

            //Assert
            verify(
              mockAuthRemoteDataSource.editProfile(
                updateProfileInfoRequestEntity,
              ),
            ).called(1);
            expect(result, isA<ApiSuccessResult<DriverEntity>>());
            result as ApiSuccessResult<DriverEntity>;
            expect(result.data, expectedEntity);
          },
        );

        test("when call failed it should return an error result", () async {
          //Arrange
          final expectedError = "Server-Error";
          final expectedResult = ApiErrorResult<DriverEntity>(expectedError);

          provideDummy<ApiResult<DriverEntity>>(expectedResult);
          when(
            mockAuthRemoteDataSource.editProfile(
              updateProfileInfoRequestEntity,
            ),
          ).thenAnswer((_) async => expectedResult);

          //Act
          final result = await mockAuthRemoteDataSource.editProfile(
            updateProfileInfoRequestEntity,
          );

          //Assert
          verify(
            mockAuthRemoteDataSource.editProfile(
              updateProfileInfoRequestEntity,
            ),
          ).called(1);
          expect(result, isA<ApiErrorResult<DriverEntity>>());
          result as ApiErrorResult<DriverEntity>;
          expect(result.errorMessage, expectedError);
        });
      });

      group("test uploadProfilePhoto", () {
        final File file = File('path/to/file');
        test(
          "when call it should return UploadProfileImageResponseEntity from data source with correct parameters",
          () async {
            //Arrange
            final expectedEntity =
                ProfileInfoDummy.dummyUploadProfileImageResponseEntityFake;
            final expectedResult =
                ApiSuccessResult<UploadProfileImageResponseEntity>(
                  expectedEntity,
                );

            provideDummy<ApiResult<UploadProfileImageResponseEntity>>(
              expectedResult,
            );

            when(
              mockAuthRemoteDataSource.uploadProfilePhoto(file),
            ).thenAnswer((_) async => expectedResult);

            //Act
            final result = await authRepoImpl.uploadProfilePhoto(file);

            //Assert
            verify(mockAuthRemoteDataSource.uploadProfilePhoto(file)).called(1);
            expect(
              result,
              isA<ApiSuccessResult<UploadProfileImageResponseEntity>>(),
            );
            result as ApiSuccessResult<UploadProfileImageResponseEntity>;
            expect(result.data, expectedEntity);
          },
        );

        test("when call failed it should return an error result", () async {
          //Arrange
          final expectedError = "Server-Error";
          final expectedResult =
              ApiErrorResult<UploadProfileImageResponseEntity>(expectedError);

          provideDummy<ApiResult<UploadProfileImageResponseEntity>>(
            expectedResult,
          );
          when(
            mockAuthRemoteDataSource.uploadProfilePhoto(file),
          ).thenAnswer((_) async => expectedResult);

          //Act
          final result = await authRepoImpl.uploadProfilePhoto(file);

          //Assert
          verify(mockAuthRemoteDataSource.uploadProfilePhoto(file)).called(1);
          expect(
            result,
            isA<ApiErrorResult<UploadProfileImageResponseEntity>>(),
          );
          result as ApiErrorResult<UploadProfileImageResponseEntity>;
          expect(result.errorMessage, expectedError);
        });
      });

      group("test getVehicle", () {
        const id = "fake-id";
        test(
          "when call it should return VehicleEntity from data source with correct parameters",
          () async {
            //Arrange
            final expectedEntity = ProfileInfoDummy.dummyVehicleEntityFake;
            final expectedResult = ApiSuccessResult<VehicleEntity>(
              expectedEntity,
            );

            provideDummy<ApiResult<VehicleEntity>>(expectedResult);
            when(
              mockAuthRemoteDataSource.getVehicle(id),
            ).thenAnswer((_) async => expectedResult);

            //Act
            final result = await mockAuthRemoteDataSource.getVehicle(id);

            //Assert
            verify(mockAuthRemoteDataSource.getVehicle(id)).called(1);
            expect(result, isA<ApiSuccessResult<VehicleEntity>>());
            result as ApiSuccessResult<VehicleEntity>;
            expect(result.data, expectedEntity);
          },
        );

        test("when call failed it should return an error result", () async {
          //Arrange
          final expectedError = "Server-Error";
          final expectedResult = ApiErrorResult<VehicleEntity>(expectedError);

          provideDummy<ApiResult<VehicleEntity>>(expectedResult);
          when(
            mockAuthRemoteDataSource.getVehicle(id),
          ).thenAnswer((_) async => expectedResult);

          //Act
          final result = await mockAuthRemoteDataSource.getVehicle(id);

          //Assert
          verify(mockAuthRemoteDataSource.getVehicle(id)).called(1);
          expect(result, isA<ApiErrorResult<VehicleEntity>>());
          result as ApiErrorResult<VehicleEntity>;
          expect(result.errorMessage, expectedError);
        });
      });

      group("test logout", () {
        late MockAuthRemoteDataSource mockAuthRemoteDataSource;
        late MockAuthLocalDataSource mockAuthLocalDataSource;
        late AuthRepoImpl authRepoImpl;
        final fakeLogoutResponseEntity =
            ProfileInfoDummy.fakeLogoutResponseEntity();
        final DioException fakeDioException = DioException(
          requestOptions: RequestOptions(),
          message: "fake_message",
        );
        final Exception fakeException = Exception();
        setUp(() {
          mockAuthRemoteDataSource = MockAuthRemoteDataSource();
          mockAuthLocalDataSource = MockAuthLocalDataSource();
          authRepoImpl = AuthRepoImpl(
            mockAuthRemoteDataSource,
            mockAuthLocalDataSource,
          );
          provideDummy<ApiResult<LogoutResponseEntity>>(
            ApiSuccessResult<LogoutResponseEntity>(fakeLogoutResponseEntity),
          );
          provideDummy<ApiResult<LogoutResponseEntity>>(
            ApiErrorResult<LogoutResponseEntity>(fakeException),
          );
        });
        test("logout success ApiResult LogoutResponseEntity", () async {
          final expectResult = ApiSuccessResult<LogoutResponseEntity>(
            fakeLogoutResponseEntity,
          );
          when(
            mockAuthRemoteDataSource.logout(),
          ).thenAnswer((_) async => expectResult);

          final result = await authRepoImpl.logout();
          expect(result, isA<ApiSuccessResult<LogoutResponseEntity>>());
          expect(
            (result as ApiSuccessResult<LogoutResponseEntity>).data.message,
            equals(fakeLogoutResponseEntity.message),
          );

          verify(mockAuthRemoteDataSource.logout()).called(1);
          verify(mockAuthLocalDataSource.userLogout()).called(1);
        });
        test("logout failure ApiResult DioError", () async {
          final expectResult = ApiErrorResult<LogoutResponseEntity>(
            fakeDioException,
          );
          when(
            mockAuthRemoteDataSource.logout(),
          ).thenAnswer((_) async => expectResult);

          final result = await authRepoImpl.logout();
          expect(result, isA<ApiErrorResult<LogoutResponseEntity>>());
          expect(
            (result as ApiErrorResult<LogoutResponseEntity>).errorMessage,
            contains(fakeDioException.message),
          );

          verify(mockAuthRemoteDataSource.logout()).called(1);
          verify(mockAuthLocalDataSource.userLogout()).called(1);
        });
        test("logout failure ApiResult Exception", () async {
          final expectResult = ApiErrorResult<LogoutResponseEntity>(
            fakeException,
          );
          when(
            mockAuthRemoteDataSource.logout(),
          ).thenAnswer((_) async => expectResult);

          final result = await authRepoImpl.logout();
          expect(result, isA<ApiErrorResult<LogoutResponseEntity>>());
          expect(
            (result as ApiErrorResult<LogoutResponseEntity>).error,
            equals(fakeException),
          );

          verify(mockAuthRemoteDataSource.logout()).called(1);
          verify(mockAuthLocalDataSource.userLogout()).called(1);
        });
      });
    });
  });
}
