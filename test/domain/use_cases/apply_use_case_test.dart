import 'package:dio/dio.dart';
import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/data/repo/auth_repo_impl.dart';
import 'package:elevate_tracking_app/domain/entities/apply_response_entity.dart';
import 'package:elevate_tracking_app/domain/use_cases/apply_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../fixture/apply_fixture.dart';
import 'apply_use_case_test.mocks.dart';

@GenerateMocks([AuthRepoImpl])
void main() {
  group("Test Apply use case", () {
    final fakeRequestEntity = ApplyFixture.fakeRequestEntity();
    final fakeResponseEntity = ApplyFixture.fakeResponseEntity();
    late MockAuthRepoImpl mockAuthRepoImpl;
    late ApplyUseCase useCase;
    final DioException dioException = DioException(
      requestOptions: RequestOptions(),
      message: "fake_dio_message",
    );
    final Exception fakeException = Exception();
    setUp(() {
      mockAuthRepoImpl = MockAuthRepoImpl();
      useCase = ApplyUseCase(mockAuthRepoImpl);
      provideDummy<ApiResult<ApplyResponseEntity>>(
        ApiSuccessResult<ApplyResponseEntity>(fakeResponseEntity),
      );
      provideDummy<ApiResult<ApplyResponseEntity>>(
        ApiErrorResult<ApplyResponseEntity>(fakeException),
      );
    });
    test("apply use case success ApiResult ApplyResponseEntity", () async {
      final fakeRequestEn = await fakeRequestEntity;
      final expectResult = ApiSuccessResult<ApplyResponseEntity>(
        fakeResponseEntity,
      );
      when(
        mockAuthRepoImpl.apply(request: fakeRequestEn),
      ).thenAnswer((_) async => expectResult);

      final result = await useCase.call(fakeRequestEn);
      expect(result, isA<ApiSuccessResult<ApplyResponseEntity>>());
      expect(
        (result as ApiSuccessResult<ApplyResponseEntity>).data.id,
        equals(fakeResponseEntity.id),
      );

      verify(mockAuthRepoImpl.apply(request: fakeRequestEn)).called(1);
    });
    test("apply use case failure ApiResult DioError", () async {
      final fakeRequestEn = await fakeRequestEntity;
      final expectResult = ApiErrorResult<ApplyResponseEntity>(dioException);
      when(
        mockAuthRepoImpl.apply(request: fakeRequestEn),
      ).thenAnswer((_) async => expectResult);

      final result = await useCase.call(fakeRequestEn);
      expect(result, isA<ApiErrorResult<ApplyResponseEntity>>());
      expect(
        (result as ApiErrorResult<ApplyResponseEntity>).errorMessage,
        contains(dioException.message),
      );

      verify(mockAuthRepoImpl.apply(request: fakeRequestEn)).called(1);
    });
    test("apply use case failure ApiResult Exception", () async {
      final fakeRequestEn = await fakeRequestEntity;
      final expectResult = ApiErrorResult<ApplyResponseEntity>(fakeException);
      when(
        mockAuthRepoImpl.apply(request: fakeRequestEn),
      ).thenAnswer((_) async => expectResult);

      final result = await useCase.call(fakeRequestEn);
      expect(result, isA<ApiErrorResult<ApplyResponseEntity>>());
      expect(
        (result as ApiErrorResult<ApplyResponseEntity>).error,
        equals(fakeException),
      );

      verify(mockAuthRepoImpl.apply(request: fakeRequestEn)).called(1);
    });
  });
}
