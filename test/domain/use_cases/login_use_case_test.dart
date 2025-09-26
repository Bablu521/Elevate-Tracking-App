import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/domain/entites/login_entity.dart';
import 'package:elevate_tracking_app/domain/repo/auth_repo.dart';
import 'package:elevate_tracking_app/domain/use_cases/login_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy/login_dummy_data.dart';
import 'login_use_case_test.mocks.dart';

@GenerateMocks([AuthRepo])
void main() {
  group("test LoginUseCase", () {
    late MockAuthRepo mockAuthRepo;
    late LoginUseCase loginUseCase;
    setUp(() {
      mockAuthRepo = MockAuthRepo();
      loginUseCase = LoginUseCase(mockAuthRepo);
    });

    final loginRequestEntity = LoginDummyData().fakeLoginRequestEntity;

    test("when call should return LoginEntity with right data", () async {
      final expectedEntity = LoginDummyData().fakeLoginEntity;
      final expectedResult = ApiSuccessResult<LoginEntity>(expectedEntity);

      provideDummy<ApiResult<LoginEntity>>(expectedResult);
      when(
        mockAuthRepo.login(loginRequestEntity),
      ).thenAnswer((_) async => expectedResult);

      final result = await loginUseCase(loginRequestEntity);

      verify(mockAuthRepo.login(loginRequestEntity)).called(1);

      expect(result, isA<ApiSuccessResult<LoginEntity>>());
      result as ApiSuccessResult<LoginEntity>;
      expect(result.data, expectedEntity);
    });

    test("when call failed should return error result", () async {
      final expectedError = "fake-error";
      final expectedResult = ApiErrorResult<LoginEntity>(expectedError);

      provideDummy<ApiResult<LoginEntity>>(expectedResult);
      when(
        mockAuthRepo.login(loginRequestEntity),
      ).thenAnswer((_) async => expectedResult);

      final result = await loginUseCase(loginRequestEntity);

      verify(mockAuthRepo.login(loginRequestEntity)).called(1);

      expect(result, isA<ApiErrorResult<LoginEntity>>());
      result as ApiErrorResult<LoginEntity>;
      expect(result.errorMessage, expectedError);
    });

  });
}
