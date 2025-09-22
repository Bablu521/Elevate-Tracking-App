import 'dart:io';

import 'package:elevate_tracking_app/api/models/requests/apply_request_dto.dart';
import 'package:elevate_tracking_app/api/models/responses/apply_response_dto.dart';
import 'package:elevate_tracking_app/api/models/responses/driver_dto.dart';
import 'package:elevate_tracking_app/domain/entites/apply_response_entity.dart';
import 'package:elevate_tracking_app/domain/entites/request/apply_request_entity.dart';

import 'fake_image_file.dart';

class ApplyFixture {
  static Future<ApplyRequestDto> fakeApiClintRequestDto() async {
    final license = await createTempFile("license.png");
    final nid = await createTempFile("nid.png");
    return ApplyRequestDto(
      country: "Egypt",
      firstName: "Ahmed",
      lastName: "Ali",
      vehicleType: "676b31a45d05310ca82657ac",
      vehicleNumber: "12221",
      nid: "12345678912345",
      email: "ahmedutti@gmail.com",
      password: "Ahmed@123",
      rePassword: "Ahmed@123",
      gender: "male",
      phone: "+201010700884",
      vehicleLicense: license,
      nidImg: nid,
    );
  }

  static ApplyRequestDto fakeRequestDto() {
    return ApplyRequestDto(
      country: "Egypt",
      firstName: "Ahmed",
      lastName: "Ali",
      vehicleType: "676b31a45d05310ca82657ac",
      vehicleNumber: "12221",
      nid: "12345678912345",
      email: "ahmedutti@gmail.com",
      password: "Ahmed@123",
      rePassword: "Ahmed@123",
      gender: "male",
      phone: "+201010700884",
      vehicleLicense: File("test_resources/fake_license.png"),
      nidImg: File("test_resources/fake_nid.png"),
    );
  }

  /// Fake response DTO
  static ApplyResponseDto fakeResponseDto() {
    return const ApplyResponseDto(
      message: "success",
      token: "eyFakeTokenForTesting123456789",
      driver: Driver(
        country: "Egypt",
        firstName: "Ahmed",
        lastName: "Ali",
        vehicleType: "676b31a45d05310ca82657ac",
        vehicleNumber: "12221",
        vehicleLicense: "df8ce8dd-70f9-4819-9607-992fcb90b279-Vector.png",
        nid: "12345678912345",
        nidImg: "8a6de7c2-4fb8-4eef-b015-a17070a8cf7a-kTestFlower.png",
        email: "ahmedutti@gmail.com",
        gender: "male",
        phone: "+201010700884",
        photo: "default-profile.png",
        role: "driver",
        id: "68cf8c7ddd8937e0573ed395",
        createdAt: "2025-09-21T05:26:21.346Z",
      ),
    );
  }

  static Future<ApplyRequestEntity> fakeRequestEntity() async {
    final license = await createTempFile("fake_vehicle_license.png");
    final nid = await createTempFile("fake_nid.png");

    return ApplyRequestEntity(
      country: "Egypt",
      firstName: "Ahmed",
      lastName: "Ali",
      vehicleType: "Car",
      vehicleNumber: "12221",
      nid: "12345678912345",
      email: "ahmed@test.com",
      password: "Ahmed@123",
      rePassword: "Ahmed@123",
      gender: "male",
      phone: "+201010700884",
      vehicleLicense: license,
      nidImg: nid,
    );
  }

  static ApplyResponseEntity fakeResponseEntity() {
    return const ApplyResponseEntity(
      message: "success",
      token: "fake_token_123",
      country: "Egypt",
      firstName: "Ahmed",
      lastName: "Ali",
      vehicleType: "676b31a45d05310ca82657ac",
      vehicleNumber: "12221",
      vehicleLicense: "df8ce8dd-70f9-4819-9607-992fcb90b279-Vector.png",
      nid: "12345678912345",
      nidImg: "8a6de7c2-4fb8-4eef-b015-a17070a8cf7a-kTestFlower.png",
      email: "ahmedutti@gmail.com",
      gender: "male",
      phone: "+201010700884",
      photo: "default-profile.png",
      role: "driver",
      id: "68cf8c7ddd8937e0573ed395",
      createdAt: "2025-09-21T05:26:21.346Z",
    );
  }
}
