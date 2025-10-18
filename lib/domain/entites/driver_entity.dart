import 'package:equatable/equatable.dart';

class DriverEntity extends Equatable {

  final String? id;
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
  final String? createdAt;

  const DriverEntity({
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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'country': country,
      'firstName': firstName,
      'lastName': lastName,
      'vehicleType': vehicleType,
      'vehicleNumber': vehicleNumber,
      'vehicleLicense': vehicleLicense,
      'nid': nid,
      'nidImg': nidImg,
      'email': email,
      'gender': gender,
      'phone': phone,
      'photo': photo,
      'role': role,
      'createdAt': createdAt,
    };
  }

  factory DriverEntity.fromMap(Map<String, dynamic> map) {
    return DriverEntity(
      id: map['id'] as String?,
      country: map['country'] as String?,
      firstName: map['firstName'] as String?,
      lastName: map['lastName'] as String?,
      vehicleType: map['vehicleType'] as String?,
      vehicleNumber: map['vehicleNumber'] as String?,
      vehicleLicense: map['vehicleLicense'] as String?,
      nid: map['nid'] as String?,
      nidImg: map['nidImg'] as String?,
      email: map['email'] as String?,
      gender: map['gender'] as String?,
      phone: map['phone'] as String?,
      photo: map['photo'] as String?,
      role: map['role'] as String?,
      createdAt: map['createdAt'] as String?,
    );
  }

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