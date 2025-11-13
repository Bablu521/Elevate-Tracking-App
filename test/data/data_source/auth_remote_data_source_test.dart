import 'package:dio/dio.dart';
import 'package:elevate_tracking_app/api/client/api_client.dart';
import 'package:elevate_tracking_app/api/data_source/auth_remote_data_source_impl.dart';
import 'package:elevate_tracking_app/api/models/responses/apply_response_dto.dart';
import 'package:elevate_tracking_app/api/models/responses/vehicles_response.dart';
import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/domain/entites/apply_response_entity.dart';
import 'package:elevate_tracking_app/domain/entites/vehicles_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy/apply_fixture.dart';
import 'auth_remote_data_source_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  group("Apply remote data Source test", () {
    final fakeApplyRequestEntity = ApplyFixture.fakeRequestEntity();
    late ApplyResponseDto fakeApplyResponseDto;
    final VehiclesResponse fakeVehicleResponse =
        ApplyFixture.fakeVehiclesResponse();
    final List<VehicleEntity> fakeListVehicles =
        ApplyFixture.fakeVehicleEntity();
    final DioException fakeDioException = DioException(
      requestOptions: RequestOptions(),
      message: "fake_message",
    );
    final Exception fakeException = Exception();
    late MockApiClient mockApiClient;
    late AuthRemoteDataSourceImpl authRemoteDataSourceImpl;
    setUp(() {
      fakeApplyResponseDto = ApplyFixture.fakeResponseDto();
      mockApiClient = MockApiClient();
      authRemoteDataSourceImpl = AuthRemoteDataSourceImpl(mockApiClient);
    });
    test("apply success", () async {
      final fakeRequestEn = await fakeApplyRequestEntity;
      //ARRANGE
      when(
        mockApiClient.apply(any),
      ).thenAnswer((_) async => fakeApplyResponseDto);
      //ACT
      final result = await authRemoteDataSourceImpl.apply(
        request: fakeRequestEn,
      );
      //ASSERT
      expect(result, isA<ApiSuccessResult<ApplyResponseEntity>>());
      expect(
        (result as ApiSuccessResult<ApplyResponseEntity>).data.message,
        equals(fakeApplyResponseDto.message),
      );
      verify(mockApiClient.apply(any)).called(1);
    });
    test("apply dio exception", () async {
      final fakeRequestEn = await fakeApplyRequestEntity;
      //ARRANGE
      when(mockApiClient.apply(any)).thenThrow(fakeDioException);
      //ACT
      final result = await authRemoteDataSourceImpl.apply(
        request: fakeRequestEn,
      );
      //ASSERT
      expect(result, isA<ApiErrorResult<ApplyResponseEntity>>());
      expect(
        (result as ApiErrorResult<ApplyResponseEntity>).errorMessage,
        equals(contains(fakeDioException.message)),
      );
      verify(mockApiClient.apply(any)).called(1);
    });
    test("apply exception", () async {
      final fakeRequestEn = await fakeApplyRequestEntity;
      //ARRANGE
      when(mockApiClient.apply(any)).thenThrow(fakeException);
      //ACT
      final result = await authRemoteDataSourceImpl.apply(
        request: fakeRequestEn,
      );
      //ASSERT
      expect(result, isA<ApiErrorResult<ApplyResponseEntity>>());
      expect(
        (result as ApiErrorResult<ApplyResponseEntity>).error,
        equals(fakeException),
      );
      verify(mockApiClient.apply(any)).called(1);
    });
    test("get all vehicle success", () async {
      //ARRANGE
      when(
        mockApiClient.getAllVehicles(),
      ).thenAnswer((_) async => fakeVehicleResponse);
      //ACT
      final result = await authRemoteDataSourceImpl.getAllVehicles();
      //ASSERT
      expect(result, isA<ApiSuccessResult<List<VehicleEntity>>>());
      expect(
        (result as ApiSuccessResult<List<VehicleEntity>>).data.first.id,
        equals(fakeListVehicles.first.id),
      );
      verify(mockApiClient.getAllVehicles()).called(1);
    });
    test("get all vehicle dio exception", () async {
      //ARRANGE
      when(mockApiClient.getAllVehicles()).thenThrow(fakeDioException);
      //ACT
      final result = await authRemoteDataSourceImpl.getAllVehicles();
      //ASSERT
      expect(result, isA<ApiErrorResult<List<VehicleEntity>>>());
      expect(
        (result as ApiErrorResult<List<VehicleEntity>>).errorMessage,
        equals(contains(fakeDioException.message)),
      );
      verify(mockApiClient.getAllVehicles()).called(1);
    });
    test("get all vehicle exception", () async {
      //ARRANGE
      when(mockApiClient.getAllVehicles()).thenThrow(fakeException);
      //ACT
      final result = await authRemoteDataSourceImpl.getAllVehicles();
      //ASSERT
      expect(result, isA<ApiErrorResult<List<VehicleEntity>>>());
      expect(
        (result as ApiErrorResult<List<VehicleEntity>>).error,
        equals(fakeException),
      );
      verify(mockApiClient.getAllVehicles()).called(1);
    });
  });
}
