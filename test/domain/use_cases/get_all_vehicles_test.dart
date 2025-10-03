import 'package:dio/dio.dart';
import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/data/repo/auth_repo_impl.dart';
import 'package:elevate_tracking_app/domain/entities/vehicles_entity.dart';
import 'package:elevate_tracking_app/domain/use_cases/get_all_vehicles_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../fixture/apply_fixture.dart';
import 'apply_use_case_test.mocks.dart';

@GenerateMocks([AuthRepoImpl])
void main() {
  group("Test get all vehicles use case", () {
    final List<VehiclesEntity> fakeListVehicles =
        ApplyFixture.fakeVehicleEntity();
    late MockAuthRepoImpl mockAuthRepoImpl;
    late GetAllVehiclesUseCase useCase;
    final DioException dioException = DioException(
      requestOptions: RequestOptions(),
      message: "fake_dio_message",
    );
    final Exception fakeException = Exception();
    setUp(() {
      mockAuthRepoImpl = MockAuthRepoImpl();
      useCase = GetAllVehiclesUseCase(mockAuthRepoImpl);
      provideDummy<ApiResult<List<VehiclesEntity>>>(
        ApiSuccessResult<List<VehiclesEntity>>(fakeListVehicles),
      );
      provideDummy<ApiResult<List<VehiclesEntity>>>(
        ApiErrorResult<List<VehiclesEntity>>(fakeException),
      );
    });
    test(
      "get all vehicles use case success ApiResult ApplyResponseEntity",
      () async {
        final expectResult = ApiSuccessResult<List<VehiclesEntity>>(
          fakeListVehicles,
        );
        when(
          mockAuthRepoImpl.getAllVehicles(),
        ).thenAnswer((_) async => expectResult);

        final result = await useCase.call();
        expect(result, isA<ApiSuccessResult<List<VehiclesEntity>>>());
        expect(
          (result as ApiSuccessResult<List<VehiclesEntity>>).data.length,
          equals(fakeListVehicles.length),
        );

        verify(mockAuthRepoImpl.getAllVehicles()).called(1);
      },
    );
    test("get all vehicles use case failure ApiResult DioError", () async {
      final expectResult = ApiErrorResult<List<VehiclesEntity>>(dioException);
      when(
        mockAuthRepoImpl.getAllVehicles(),
      ).thenAnswer((_) async => expectResult);

      final result = await useCase.call();
      expect(result, isA<ApiErrorResult<List<VehiclesEntity>>>());
      expect(
        (result as ApiErrorResult<List<VehiclesEntity>>).errorMessage,
        contains(dioException.message),
      );

      verify(mockAuthRepoImpl.getAllVehicles()).called(1);
    });
    test("get all vehicles use case failure ApiResult Exception", () async {
      final expectResult = ApiErrorResult<List<VehiclesEntity>>(fakeException);
      when(
        mockAuthRepoImpl.getAllVehicles(),
      ).thenAnswer((_) async => expectResult);

      final result = await useCase.call();
      expect(result, isA<ApiErrorResult<List<VehiclesEntity>>>());
      expect(
        (result as ApiErrorResult<List<VehiclesEntity>>).error,
        equals(fakeException),
      );

      verify(mockAuthRepoImpl.getAllVehicles()).called(1);
    });
  });
}
