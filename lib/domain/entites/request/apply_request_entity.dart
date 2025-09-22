import 'dart:io';
import 'package:equatable/equatable.dart';

class ApplyRequestEntity extends Equatable {
  final String country;
  final String firstName;
  final String lastName;
  final String vehicleType;
  final String vehicleNumber;
  final String nid;
  final String email;
  final String password;
  final String rePassword;
  final String gender;
  final String phone;
  final File? vehicleLicense;
  final File? nidImg;

  const ApplyRequestEntity({
    required this.country,
    required this.firstName,
    required this.lastName,
    required this.vehicleType,
    required this.vehicleNumber,
    required this.nid,
    required this.email,
    required this.password,
    required this.rePassword,
    required this.gender,
    required this.phone,
    this.vehicleLicense,
    this.nidImg,
  });

  @override
  List<Object?> get props => [
    country,
    firstName,
    lastName,
    vehicleType,
    vehicleNumber,
    nid,
    email,
    password,
    rePassword,
    gender,
    phone,
    vehicleLicense,
    nidImg,
  ];
}
