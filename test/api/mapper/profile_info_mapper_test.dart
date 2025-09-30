import 'package:elevate_tracking_app/api/mapper/profile_info_mapper.dart';
import 'package:elevate_tracking_app/api/models/responses/driver_dto.dart';
import 'package:elevate_tracking_app/api/models/responses/vehicle_dto.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy/profile_info_dummy.dart';

void main() {
  group("test ProfileInfoMapper", () {
    group("test DriverMapper", () {
      test(
        "when call toEntity with null values should return DriverEntity with null values",
        () {
          //Arrange
          final DriverDto driverDto = ProfileInfoDummy.dummyDriverDtoNull;
          //Act
          final result = driverDto.toEntity();
          //Assert
          expect(result.id, isNull);
          expect(result.country, isNull);
          expect(result.firstName, isNull);
          expect(result.lastName, isNull);
          expect(result.vehicleType, isNull);
          expect(result.vehicleNumber, isNull);
          expect(result.vehicleLicense, isNull);
          expect(result.nid, isNull);
          expect(result.nidImg, isNull);
          expect(result.email, isNull);
          expect(result.gender, isNull);
          expect(result.phone, isNull);
          expect(result.photo, isNull);
          expect(result.role, isNull);
          expect(result.createdAt, isNull);
        },
      );

      test(
        "when call toEntity with right values should return DriverEntity with right values",
        () {
          //Arrange
          final DriverDto driverDto = ProfileInfoDummy.dummyDriverDtoFake;
          //Act
          final result = driverDto.toEntity();
          //Assert
          expect(result.id, driverDto.id);
          expect(result.country, driverDto.country);
          expect(result.firstName, driverDto.firstName);
          expect(result.lastName, driverDto.lastName);
          expect(result.vehicleType, driverDto.vehicleType);
          expect(result.vehicleNumber, driverDto.vehicleNumber);
          expect(result.vehicleLicense, driverDto.vehicleLicense);
          expect(result.nid, driverDto.nid);
          expect(result.nidImg, driverDto.nidImg);
          expect(result.email, driverDto.email);
          expect(result.gender, driverDto.gender);
          expect(result.phone, driverDto.phone);
          expect(result.photo, driverDto.photo);
          expect(result.role, driverDto.role);
          expect(result.createdAt, driverDto.createdAt);
        },
      );
    });

    group("test UpdateProfileInfoRequestMapper", () {
      test(
        "when call toDto with null values should return UpdateProfileInfoRequestDto with null values",
        () {
          //Arrange
          final updateProfileInfoRequestEntity =
              ProfileInfoDummy.dummyUpdateProfileInfoRequestEntityNull;
          //Act
          final result = updateProfileInfoRequestEntity.toDto();
          //Assert
          expect(result.firstName, isNull);
          expect(result.lastName, isNull);
          expect(result.email, isNull);
          expect(result.phone, isNull);
        },
      );

      test(
        "when call toDto with right values should return UpdateProfileInfoRequestDto with right values",
        () {
          //Arrange
          final updateProfileInfoRequestEntity =
              ProfileInfoDummy.dummyUpdateProfileInfoRequestEntityFake;
          //Act
          final result = updateProfileInfoRequestEntity.toDto();
          //Assert
          expect(result.firstName, updateProfileInfoRequestEntity.firstName);
          expect(result.lastName, updateProfileInfoRequestEntity.lastName);
          expect(result.email, updateProfileInfoRequestEntity.email);
          expect(result.phone, updateProfileInfoRequestEntity.phone);
        },
      );
    });

    group("test UploadProfileImageResponseMapper", () {
      test(
        "when call toEntity with null values should return UploadProfileImageResponseEntity with null values",
        () {
          //Arrange
          final uploadProfileImageResponseDto =
              ProfileInfoDummy.dummyUploadProfileImageResponseDtoNull;
          //Act
          final result = uploadProfileImageResponseDto.toEntity();
          //Assert
          expect(result.message, isNull);
        },
      );

      test(
        "when call toEntity with right values should return UploadProfileImageResponseEntity with right values",
        () {
          //Arrange
          final uploadProfileImageResponseDto =
              ProfileInfoDummy.dummyUploadProfileImageResponseDtoFake;
          //Act
          final result = uploadProfileImageResponseDto.toEntity();
          //Assert
          expect(result.message, uploadProfileImageResponseDto.message);
        },
      );
    });

    group("test VehicleMapper", () {
      test(
        "when call toEntity with null values should return VehicleEntity with null values",
        () {
          //Arrange
          final VehicleDto vehicleDto = ProfileInfoDummy.dummyVehicleDtoNull;
          //Act
          final result = vehicleDto.toEntity();
          //Assert
          expect(result.id, isNull);
          expect(result.type, isNull);
          expect(result.image, isNull);
          expect(result.createdAt, isNull);
          expect(result.updatedAt, isNull);
          expect(result.v, isNull);
        },
      );

      test(
        "when call toEntity with right values should return VehicleEntity with right values",
        () {
          //Arrange
          final VehicleDto vehicleDto = ProfileInfoDummy.dummyVehicleDtoFake;
          //Act
          final result = vehicleDto.toEntity();
          //Assert
          expect(result.id, vehicleDto.id);
          expect(result.type, vehicleDto.type);
          expect(result.image, vehicleDto.image);
          expect(result.createdAt, vehicleDto.createdAt);
          expect(result.updatedAt, vehicleDto.updatedAt);
          expect(result.v, vehicleDto.v);
        },
      );
    });

    test("logout mapper", () {
      final dto = ProfileInfoDummy.fakeLogoutResponseDto();
      final entity = dto.toEntity();
      expect(dto.message, equals(entity.message));
    });
  });
}
