import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/data/data_source/auth_remote_data_source.dart';
import 'package:elevate_tracking_app/data/repo/auth_repo_impl.dart';
import 'package:elevate_tracking_app/domain/entities/email_verification_entity.dart';
import 'package:elevate_tracking_app/domain/entities/forget_password_entity.dart';
import 'package:elevate_tracking_app/domain/entities/requests/email_verification_request_entity.dart';
import 'package:elevate_tracking_app/domain/entities/requests/forget_password_request_entity.dart';
import 'package:elevate_tracking_app/domain/entities/requests/reset_password_request_entity.dart';
import 'package:elevate_tracking_app/domain/entities/reset_password_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_repo_impl_test.mocks.dart';

@GenerateMocks([AuthRemoteDataSource])
void main() {
  group('test AuthRepoImpl', () {
    late MockAuthRemoteDataSource mockedAuthRemoteDataSource;
    late AuthRepoImpl authRepoImpl;

    setUp(() {
      mockedAuthRemoteDataSource = MockAuthRemoteDataSource();
      authRepoImpl = AuthRepoImpl(mockedAuthRemoteDataSource);
    });

    group("test forgetPassword", () {
      final forgetPasswordRequestEntity = const ForgetPasswordRequestEntity(
        email: "fake-email",
      );

      test(
        "when call forgetPassword it should return ForgetPasswordEntity from data source with right parameters",
        () async {
          //Arrange
          final expectedEntity = ForgetPasswordEntity(
            message: "fake-message",
            info: "fake-info",
          );
          final expectedResult = ApiSuccessResult<ForgetPasswordEntity>(
            expectedEntity,
          );
          provideDummy<ApiResult<ForgetPasswordEntity>>(expectedResult);
          when(
            mockedAuthRemoteDataSource.forgetPassword(
              forgetPasswordRequestEntity,
            ),
          ).thenAnswer((_) async => expectedResult);
          //Act
          final result = await authRepoImpl.forgetPassword(
            forgetPasswordRequestEntity,
          );
          //Assert
          verify(
            mockedAuthRemoteDataSource.forgetPassword(
              forgetPasswordRequestEntity,
            ),
          ).called(1);
          expect(result, isA<ApiSuccessResult<ForgetPasswordEntity>>());
          result as ApiSuccessResult<ForgetPasswordEntity>;
          expect(result.data.info, equals(expectedEntity.info));
          expect(result.data.message, equals(expectedEntity.message));
        },
      );

      test(
        "when forgetPassword failed it should return an error result",
        () async {
          //Arrange
          final expectedError = "Server Error";
          final expectedResult = ApiErrorResult<ForgetPasswordEntity>(
            expectedError,
          );
          provideDummy<ApiResult<ForgetPasswordEntity>>(expectedResult);
          when(
            mockedAuthRemoteDataSource.forgetPassword(
              forgetPasswordRequestEntity,
            ),
          ).thenAnswer((_) async => expectedResult);

          //Call
          final result = await authRepoImpl.forgetPassword(
            forgetPasswordRequestEntity,
          );

          //Assert
          verify(
            mockedAuthRemoteDataSource.forgetPassword(
              forgetPasswordRequestEntity,
            ),
          ).called(1);
          expect(result, isA<ApiErrorResult<ForgetPasswordEntity>>());
          result as ApiErrorResult<ForgetPasswordEntity>;
          expect(result.errorMessage, expectedError);
        },
      );
    });

    group("test resetPassword", () {
      final resetPasswordRequestEntity = const ResetPasswordRequestEntity(
        email: "fake-email",
        newPassword: "fake-new-password",
      );

      test(
        "when call resetPassword it should return ResetPasswordEntity from data source with right parameters",
        () async {
          //Arrange
          final expectedEntity = ResetPasswordEntity(message: "fake-message");
          final expectedResult = ApiSuccessResult<ResetPasswordEntity>(
            expectedEntity,
          );
          provideDummy<ApiResult<ResetPasswordEntity>>(expectedResult);
          when(
            mockedAuthRemoteDataSource.resetPassword(
              resetPasswordRequestEntity,
            ),
          ).thenAnswer((_) async => expectedResult);
          //Act
          final result = await authRepoImpl.resetPassword(
            resetPasswordRequestEntity,
          );
          //Assert
          verify(
            mockedAuthRemoteDataSource.resetPassword(
              resetPasswordRequestEntity,
            ),
          ).called(1);
          expect(result, isA<ApiSuccessResult<ResetPasswordEntity>>());
          result as ApiSuccessResult<ResetPasswordEntity>;
          expect(result.data.message, equals(expectedEntity.message));
        },
      );

      test(
        "when resetPassword failed it should return an error result",
        () async {
          //Arrange
          final expectedError = "Server Error";
          final expectedResult = ApiErrorResult<ResetPasswordEntity>(
            expectedError,
          );
          provideDummy<ApiResult<ResetPasswordEntity>>(expectedResult);
          when(
            mockedAuthRemoteDataSource.resetPassword(
              resetPasswordRequestEntity,
            ),
          ).thenAnswer((_) async => expectedResult);

          //Call
          final result = await authRepoImpl.resetPassword(
            resetPasswordRequestEntity,
          );

          //Assert
          verify(
            mockedAuthRemoteDataSource.resetPassword(
              resetPasswordRequestEntity,
            ),
          ).called(1);
          expect(result, isA<ApiErrorResult<ResetPasswordEntity>>());
          result as ApiErrorResult<ResetPasswordEntity>;
          expect(result.errorMessage, expectedError);
        },
      );
    });

    group("test emailVerification", () {
      final emailVerificationRequestEntity =
          const EmailVerificationRequestEntity(resetCode: "fake-reset-code");

      test(
        "when call emailVerification it should return EmailVerificationEntity from data source with right parameters",
        () async {
          //Arrange
          final expectedEntity = EmailVerificationEntity(status: "fake-status");
          final expectedResult = ApiSuccessResult<EmailVerificationEntity>(
            expectedEntity,
          );
          provideDummy<ApiResult<EmailVerificationEntity>>(expectedResult);
          when(
            mockedAuthRemoteDataSource.emailVerification(
              emailVerificationRequestEntity,
            ),
          ).thenAnswer((_) async => expectedResult);
          //Act
          final result = await authRepoImpl.emailVerification(
            emailVerificationRequestEntity,
          );
          //Assert
          verify(
            mockedAuthRemoteDataSource.emailVerification(
              emailVerificationRequestEntity,
            ),
          ).called(1);
          expect(result, isA<ApiSuccessResult<EmailVerificationEntity>>());
          result as ApiSuccessResult<EmailVerificationEntity>;
          expect(result.data.status, equals(expectedEntity.status));
        },
      );

      test(
        "when emailVerification failed it should return an error result",
        () async {
          //Arrange
          final expectedError = "Server Error";
          final expectedResult = ApiErrorResult<EmailVerificationEntity>(
            expectedError,
          );
          provideDummy<ApiResult<EmailVerificationEntity>>(expectedResult);
          when(
            mockedAuthRemoteDataSource.emailVerification(
              emailVerificationRequestEntity,
            ),
          ).thenAnswer((_) async => expectedResult);

          //Call
          final result = await authRepoImpl.emailVerification(
            emailVerificationRequestEntity,
          );

          //Assert
          verify(
            mockedAuthRemoteDataSource.emailVerification(
              emailVerificationRequestEntity,
            ),
          ).called(1);
          expect(result, isA<ApiErrorResult<EmailVerificationEntity>>());
          result as ApiErrorResult<EmailVerificationEntity>;
          expect(result.errorMessage, expectedError);
        },
      );
    });

  });
}
