import 'package:elevate_tracking_app/api/models/responses/driver_dto.dart';
import 'package:elevate_tracking_app/api/models/responses/profile_info_response_dto/profile_info_response_dto.dart';
import 'package:elevate_tracking_app/api/models/responses/upload_profile_image_response_dto/upload_profile_image_response_dto.dart';
import 'package:elevate_tracking_app/api/models/responses/vehicle_dto.dart';
import 'package:elevate_tracking_app/api/models/responses/vehicle_response_dto/vehicle_response_dto.dart';
import 'package:elevate_tracking_app/domain/entites/driver_entity.dart';
import 'package:elevate_tracking_app/domain/entites/requests/update_profile_info_request_entity.dart';
import 'package:elevate_tracking_app/domain/entites/upload_profile_image_response_entity.dart';
import 'package:elevate_tracking_app/domain/entites/vehicle_entity.dart';

class ProfileInfoDummy {
  static DriverDto dummyDriverDtoNull = const DriverDto(
    id: null,
    country: null,
    firstName: null,
    lastName: null,
    vehicleType: null,
    vehicleNumber: null,
    vehicleLicense: null,
    nid: null,
    nidImg: null,
    email: null,
    gender: null,
    phone: null,
    photo: null,
    role: null,
    createdAt: null,
  );

  static DriverDto dummyDriverDtoFake = DriverDto(
    id: "driver_123",
    country: "Egypt",
    firstName: "Ahmed",
    lastName: "Mahmoud",
    vehicleType: "Car",
    vehicleNumber: "ABC-1234",
    vehicleLicense: "LIC-98765",
    nid: "12345678901234",
    nidImg: "https://fakeurl.com/nid.png",
    email: "ahmed@example.com",
    gender: "Male",
    phone: "+201234567890",
    photo: "https://fakeurl.com/photo.png",
    role: "Driver",
    createdAt: DateTime.parse("2025-01-01T12:00:00Z"),
  );

  static DriverEntity dummyDriverEntityFake = DriverEntity(
    id: "driver_123",
    country: "Egypt",
    firstName: "Ahmed",
    lastName: "Mahmoud",
    vehicleType: "Car",
    vehicleNumber: "ABC-1234",
    vehicleLicense: "LIC-98765",
    nid: "12345678901234",
    nidImg: "https://fakeurl.com/nid.png",
    email: "ahmed@example.com",
    gender: "Male",
    phone: "+201234567890",
    photo: "https://fakeurl.com/photo.png",
    role: "Driver",
    createdAt: DateTime.parse("2025-01-01T12:00:00Z"),
  );

  static UpdateProfileInfoRequestEntity dummyUpdateProfileInfoRequestEntityNull =
      const UpdateProfileInfoRequestEntity(
        firstName: null,
        lastName: null,
        email: null,
        phone: null,
      );

  static  UpdateProfileInfoRequestEntity dummyUpdateProfileInfoRequestEntityFake =
      const UpdateProfileInfoRequestEntity(
        firstName: "Ahmed",
        lastName: "Mahmoud",
        email: "ahmed@example.com",
        phone: "+201234567890",
      );

  static UploadProfileImageResponseDto dummyUploadProfileImageResponseDtoNull =
      const UploadProfileImageResponseDto(message: null);

  static UploadProfileImageResponseDto dummyUploadProfileImageResponseDtoFake =
      const UploadProfileImageResponseDto(
        message: "Profile image uploaded successfully",
      );

  static UploadProfileImageResponseEntity dummyUploadProfileImageResponseEntityFake =
      const UploadProfileImageResponseEntity(
        message: "Profile image uploaded successfully",
      );
  
  static VehicleDto dummyVehicleDtoNull = const VehicleDto(
    id: null,
    type: null,
    image: null,
    createdAt: null,
    updatedAt: null,
    v: null,
  );

  static VehicleDto dummyVehicleDtoFake = VehicleDto(
    id: "veh_001",
    type: "Car",
    image: "https://fakeurl.com/car.png",
    createdAt: DateTime.parse("2025-01-01T10:00:00Z"),
    updatedAt: DateTime.parse("2025-01-02T15:30:00Z"),
    v: 1,
  );

  static VehicleEntity dummyVehicleEntityFake = VehicleEntity(
    id: "veh_001",
    type: "Car",
    image: "https://fakeurl.com/car.png",
    createdAt: DateTime.parse("2025-01-01T10:00:00Z"),
    updatedAt: DateTime.parse("2025-01-02T15:30:00Z"),
    v: 1,
  );

   static final VehicleResponseDto dummyVehicleResponseDtoFake = VehicleResponseDto(
    message: "Success",
    vehicle: ProfileInfoDummy.dummyVehicleDtoFake
  );

  static final ProfileInfoResponseDto dummyProfileInfoResponseDtoFake =
      ProfileInfoResponseDto(
    message: "Profile fetched successfully",
    driver: ProfileInfoDummy.dummyDriverDtoFake, 
  );
}
