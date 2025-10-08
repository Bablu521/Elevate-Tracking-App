import 'package:dio/dio.dart';
import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/domain/entites/driver_entity.dart';
import 'package:elevate_tracking_app/domain/entites/requests/update_vehicle_request_entity.dart';
import 'package:elevate_tracking_app/domain/repo/auth_repo.dart';
import 'package:elevate_tracking_app/domain/use_cases/update_vehicle_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy/profile_info_dummy.dart';
import 'update_vehicle_use_case_test.mocks.dart';

@GenerateMocks([AuthRepo])
void main() {
  group("test update vehicle use case", () {
    late AuthRepo authRepo;
    late UpdateVehicleUseCase useCase;
    final DriverEntity driverEntity = ProfileInfoDummy.dummyDriverEntityFake;
    final DioException dioException = DioException(
      requestOptions: RequestOptions(),
      message: "fake_dio",
    );

    setUpAll(() {
      authRepo = MockAuthRepo();
      useCase = UpdateVehicleUseCase(authRepo);
      provideDummy<ApiResult<DriverEntity>>(
        ApiSuccessResult<DriverEntity>(driverEntity),
      );
      provideDummy<ApiResult<DriverEntity>>(
        ApiErrorResult<DriverEntity>(dioException),
      );
    });
    test("test update vehicle success", () async {
      //ARRANGE
      final expectResult = ApiSuccessResult<DriverEntity>(driverEntity);
      final UpdateVehicleRequestEntity requestEntity =
          await ProfileInfoDummy.fakeUpdateVehicleRequestEntity();
      when(
        authRepo.updateVehicleInfo(request: requestEntity),
      ).thenAnswer((_) async => expectResult);
      //ACT
      final result = await useCase.call(requestEntity);
      //ASSERT
      verify(authRepo.updateVehicleInfo(request: requestEntity)).called(1);
      expect(result, isA<ApiSuccessResult<DriverEntity>>());
      expect(
        (result as ApiSuccessResult<DriverEntity>).data.email,
        driverEntity.email,
      );
      expect(result.data.gender, driverEntity.gender);
    });
    test("test update vehicle failure", () async {
      //ARRANGE
      final expectResult = ApiErrorResult<DriverEntity>(dioException);
      final UpdateVehicleRequestEntity requestEntity =
          await ProfileInfoDummy.fakeUpdateVehicleRequestEntity();
      when(
        authRepo.updateVehicleInfo(request: requestEntity),
      ).thenAnswer((_) async => expectResult);
      //ACT
      final result = await useCase.call(requestEntity);
      //ASSERT
      verify(authRepo.updateVehicleInfo(request: requestEntity)).called(1);
      expect(result, isA<ApiErrorResult<DriverEntity>>());
      expect(
        (result as ApiErrorResult<DriverEntity>).errorMessage,
        contains(dioException.message),
      );
    });
  });
}
