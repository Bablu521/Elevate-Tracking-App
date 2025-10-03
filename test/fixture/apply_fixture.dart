import 'dart:convert';
import 'dart:io';
import 'package:elevate_tracking_app/api/mapper/apply_mapper.dart';
import 'package:elevate_tracking_app/api/models/requests/apply_request_dto.dart';
import 'package:elevate_tracking_app/api/models/responses/apply_response_dto.dart';
import 'package:elevate_tracking_app/api/models/responses/country_dto.dart';
import 'package:elevate_tracking_app/api/models/responses/driver_dto.dart';
import 'package:elevate_tracking_app/api/models/responses/vehicle.dart';
import 'package:elevate_tracking_app/api/models/responses/vehicles_response.dart';
import 'package:elevate_tracking_app/core/constants/end_points.dart';
import 'package:elevate_tracking_app/domain/entities/apply_response_entity.dart';
import 'package:elevate_tracking_app/domain/entities/country_entity.dart';
import 'package:elevate_tracking_app/domain/entities/request/apply_request_entity.dart';
import 'package:elevate_tracking_app/domain/entities/vehicles_entity.dart';


import 'fake_file_json.dart';
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
      driver: DriverDto(
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

  static VehiclesResponse fakeVehiclesResponse() {
    return VehiclesResponse(
      message: "success",
      metadata: Metadata(
        currentPage: 1,
        totalPages: 1,
        limit: 40,
        totalItems: 7,
      ),
      vehicles: [
        Vehicle(
          id: "fake-id-122",
          type: "Motor Cycle",
          image: "https://fakeimg.pl/250x100/?text=MotorCycle",
          createdAt: "2024-12-25T01:45:45.397Z",
          updatedAt: "2024-12-25T01:45:45.397Z",
          v: 0,
        ),
        Vehicle(
          id: "fake-id-123",
          type: "SUV",
          image: "https://fakeimg.pl/250x100/?text=SUV",
          createdAt: "2024-12-25T01:47:19.749Z",
          updatedAt: "2024-12-25T01:47:19.749Z",
          v: 0,
        ),
        Vehicle(
          id: "fake-id-124",
          type: "SUV",
          image: "https://fakeimg.pl/250x100/?text=SUV",
          createdAt: "2024-12-25T01:47:19.749Z",
          updatedAt: "2024-12-25T01:47:19.749Z",
          v: 0,
        ),
      ],
    );
  }

  static List<VehiclesEntity> fakeVehicleEntity() {
    return fakeVehiclesResponse().vehicles!
        .map((entity) => entity.toEntity())
        .toList();
  }

  static Vehicle fakeVehicleDto() {
    return Vehicle(
      id: "fake-id-123",
      type: "SUV",
      image: "https://fakeimg.pl/250x100/?text=SUV",
      createdAt: "2024-12-25T01:47:19.749Z",
      updatedAt: "2024-12-25T01:47:19.749Z",
      v: 0,
    );
  }

  static CountryDto fakeCountryDto() {
    return const CountryDto(
      isoCode: "EG",
      name: "Egypt",
      phoneCode: "20",
      flag: "🇪🇬",
      currency: "EGP",
      latitude: "26.8206",
      longitude: "30.8025",
      timezones: [
        Timezone(
          zoneName: "Africa/Cairo",
          gmtOffset: 7200,
          gmtOffsetName: "UTC+02:00",
          abbreviation: "EET",
          tzName: "Eastern European Time",
        ),
      ],
    );
  }

  static CountryEntity fakeCountryEntity() {
    return fakeCountryDto().toEntity();
  }

  static List<CountryDto> fakeCountryDtoList() {
    return [
      fakeCountryDto(),
      const CountryDto(
        isoCode: "SA",
        name: "Saudi Arabia",
        phoneCode: "966",
        flag: "🇸🇦",
        currency: "SAR",
        latitude: "23.8859",
        longitude: "45.0792",
        timezones: [
          Timezone(
            zoneName: "Asia/Riyadh",
            gmtOffset: 10800,
            gmtOffsetName: "UTC+03:00",
            abbreviation: "AST",
            tzName: "Arabian Standard Time",
          ),
        ],
      ),
    ];
  }

  /// Fake List of Country Entities
  static List<CountryEntity> fakeCountryEntityList() {
    return fakeCountryDtoList().map((c) => c.toEntity()).toList();
  }

  static FakeAssetBundle fakeBundle = FakeAssetBundle({
    Endpoints.countryLocalData: jsonEncode([
      {
        "isoCode": "TR",
        "name": "Turkey",
        "phoneCode": "90",
        "flag": "🇹🇷",
        "flagUrl": "https://flagcdn.com/w320/tr.png",
        "currency": "TRY",
        "latitude": "39.00000000",
        "longitude": "35.00000000",
      },
    ]),
  });
}
