import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/domain/entities/email_verification_entity.dart';
import 'package:elevate_tracking_app/domain/entities/requests/email_verification_request_entity.dart';
import 'package:elevate_tracking_app/domain/repo/auth_repo.dart';
import 'package:elevate_tracking_app/domain/use_cases/email_verification_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'email_verification_use_case_test.mocks.dart';

@GenerateMocks([AuthRepo])
void main() {
  group('test VerifyResetCodeUseCase', () {
    late MockAuthRepo mockAuthRepo;
    late EmailVerificationUseCase emailVerificationUseCase;
    late EmailVerificationRequestEntity emailVerificationRequestEntity;

    setUp(() {
      mockAuthRepo = MockAuthRepo();
      emailVerificationUseCase = EmailVerificationUseCase(mockAuthRepo);
      emailVerificationRequestEntity =const  EmailVerificationRequestEntity(
        resetCode: "fake-reset-code",
      );
    });

    test(
      "when call EmailVerificationUseCase it should return EmailVerificationEntity from repo with correct parameters",
          () async {
        //Arrange
        final expectedEntity = EmailVerificationEntity(status: "fake-status");
        final expectedResult = ApiSuccessResult<EmailVerificationEntity>(
          expectedEntity,
        );
        provideDummy<ApiResult<EmailVerificationEntity>>(expectedResult);
        when(
          mockAuthRepo.emailVerification(emailVerificationRequestEntity),
        ).thenAnswer((_) async => expectedResult);

        //Act
        final result = await emailVerificationUseCase(emailVerificationRequestEntity);

        //Assert
        verify(
          mockAuthRepo.emailVerification(emailVerificationRequestEntity),
        ).called(1);
        expect(result, isA<ApiSuccessResult<EmailVerificationEntity>>());
        result as ApiSuccessResult<EmailVerificationEntity>;
        expect(result.data.status, equals(expectedEntity.status));
      },
    );

    test(
      'when EmailVerificationUseCase failed it should return an error result',
          () async {
        //Arrange
        final expectedError = "Server Error";
        final expectedResult = ApiErrorResult<EmailVerificationEntity>(expectedError);
        provideDummy<ApiResult<EmailVerificationEntity>>(expectedResult);
        when(
          mockAuthRepo.emailVerification(emailVerificationRequestEntity),
        ).thenAnswer((_) async => expectedResult);

        //Act
        final result = await emailVerificationUseCase(emailVerificationRequestEntity);

        //Assert
        verify(
          mockAuthRepo.emailVerification(emailVerificationRequestEntity),
        ).called(1);
        expect(result, isA<ApiErrorResult<EmailVerificationEntity>>());
        result as ApiErrorResult<EmailVerificationEntity>;
        expect(result.errorMessage, expectedError);
      },
    );
  });
}