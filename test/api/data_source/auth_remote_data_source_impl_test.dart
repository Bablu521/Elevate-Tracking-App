import 'dart:io';
import 'package:elevate_tracking_app/api/client/api_client.dart';
import 'package:elevate_tracking_app/api/data_source/auth_remote_data_source_impl.dart';
import 'package:elevate_tracking_app/api/mapper/login_mapper.dart';
import 'package:elevate_tracking_app/api/mapper/profile_info_mapper.dart';
import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/domain/entites/driver_entity.dart';
import 'package:elevate_tracking_app/domain/entites/login_entity.dart';
import 'package:elevate_tracking_app/domain/entites/requests/update_profile_info_request_entity.dart';
import 'package:elevate_tracking_app/domain/entites/upload_profile_image_response_entity.dart';
import 'package:elevate_tracking_app/domain/entites/vehicle_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:path/path.dart' as path;

import '../../dummy/login_dummy_data.dart';
import '../../dummy/profile_info_dummy.dart';
import 'auth_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  group("test AuthRemoteDataSourceImpl", () {
    late MockApiClient mockApiClient;
    late AuthRemoteDataSourceImpl dataSource;

    setUp(() {
      mockApiClient = MockApiClient();
      dataSource = AuthRemoteDataSourceImpl(mockApiClient);
    });

    group("test login", () {
      final loginRequestEntity = LoginDummyData().fakeLoginRequestEntity;

      test(
        "when call login should return LoginEntity with right data",
        () async {
          final expectedResult = LoginDummyData().fakeLoginResponse;
          when(
            mockApiClient.login(loginRequestEntity.toRequest()),
          ).thenAnswer((_) async => expectedResult);

          final result = await dataSource.login(loginRequestEntity);

          verify(mockApiClient.login(loginRequestEntity.toRequest())).called(1);

          expect(result, isA<ApiSuccessResult<LoginEntity>>());
          result as ApiSuccessResult<LoginEntity>;
          expect(result.data, expectedResult.toEntity());
        },
      );

      test("when login failed should return error result", () async {
        final expectedError = "fake-error";
        when(
          mockApiClient.login(loginRequestEntity.toRequest()),
        ).thenThrow(Exception(expectedError));
        final result = await dataSource.login(loginRequestEntity);
        verify(mockApiClient.login(loginRequestEntity.toRequest())).called(1);
        expect(result, isA<ApiErrorResult<LoginEntity>>());
        result as ApiErrorResult<LoginEntity>;
        expect(result.errorMessage, contains(expectedError));
      });
    });

    group("test getLoggedDriverData", () {
      test(
        "when call it should return ProfileInfoResponseDto from api with correct parameters",
        () async {
          //Arrange
          final expectedResult =
              ProfileInfoDummy.dummyProfileInfoResponseDtoFake;

          when(
            mockApiClient.getLoggedDriverData(),
          ).thenAnswer((_) async => expectedResult);

          //Act
          final result = await dataSource.getLoggedDriverData();

          //Assert
          verify(mockApiClient.getLoggedDriverData()).called(1);
          expect(result, isA<ApiSuccessResult<DriverEntity>>());
          result as ApiSuccessResult<DriverEntity>;
          expect(result.data, expectedResult.driver!.toEntity());
        },
      );

      test("when call failed it should return an error result", () async {
        //Arrange
        final expectedError = "Server-Error";
        when(
          mockApiClient.getLoggedDriverData(),
        ).thenThrow(Exception(expectedError));

        //Act
        final result = await dataSource.getLoggedDriverData();

        //Assert
        verify(mockApiClient.getLoggedDriverData()).called(1);
        expect(result, isA<ApiErrorResult<DriverEntity>>());
        result as ApiErrorResult<DriverEntity>;
        expect(result.errorMessage, contains(expectedError));
      });
    });

    group("test editProfile", () {
      late UpdateProfileInfoRequestEntity updateProfileInfoRequestEntity;
      setUp(() {
        updateProfileInfoRequestEntity =
            ProfileInfoDummy.dummyUpdateProfileInfoRequestEntityFake;
      });
      test(
        "when call it should return ProfileInfoResponseDto from api with correct parameters",
        () async {
          //Arrange
          final expectedResult =
              ProfileInfoDummy.dummyProfileInfoResponseDtoFake;

          when(
            mockApiClient.editProfile(updateProfileInfoRequestEntity.toDto()),
          ).thenAnswer((_) async => expectedResult);

          //Act
          final result = await dataSource.editProfile(
            updateProfileInfoRequestEntity,
          );

          //Assert
          verify(
            mockApiClient.editProfile(updateProfileInfoRequestEntity.toDto()),
          ).called(1);
          expect(result, isA<ApiSuccessResult<DriverEntity>>());
          result as ApiSuccessResult<DriverEntity>;
          expect(result.data, expectedResult.driver!.toEntity());
        },
      );

      test("when call failed it should return an error result", () async {
        //Arrange
        final expectedError = "Server-Error";
        when(
          mockApiClient.editProfile(updateProfileInfoRequestEntity.toDto()),
        ).thenThrow(Exception(expectedError));

        //Act
        final result = await dataSource.editProfile(
          updateProfileInfoRequestEntity,
        );

        //Assert
        verify(
          mockApiClient.editProfile(updateProfileInfoRequestEntity.toDto()),
        ).called(1);
        expect(result, isA<ApiErrorResult<DriverEntity>>());
        result as ApiErrorResult<DriverEntity>;
        expect(result.errorMessage, contains(expectedError));
      });
    });

    group("test uploadProfilePhoto", () {
      late File file;

      setUp(() async {
        final tempDir = Directory.systemTemp.createTempSync();
        file = File(path.join(tempDir.path, "fake.png"));
        await file.writeAsString("fake content"); 
      });

      test(
        "when call it should return UploadProfileImageResponseDto from api with correct parameters",
        () async {
          //Arrange
          final expectedResult =
              ProfileInfoDummy.dummyUploadProfileImageResponseDtoFake;

          when(
            mockApiClient.uploadProfilePhoto(any),
          ).thenAnswer((_) async => expectedResult);

          //Act
          final result = await dataSource.uploadProfilePhoto(file);

          //Assert
          verify(mockApiClient.uploadProfilePhoto(any)).called(1);
          expect(
            result,
            isA<ApiSuccessResult<UploadProfileImageResponseEntity>>(),
          );
          result as ApiSuccessResult<UploadProfileImageResponseEntity>;
          expect(result.data, expectedResult.toEntity());
        },
      );

      test("when call failed it should return an error result", () async {
        //Arrange
        final expectedError = "Server-Error";

        when(
          mockApiClient.uploadProfilePhoto(any),
        ).thenThrow(Exception(expectedError));

        //Act
        final result = await dataSource.uploadProfilePhoto(file);

        //Assert
        verify(mockApiClient.uploadProfilePhoto(any)).called(1);
        expect(result, isA<ApiErrorResult<UploadProfileImageResponseEntity>>());
        result as ApiErrorResult<UploadProfileImageResponseEntity>;
        expect(result.errorMessage, contains(expectedError));
      });
    });

    group("test getVehicle", () {
      const id = "fake-id";
      test(
        "when call it should return VehicleResponseDto from api with correct parameters",
        () async {
          //Arrange
          final expectedResult =
              ProfileInfoDummy.dummyVehicleResponseDtoFake;

          when(
            mockApiClient.getVehicle(id),
          ).thenAnswer((_) async => expectedResult);

          //Act
          final result = await dataSource.getVehicle(id);

          //Assert
          verify(mockApiClient.getVehicle(id)).called(1);
          expect(result, isA<ApiSuccessResult<VehicleEntity>>());
          result as ApiSuccessResult<VehicleEntity>;
          expect(result.data, expectedResult.vehicle!.toEntity());
        },
      );

      test("when call failed it should return an error result", () async {
        //Arrange
        final expectedError = "Server-Error";
        when(
          mockApiClient.getVehicle(id),
        ).thenThrow(Exception(expectedError));

        //Act
        final result = await dataSource.getVehicle(id);

        //Assert
        verify(mockApiClient.getVehicle(id)).called(1);
        expect(result, isA<ApiErrorResult<VehicleEntity>>());
        result as ApiErrorResult<VehicleEntity>;
        expect(result.errorMessage, contains(expectedError));
      });
    });

  });
}
