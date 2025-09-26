import 'dart:io';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'apply_request_dto.g.dart';

@JsonSerializable()
class ApplyRequestDto extends Equatable {
  final String country;
  final String firstName;
  final String lastName;
  final String vehicleType;
  final String vehicleNumber;
  @JsonKey(name: "NID")
  final String nid;
  final String email;
  final String password;
  final String rePassword;
  final String gender;
  final String phone;

  @JsonKey(includeToJson: false, includeFromJson: false)
  final File? vehicleLicense;

  @JsonKey(includeToJson: false, includeFromJson: false , name: "NIDImg")
  final File? nidImg;

  const ApplyRequestDto({
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

  factory ApplyRequestDto.fromJson(Map<String, dynamic> json) =>
      _$ApplyRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ApplyRequestDtoToJson(this);

  Future<FormData> toFormData() async {
    return FormData.fromMap({
      ...toJson(),
      if (vehicleLicense != null)
        "vehicleLicense": await MultipartFile.fromFile(vehicleLicense!.path),
      if (nidImg != null) "NIDImg": await MultipartFile.fromFile(nidImg!.path),
    });
  }

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
