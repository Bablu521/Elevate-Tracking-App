import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'driver_dto.g.dart';

@JsonSerializable()
class DriverDto extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String? country;
  final String? firstName;
  final String? lastName;
  final String? vehicleType;
  final String? vehicleNumber;
  final String? vehicleLicense;
  @JsonKey(name: 'NID')
  final String? nid;
  @JsonKey(name: 'NIDImg')
  final String? nidImg;
  final String? email;
  final String? gender;
  final String? phone;
  final String? photo;
  final String? role;
  final DateTime? createdAt;

  const DriverDto({
    this.id,
    this.country,
    this.firstName,
    this.lastName,
    this.vehicleType,
    this.vehicleNumber,
    this.vehicleLicense,
    this.nid,
    this.nidImg,
    this.email,
    this.gender,
    this.phone,
    this.photo,
    this.role,
    this.createdAt,
  });

  factory DriverDto.fromJson(Map<String, dynamic> json) {
    return _$DriverDtoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DriverDtoToJson(this);

  @override
  List<Object?> get props {
    return [
      id,
      country,
      firstName,
      lastName,
      vehicleType,
      vehicleNumber,
      vehicleLicense,
      nid,
      nidImg,
      email,
      gender,
      phone,
      photo,
      role,
      createdAt,
    ];
  }
}