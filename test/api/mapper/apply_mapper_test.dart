import 'package:elevate_tracking_app/api/mapper/apply_mapper.dart';
import 'package:elevate_tracking_app/api/models/responses/apply_response_dto.dart';
import 'package:elevate_tracking_app/api/models/responses/country_dto.dart';
import 'package:elevate_tracking_app/api/models/responses/vehicle.dart';
import 'package:elevate_tracking_app/domain/entites/country_entity.dart';
import 'package:elevate_tracking_app/domain/entites/request/apply_request_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixture/apply_fixture.dart';

void main() {
  group("Apply Mapper", () {
    test("toDto should map correctly", () async {
      // ARRANGE: Fake DTO
      final ApplyRequestEntity entity = await ApplyFixture.fakeRequestEntity();
      // ACT:
      final dto = entity.toDto();
      // ASSERT:
      expect(dto.country, equals(entity.country));
      expect(dto.email, equals(entity.email));
      expect(dto.firstName, equals(entity.firstName));
      expect(dto.lastName, equals(entity.lastName));
      expect(dto.vehicleNumber, equals(entity.vehicleNumber));
      expect(dto.nid, equals(entity.nid));
      expect(dto.nidImg, equals(entity.nidImg));
      expect(dto.password, equals(entity.password));
      expect(dto.phone, equals(entity.phone));
      expect(dto.vehicleType, equals(entity.vehicleType));
    });
    test("toEntity should map correctly", () {
      // ARRANGE: Fake DTO
      final ApplyResponseDto dto = ApplyFixture.fakeResponseDto();
      // ACT:
      final entity = dto.toEntity();
      // ASSERT:
      expect(entity.message, equals(dto.message));
      expect(entity.token, equals(dto.token));
      expect(entity.firstName, equals(dto.driver.firstName));
      expect(entity.lastName, equals(dto.driver.lastName));
      expect(entity.vehicleNumber, equals(dto.driver.vehicleNumber));
      expect(entity.nid, equals(dto.driver.nid));
      expect(entity.nidImg, equals(dto.driver.nidImg));
      expect(entity.role, equals(dto.driver.role));
      expect(entity.vehicleLicense, equals(dto.driver.vehicleLicense));
      expect(entity.vehicleType, equals(dto.driver.vehicleType));
    });
    test("vehicle toEntity should map correctly", () {
      // ARRANGE: Fake DTO
      final Vehicle dto = ApplyFixture.fakeVehicleDto();

      // ACT:
      final entity = dto.toEntity();
      // ASSERT:
      expect(entity.id, equals(dto.id));
      expect(entity.image, equals(dto.image));
      expect(entity.type, equals(dto.type));
    });
    test("country toEntity should map correctly", () {
      //ARRANGE:
      final CountryDto dto = ApplyFixture.fakeCountryDto();
      //ACT:
      final CountryEntity entity = dto.toEntity();
      //ASSERT:
      expect(entity.currency, equals(dto.currency));
      expect(entity.name, equals(dto.name));
      expect(entity.flag, equals(dto.flag));
    });
  });
}
