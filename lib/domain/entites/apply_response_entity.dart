import 'package:equatable/equatable.dart';

class ApplyResponseEntity extends Equatable {
  final String? message;
  final String? token;
  final String? country;
  final String? firstName;
  final String? lastName;
  final String? vehicleType;
  final String? vehicleNumber;
  final String? vehicleLicense;
  final String? nid;
  final String? nidImg;
  final String? email;
  final String? gender;
  final String? phone;
  final String? photo;
  final String? role;
  final String? id;
  final String? createdAt;
  const ApplyResponseEntity({
    this.message = '',
    this.token = '',
    this.country = '',
    this.firstName = '',
    this.lastName = '',
    this.vehicleType = '',
    this.vehicleNumber = '',
    this.vehicleLicense = '',
    this.nid = '',
    this.nidImg = '',
    this.email = '',
    this.gender = '',
    this.phone = '',
    this.photo = '',
    this.role = '',
    this.id = '',
    this.createdAt = '',
  });

  @override
  List<Object?> get props => [
    message,
    token,
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
    id,
    createdAt,
  ];
}
