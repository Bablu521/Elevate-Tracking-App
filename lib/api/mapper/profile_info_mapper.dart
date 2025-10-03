import 'package:elevate_tracking_app/api/models/requests/auth/update_vehicle_request_dto.dart';
import 'package:elevate_tracking_app/api/models/responses/driver_dto.dart';
import 'package:elevate_tracking_app/api/models/requests/auth/update_profile_info_request_dto.dart';
import 'package:elevate_tracking_app/api/models/responses/upload_profile_image_response_dto/upload_profile_image_response_dto.dart';
import 'package:elevate_tracking_app/api/models/responses/vehicle_dto.dart';
import 'package:elevate_tracking_app/api/models/responses/logout_response_dto.dart';
import 'package:elevate_tracking_app/domain/entities/driver_entity.dart';
import 'package:elevate_tracking_app/domain/entities/logout_response_entity.dart';
import 'package:elevate_tracking_app/domain/entities/requests/update_profile_info_request_entity.dart';
import 'package:elevate_tracking_app/domain/entities/requests/update_vehicle_request_entity.dart';
import 'package:elevate_tracking_app/domain/entities/upload_profile_image_response_entity.dart';
import 'package:elevate_tracking_app/domain/entities/vehicle_entity.dart';


extension DriverMapper on DriverDto {
  DriverEntity toEntity() {
    return DriverEntity(
      id: id,
      country: country,
      firstName: firstName,
      lastName: lastName,
      vehicleType: vehicleType,
      vehicleNumber: vehicleNumber,
      vehicleLicense: vehicleLicense,
      nid: nid,
      nidImg: nidImg,
      email: email,
      gender: gender,
      phone: phone,
      photo: photo,
      role: role,
      createdAt: createdAt,
    );
  }
}

extension UpdateProfileInfoRequestMapper on UpdateProfileInfoRequestEntity {
  UpdateProfileInfoRequestDto toDto() {
    return UpdateProfileInfoRequestDto(
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
    );
  }
}

extension UploadProfileImageResponseMapper on UploadProfileImageResponseDto {
  UploadProfileImageResponseEntity toEntity() {
    return UploadProfileImageResponseEntity(message: message);
  }
}

extension VehicleMapper on VehicleDto {
  VehicleEntity toEntity() {
    return VehicleEntity(
      id: id,
      type: type,
      image: image,
      createdAt: createdAt,
      updatedAt: updatedAt,
      v: v,
    );
  }
}

extension LogoutResponseMapper on LogoutResponseDto {
  LogoutResponseEntity toEntity() {
    return LogoutResponseEntity(message: message);
  }
}

extension UpdateVehicleRequestMapper on UpdateVehicleRequestEntity {
  UpdateVehicleRequestDto toDto() {
    return UpdateVehicleRequestDto(
      vehicleNumber: vehicleNumber,
      vehicleType: vehicleType,
      vehicleLicense: vehicleLicense,
    );
  }
}
