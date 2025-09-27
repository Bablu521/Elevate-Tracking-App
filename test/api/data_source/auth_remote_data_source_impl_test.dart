import 'package:elevate_tracking_app/api/client/api_client.dart';
import 'package:elevate_tracking_app/api/data_source/auth_remote_data_source_impl.dart';
import 'package:elevate_tracking_app/api/mapper/auth/forget_password/forget_password_mapper.dart';
import 'package:elevate_tracking_app/api/models/requests/auth/forget_password/email_verification_request.dart';
import 'package:elevate_tracking_app/api/models/requests/auth/forget_password/forget_password_request.dart';
import 'package:elevate_tracking_app/api/models/requests/auth/forget_password/reset_password_request.dart';
import 'package:elevate_tracking_app/api/models/responses/auth/forget_password/email_verification_response.dart';
import 'package:elevate_tracking_app/api/models/responses/auth/forget_password/forget_password_response.dart';
import 'package:elevate_tracking_app/api/models/responses/auth/forget_password/reset_password_response.dart';
import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/domain/entities/email_verification_entity.dart';
import 'package:elevate_tracking_app/domain/entities/forget_password_entity.dart';
import 'package:elevate_tracking_app/domain/entities/requests/email_verification_request_entity.dart';
import 'package:elevate_tracking_app/domain/entities/requests/forget_password_request_entity.dart';
import 'package:elevate_tracking_app/domain/entities/requests/reset_password_request_entity.dart';
import 'package:elevate_tracking_app/domain/entities/reset_password_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  group("test AuthRemoteDataSourceImpl", () {
    late MockApiClient mockApiClient;
    late AuthRemoteDataSourceImpl authRemoteDataSourceImpl;

    setUp(() {
      mockApiClient = MockApiClient();
      authRemoteDataSourceImpl = AuthRemoteDataSourceImpl(mockApiClient);
    });

    group("test forgetPassword", () {
      late ForgetPasswordRequestEntity forgetPasswordRequestEntity;
      late ForgetPasswordRequest forgetPasswordRequest;

      setUp(() {
        forgetPasswordRequestEntity = const ForgetPasswordRequestEntity(
          email: "fake-email",
        );
        forgetPasswordRequest = forgetPasswordRequestEntity.toRequest();
      });

      test(
        "when call forgetPassword it should return ForgetPasswordEntity from Api with correct parameters",
            () async {
          //Arrange
          final expectedResult = ForgetPasswordResponse(
            message: "fake-message",
            info: "fake-info",
          );
          when(
            mockApiClient.forgetPassword(forgetPasswordRequest),
          ).thenAnswer((_) async => expectedResult);
          //Act
          final result = await authRemoteDataSourceImpl.forgetPassword(
            forgetPasswordRequestEntity,
          );
          //Assert
          verify(mockApiClient.forgetPassword(forgetPasswordRequest)).called(1);
          expect(result, isA<ApiSuccessResult<ForgetPasswordEntity>>());
          result as ApiSuccessResult<ForgetPasswordEntity>;
          expect(
            result.data.message,
            equals(expectedResult.toEntity().message),
          );
          expect(result.data.info, equals(expectedResult.toEntity().info));
        },
      );

      test(
        "when forgetPassword failed it should return an error result",
            () async {
          //Arrange
          final expectedError = "Server Error";
          when(
            mockApiClient.forgetPassword(forgetPasswordRequest),
          ).thenThrow(Exception(expectedError));
          //Act
          final result = await authRemoteDataSourceImpl.forgetPassword(
            forgetPasswordRequestEntity,
          );
          //Assert
          verify(mockApiClient.forgetPassword(forgetPasswordRequest)).called(1);
          expect(result, isA<ApiErrorResult<ForgetPasswordEntity>>());
          result as ApiErrorResult<ForgetPasswordEntity>;
          expect(result.errorMessage, contains(expectedError));
        },
      );
    });

    group("test emailVerification", () {
      late EmailVerificationRequestEntity emailVerificationRequestEntity;
      late EmailVerificationRequest emailVerificationRequest;

      setUp(() {
        emailVerificationRequestEntity = const EmailVerificationRequestEntity(
          resetCode: "fake-reset-code",
        );
        emailVerificationRequest = emailVerificationRequestEntity.toRequest();
      });

      test(
        "when call emailVerification it should return EmailVerificationEntity from Api with correct parameters",
            () async {
          //Arrange
          final expectedResult = EmailVerificationResponse(status: "fake-status");
          when(
            mockApiClient.emailVerification(emailVerificationRequest),
          ).thenAnswer((_) async => expectedResult);
          //Act
          final result = await authRemoteDataSourceImpl.emailVerification(
            emailVerificationRequestEntity,
          );
          //Assert
          verify(mockApiClient.emailVerification(emailVerificationRequest)).called(1);
          expect(result, isA<ApiSuccessResult<EmailVerificationEntity>>());
          result as ApiSuccessResult<EmailVerificationEntity>;
          expect(result.data.status, equals(expectedResult.toEntity().status));
        },
      );

      test(
        "when emailVerification failed it should return an error result",
            () async {
          //Arrange
          final expectedError = "Server Error";
          when(
            mockApiClient.emailVerification(emailVerificationRequest),
          ).thenThrow(Exception(expectedError));
          //Act
          final result = await authRemoteDataSourceImpl.emailVerification(
            emailVerificationRequestEntity,
          );
          //Assert
          verify(mockApiClient.emailVerification(emailVerificationRequest)).called(1);
          expect(result, isA<ApiErrorResult<EmailVerificationEntity>>());
          result as ApiErrorResult<EmailVerificationEntity>;
          expect(result.errorMessage, contains(expectedError));
        },
      );
    });

    group("test resetPassword", () {
      late ResetPasswordRequestEntity resetPasswordRequestEntity;
      late ResetPasswordRequest resetPasswordRequest;

      setUp(() {
        resetPasswordRequestEntity = const ResetPasswordRequestEntity(
          email: "fake-email",
          newPassword: "fake-new-password",
        );
        resetPasswordRequest = resetPasswordRequestEntity.toRequest();
      });

      test(
        "when call resetPassword it should return ResetPasswordEntity from Api with correct parameters",
            () async {
          //Arrange
          final expectedResult = ResetPasswordResponse(
            message: "fake-message",
            token: "fake-token",
          );
          when(
            mockApiClient.resetPassword(resetPasswordRequest),
          ).thenAnswer((_) async => expectedResult);
          //Act
          final result = await authRemoteDataSourceImpl.resetPassword(
            resetPasswordRequestEntity,
          );
          //Assert
          verify(mockApiClient.resetPassword(resetPasswordRequest)).called(1);
          expect(result, isA<ApiSuccessResult<ResetPasswordEntity>>());
          result as ApiSuccessResult<ResetPasswordEntity>;
          expect(
            result.data.message,
            equals(expectedResult.toEntity().message),
          );
        },
      );

      test(
        "when resetPassword failed it should return an error result",
            () async {
          //Arrange
          final expectedError = "Server Error";
          when(
            mockApiClient.resetPassword(resetPasswordRequest),
          ).thenThrow(Exception(expectedError));
          //Act
          final result = await authRemoteDataSourceImpl.resetPassword(
            resetPasswordRequestEntity,
          );
          //Assert
          verify(mockApiClient.resetPassword(resetPasswordRequest)).called(1);
          expect(result, isA<ApiErrorResult<ResetPasswordEntity>>());
          result as ApiErrorResult<ResetPasswordEntity>;
          expect(result.errorMessage, contains(expectedError));
        },
      );
    });
  });
}