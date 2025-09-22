import 'package:dio/dio.dart';
import 'package:elevate_tracking_app/api/data_source/auth_remote_data_source_impl.dart';
import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/data/repo/auth_repo_impl.dart';
import 'package:elevate_tracking_app/domain/entites/apply_response_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../fixture/apply_fixture.dart';
import 'auth_repo_impl_test.mocks.dart';

@GenerateMocks([AuthRemoteDataSourceImpl])
void main() {
  group("Test Apply", () {
    final fakeRequestEntity = ApplyFixture.fakeRequestEntity();
    final fakeResponseEntity = ApplyFixture.fakeResponseEntity();
    late MockAuthRemoteDataSourceImpl mockAuthRemoteDataSourceImpl;
    late AuthRepoImpl authRepoImpl;
    final DioException dioException = DioException(
      requestOptions: RequestOptions(),
      message: "fake_dio_message",
    );
    final Exception fakeException = Exception();
    setUp(() {
      mockAuthRemoteDataSourceImpl = MockAuthRemoteDataSourceImpl();
      authRepoImpl = AuthRepoImpl(mockAuthRemoteDataSourceImpl);
      provideDummy<ApiResult<ApplyResponseEntity>>(
        ApiSuccessResult<ApplyResponseEntity>(fakeResponseEntity),
      );
      provideDummy<ApiResult<ApplyResponseEntity>>(
        ApiErrorResult<ApplyResponseEntity>(fakeException),
      );
    });
    test("apply success ApiResult ApplyResponseEntity", () async {
      final fakeRequestEn = await fakeRequestEntity;
      final expectResult = ApiSuccessResult<ApplyResponseEntity>(
        fakeResponseEntity,
      );
      when(
        mockAuthRemoteDataSourceImpl.apply(request: fakeRequestEn),
      ).thenAnswer((_) async => expectResult);

      final result = await authRepoImpl.apply(request: fakeRequestEn);
      expect(result, isA<ApiSuccessResult<ApplyResponseEntity>>());
      expect(
        (result as ApiSuccessResult<ApplyResponseEntity>).data.id,
        equals(fakeResponseEntity.id),
      );

      verify(
        mockAuthRemoteDataSourceImpl.apply(request: fakeRequestEn),
      ).called(1);
    });
    test("apply failure ApiResult DioError", () async {
      final fakeRequestEn = await fakeRequestEntity;
      final expectResult = ApiErrorResult<ApplyResponseEntity>(dioException);
      when(
        mockAuthRemoteDataSourceImpl.apply(request: fakeRequestEn),
      ).thenAnswer((_) async => expectResult);

      final result = await authRepoImpl.apply(request: fakeRequestEn);
      expect(result, isA<ApiErrorResult<ApplyResponseEntity>>());
      expect(
        (result as ApiErrorResult<ApplyResponseEntity>).errorMessage,
        contains(dioException.message),
      );

      verify(
        mockAuthRemoteDataSourceImpl.apply(request: fakeRequestEn),
      ).called(1);
    });
    test("apply failure ApiResult Exception", () async {
      final fakeRequestEn = await fakeRequestEntity;
      final expectResult = ApiErrorResult<ApplyResponseEntity>(fakeException);
      when(
        mockAuthRemoteDataSourceImpl.apply(request: fakeRequestEn),
      ).thenAnswer((_) async => expectResult);

      final result = await authRepoImpl.apply(request: fakeRequestEn);
      expect(result, isA<ApiErrorResult<ApplyResponseEntity>>());
      expect(
        (result as ApiErrorResult<ApplyResponseEntity>).error,
        equals(fakeException),
      );

      verify(
        mockAuthRemoteDataSourceImpl.apply(request: fakeRequestEn),
      ).called(1);
    });
  });
}
