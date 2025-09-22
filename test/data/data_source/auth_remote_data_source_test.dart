import 'package:dio/dio.dart';
import 'package:elevate_tracking_app/api/client/api_client.dart';
import 'package:elevate_tracking_app/api/data_source/auth_remote_data_source_impl.dart';
import 'package:elevate_tracking_app/api/models/responses/apply_response_dto.dart';
import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/domain/entites/apply_response_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../fixture/apply_fixture.dart';
import 'auth_remote_data_source_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  group("Apply remote data Source test", () {
    final fakeRequestEntity = ApplyFixture.fakeRequestEntity();
    late ApplyResponseDto fakeResponseDto;
    final DioException fakeDioException = DioException(
      requestOptions: RequestOptions(),
      message: "fake_message",
    );
    final Exception fakeException = Exception();
    late MockApiClient mockApiClient;
    late AuthRemoteDataSourceImpl authRemoteDataSourceImpl;
    setUp(() {
      fakeResponseDto = ApplyFixture.fakeResponseDto();
      mockApiClient = MockApiClient();
      authRemoteDataSourceImpl = AuthRemoteDataSourceImpl(mockApiClient);
    });
    test("apply success", () async {
      final fakeRequestEn = await fakeRequestEntity;
      //ARRANGE
      when(mockApiClient.apply(any)).thenAnswer((_) async => fakeResponseDto);
      //ACT
      final result = await authRemoteDataSourceImpl.apply(
        request: fakeRequestEn,
      );
      //ASSERT
      expect(result, isA<ApiSuccessResult<ApplyResponseEntity>>());
      expect(
        (result as ApiSuccessResult<ApplyResponseEntity>).data.message,
        equals(fakeResponseDto.message),
      );
      verify(mockApiClient.apply(any)).called(1);
    });
    test("apply dio exception", () async {
      final fakeRequestEn = await fakeRequestEntity;
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
      final fakeRequestEn = await fakeRequestEntity;
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
  });
}
