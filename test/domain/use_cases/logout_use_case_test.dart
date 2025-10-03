import 'package:dio/dio.dart';
import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/domain/entities/logout_response_entity.dart';
import 'package:elevate_tracking_app/domain/repo/auth_repo.dart';
import 'package:elevate_tracking_app/domain/use_cases/logout_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy/profile_info_dummy.dart';
import 'login_use_case_test.mocks.dart';

@GenerateMocks([AuthRepo])
void main() {
  group("Test Apply use case", () {
    final fakeLogoutResponseEntity =
        ProfileInfoDummy.fakeLogoutResponseEntity();
    late MockAuthRepo mockAuthRepo;
    late LogoutUseCase useCase;
    final DioException dioException = DioException(
      requestOptions: RequestOptions(),
      message: "fake_dio_message",
    );
    final Exception fakeException = Exception();
    setUp(() {
      mockAuthRepo = MockAuthRepo();
      useCase = LogoutUseCase(mockAuthRepo);
      provideDummy<ApiResult<LogoutResponseEntity>>(
        ApiSuccessResult<LogoutResponseEntity>(fakeLogoutResponseEntity),
      );
      provideDummy<ApiResult<LogoutResponseEntity>>(
        ApiErrorResult<LogoutResponseEntity>(fakeException),
      );
    });
    test("logout use case success ApiResult LogoutResponseEntity", () async {
      final expectResult = ApiSuccessResult<LogoutResponseEntity>(
        fakeLogoutResponseEntity,
      );
      when(mockAuthRepo.logout()).thenAnswer((_) async => expectResult);

      final result = await useCase.call();
      expect(result, isA<ApiSuccessResult<LogoutResponseEntity>>());
      expect(
        (result as ApiSuccessResult<LogoutResponseEntity>).data.message,
        equals(fakeLogoutResponseEntity.message),
      );
      verify(mockAuthRepo.logout()).called(1);
    });
    test("logout use case failure ApiResult DioError", () async {
      final expectResult = ApiErrorResult<LogoutResponseEntity>(dioException);
      when(mockAuthRepo.logout()).thenAnswer((_) async => expectResult);

      final result = await useCase.call();
      expect(result, isA<ApiErrorResult<LogoutResponseEntity>>());
      expect(
        (result as ApiErrorResult<LogoutResponseEntity>).errorMessage,
        contains(dioException.message),
      );

      verify(mockAuthRepo.logout()).called(1);
    });
    test("logout use case failure ApiResult Exception", () async {
      final expectResult = ApiErrorResult<LogoutResponseEntity>(fakeException);
      when(mockAuthRepo.logout()).thenAnswer((_) async => expectResult);

      final result = await useCase.call();
      expect(result, isA<ApiErrorResult<LogoutResponseEntity>>());
      expect(
        (result as ApiErrorResult<LogoutResponseEntity>).error,
        equals(fakeException),
      );
      verify(mockAuthRepo.logout()).called(1);
    });
  });
}
