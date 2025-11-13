import 'package:elevate_tracking_app/api/models/responses/apply_response_dto.dart';
import 'package:elevate_tracking_app/api/models/responses/country_dto.dart';
import 'package:elevate_tracking_app/api/models/responses/vehicle.dart';
import 'package:elevate_tracking_app/domain/entites/apply_response_entity.dart';
import 'package:elevate_tracking_app/api/models/requests/apply_request_dto.dart';
import 'package:elevate_tracking_app/domain/entites/country_entity.dart';
import 'package:elevate_tracking_app/domain/entites/request/apply_request_entity.dart';
import 'package:elevate_tracking_app/domain/entites/vehicles_entity.dart';

extension ApplyResponseMapper on ApplyResponseDto {
  ApplyResponseEntity toEntity() {
    return ApplyResponseEntity(
      country: driver.country,
      message: message,
      token: token,
      createdAt: driver.createdAt,
      email: driver.email,
      firstName: driver.firstName,
      lastName: driver.lastName,
      gender: driver.gender,
      id: driver.id,
      photo: driver.photo,
      phone: driver.phone,
      vehicleNumber: driver.vehicleNumber,
      nid: driver.nid,
      nidImg: driver.nidImg,
      role: driver.role,
      vehicleLicense: driver.vehicleLicense,
      vehicleType: driver.vehicleType,
    );
  }
}

extension ApplyRequestMapper on ApplyRequestEntity {
  ApplyRequestDto toDto() {
    return ApplyRequestDto(
      country: country,
      firstName: firstName,
      lastName: lastName,
      vehicleType: vehicleType,
      vehicleNumber: vehicleNumber,
      nid: nid,
      email: email,
      password: password,
      rePassword: rePassword,
      gender: gender,
      phone: phone,
      vehicleLicense: vehicleLicense,
      nidImg: nidImg,
    );
  }
}

extension VehicleMapper on Vehicle {
  VehicleEntity toEntity() {
    return VehicleEntity(id: id ?? '', type: type ?? '', image: image ?? '');
  }
}

extension CountryMapper on CountryDto {
  CountryEntity toEntity() {
    return CountryEntity(
      name: name ?? '',
      flag: flag ?? '',
      currency: currency ?? '',
      flagImage: flagUrl ?? '',
    );
  }
}
