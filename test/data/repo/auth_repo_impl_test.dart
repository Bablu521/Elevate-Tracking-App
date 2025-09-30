import 'dart:io';
import 'package:dio/dio.dart';
import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/data/data_source/auth_local_data_source.dart';
import 'package:elevate_tracking_app/data/data_source/auth_remote_data_source.dart';
import 'package:elevate_tracking_app/data/repo/auth_repo_impl.dart';
import 'package:elevate_tracking_app/domain/entites/driver_entity.dart';
import 'package:elevate_tracking_app/domain/entites/login_entity.dart';
import 'package:elevate_tracking_app/domain/entites/requests/update_profile_info_request_entity.dart';
import 'package:elevate_tracking_app/domain/entites/upload_profile_image_response_entity.dart';
import 'package:elevate_tracking_app/domain/entites/vehicle_entity.dart';
import 'package:elevate_tracking_app/domain/entites/logout_response_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy/login_dummy_data.dart';
import '../../dummy/profile_info_dummy.dart';
import 'auth_repo_impl_test.mocks.dart';

@GenerateMocks([AuthRemoteDataSource, AuthLocalDataSource])
void main() {
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
          final expectedResult = ApiSuccessResult<LoginEntity>(expectedEntity);

          provideDummy<ApiResult<LoginEntity>>(expectedResult);
          when(
            mockAuthRemoteDataSource.login(loginRequestEntity),
          ).thenAnswer((_) async => expectedResult);

          final result = await authRepoImpl.login(loginRequestEntity);

          verify(mockAuthRemoteDataSource.login(loginRequestEntity)).called(1);
          verify(
            mockAuthLocalDataSource.saveUserToken(token: expectedEntity.token),
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


      group("test getLoggedDriverData", () {
      test(
        "when call it should return DriverEntity from data source with correct parameters",
        () async {
          //Arrange
          final expectedEntity = ProfileInfoDummy.dummyDriverEntityFake;
          final expectedResult = ApiSuccessResult<DriverEntity>(expectedEntity);

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
          final expectedResult = ApiSuccessResult<DriverEntity>(expectedEntity);

          provideDummy<ApiResult<DriverEntity>>(expectedResult);
          when(
            mockAuthRemoteDataSource.editProfile(updateProfileInfoRequestEntity),
          ).thenAnswer((_) async => expectedResult);

          //Act
          final result = await mockAuthRemoteDataSource.editProfile(
            updateProfileInfoRequestEntity,
          );

          //Assert
          verify(
            mockAuthRemoteDataSource.editProfile(updateProfileInfoRequestEntity),
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
          mockAuthRemoteDataSource.editProfile(updateProfileInfoRequestEntity),
        ).thenAnswer((_) async => expectedResult);

        //Act
        final result = await mockAuthRemoteDataSource.editProfile(
          updateProfileInfoRequestEntity,
        );

        //Assert
        verify(
          mockAuthRemoteDataSource.editProfile(updateProfileInfoRequestEntity),
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
        final expectedResult = ApiErrorResult<UploadProfileImageResponseEntity>(
          expectedError,
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
        expect(result, isA<ApiErrorResult<UploadProfileImageResponseEntity>>());
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
      final expectResult = ApiErrorResult<LogoutResponseEntity>(fakeException);
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
}
