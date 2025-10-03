import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/domain/entities/vehicle_entity.dart';
import 'package:elevate_tracking_app/domain/repo/auth_repo.dart';
import 'package:elevate_tracking_app/domain/use_cases/get_vehicle_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy/profile_info_dummy.dart';
import 'get_vehicle_use_case_test.mocks.dart';

@GenerateMocks([AuthRepo])
void main() {
  late MockAuthRepo mockedAuthRepo;
  late GetVehicleUseCase getVehicleUseCase;
  const id = "fake-id";
  setUp(() {
    mockedAuthRepo = MockAuthRepo();
    getVehicleUseCase = GetVehicleUseCase(mockedAuthRepo);
  });
  group("test GetVehicleUseCase", () {
    test(
      "when call it should return VehicleEntity from repo with correct parameters",
      () async {
        //Arrange
        final expectedEntity = ProfileInfoDummy.dummyVehicleEntityFake;
        final expectedResult = ApiSuccessResult<VehicleEntity>(expectedEntity);

        provideDummy<ApiResult<VehicleEntity>>(expectedResult);
        when(
          mockedAuthRepo.getVehicle(id),
        ).thenAnswer((_) async => expectedResult);

        //Act
        final result = await getVehicleUseCase.call(id);

        //Assert
        verify(mockedAuthRepo.getVehicle(id)).called(1);
        expect(result, isA<ApiSuccessResult<VehicleEntity>>());
        result as ApiSuccessResult<VehicleEntity>;
        expect(result.data, expectedEntity);
      },
    );

    test("when call failed it should return an error result", () async {
      //Arrange
      final expectedError = "Server-Error";
      final expectedResult = ApiErrorResult<VehicleEntity>(expectedError);

      provideDummy<ApiResult<VehicleEntity>>(expectedResult);
      when(
        mockedAuthRepo.getVehicle(id),
      ).thenAnswer((_) async => expectedResult);

      //Act
      final result = await getVehicleUseCase.call(id);

      //Assert
      verify(mockedAuthRepo.getVehicle(id)).called(1);
      expect(result, isA<ApiErrorResult<VehicleEntity>>());
      result as ApiErrorResult<VehicleEntity>;
      expect(result.errorMessage, expectedError);
    });
  });
}