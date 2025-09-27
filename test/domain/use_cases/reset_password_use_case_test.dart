import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/domain/entities/requests/reset_password_request_entity.dart';
import 'package:elevate_tracking_app/domain/entities/reset_password_entity.dart';
import 'package:elevate_tracking_app/domain/repo/auth_repo.dart';
import 'package:elevate_tracking_app/domain/use_cases/reset_password_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'reset_password_use_case_test.mocks.dart';

@GenerateMocks([AuthRepo])
void main() {
  group('test ResetPasswordUseCase', () {
    late MockAuthRepo mockAuthRepo;
    late ResetPasswordUseCase resetPasswordUseCase;
    late ResetPasswordRequestEntity resetPasswordRequestEntity;

    setUp((){
      mockAuthRepo = MockAuthRepo();
      resetPasswordUseCase = ResetPasswordUseCase(mockAuthRepo);
      resetPasswordRequestEntity = const ResetPasswordRequestEntity(
          email: "fake-email",
          newPassword: "fake-new-password"
      );
    });

    test("when call ResetPasswordUseCase it should return ResetPasswordEntity from repo with correct parameters", () async {
      //Arrange
      final expectedEntity = ResetPasswordEntity(
          message: "fake-message"
      );
      final expectedResult = ApiSuccessResult<ResetPasswordEntity>(expectedEntity);
      provideDummy<ApiResult<ResetPasswordEntity>>(expectedResult);
      when(
        mockAuthRepo.resetPassword(resetPasswordRequestEntity),
      ).thenAnswer((_) async => expectedResult);

      //Act
      final result = await resetPasswordUseCase(resetPasswordRequestEntity);

      //Assert
      verify(mockAuthRepo.resetPassword(resetPasswordRequestEntity)).called(1);
      expect(result, isA<ApiSuccessResult<ResetPasswordEntity>>());
      result as ApiSuccessResult<ResetPasswordEntity>;
      expect(result.data.message, equals(expectedEntity.message));
    });

    test(
      'when ResetPasswordUseCase failed it should return an error result',
          () async {
        //Arrange
        final expectedError = "Server Error";
        final expectedResult = ApiErrorResult<ResetPasswordEntity>(expectedError);
        provideDummy<ApiResult<ResetPasswordEntity>>(expectedResult);
        when(
          mockAuthRepo.resetPassword(resetPasswordRequestEntity),
        ).thenAnswer((_) async => expectedResult);

        //Act
        final result = await resetPasswordUseCase(resetPasswordRequestEntity);

        //Assert
        verify(mockAuthRepo.resetPassword(resetPasswordRequestEntity)).called(1);
        expect(result, isA<ApiErrorResult<ResetPasswordEntity>>());
        result as ApiErrorResult<ResetPasswordEntity>;
        expect(result.errorMessage, expectedError);
      },
    );
  });
}