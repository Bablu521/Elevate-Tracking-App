

import 'package:elevate_tracking_app/api/client/api_client.dart';
import 'package:elevate_tracking_app/api/data_source/auth_remote_data_source_impl.dart';
import 'package:elevate_tracking_app/api/models/email_verification_dto.dart';
import 'package:elevate_tracking_app/api/models/email_verification_request_dto.dart';
import 'package:elevate_tracking_app/api/models/forget_password_request.dart';
import 'package:elevate_tracking_app/api/models/forget_password_response.dart';
import 'package:elevate_tracking_app/api/models/reset_password_request_dto.dart';
import 'package:elevate_tracking_app/api/models/reset_password_response_dto.dart';
import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/domain/entites/email_verification_entity.dart';
import 'package:elevate_tracking_app/domain/entites/email_verification_request_entity.dart';
import 'package:elevate_tracking_app/domain/entites/forget_password_request_entity.dart';
import 'package:elevate_tracking_app/domain/entites/forget_password_response_entity.dart';
import 'package:elevate_tracking_app/domain/entites/reset_password_request_entity.dart';
import 'package:elevate_tracking_app/domain/entites/reset_password_response_entity.dart';
import 'package:elevate_tracking_app/mapper/auth.dart';
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
      late ForgetPasswordRequestDto forgetPasswordRequest;

      setUp(() {
        forgetPasswordRequestEntity = ForgetPasswordRequestEntity(
          email: "fake-email",
        );
        forgetPasswordRequest = forgetPasswordRequestEntity.fromDomain();
      });

      test(
        "when call forgetPassword it should return ForgetPasswordEntity from Api with correct parameters",
            () async {
          //Arrange
          var expectedResult = ForgetPasswordResponseDto(
            message: "fake-message",
            info: "fake-info",
          );
          when(
            mockApiClient.forgetPassword(forgetPasswordRequest),
          ).thenAnswer((_) async => expectedResult);
          //Act
          var result = await authRemoteDataSourceImpl.forgetPassword(
            forgetPasswordRequestEntity,
          );
          //Assert
          verify(mockApiClient.forgetPassword(forgetPasswordRequest)).called(1);
          expect(result, isA<ApiSuccessResult<ForgetPasswordResponseEntity>>());
          result as ApiSuccessResult<ForgetPasswordResponseEntity>;
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
          var expectedError = "Server Error";
          when(
            mockApiClient.forgetPassword(forgetPasswordRequest),
          ).thenThrow(Exception(expectedError));
          //Act
          var result = await authRemoteDataSourceImpl.forgetPassword(
            forgetPasswordRequestEntity,
          );
          //Assert
          verify(mockApiClient.forgetPassword(forgetPasswordRequest)).called(1);
          expect(result, isA<ApiErrorResult<ForgetPasswordResponseEntity>>());
          result as ApiErrorResult<ForgetPasswordResponseEntity>;
          expect(result.errorMessage, contains(expectedError));
        },
      );
    });

    group("test verifyResetCode", () {
      late EmailVerificationRequestEntity verifyResetRequestEntity;
      late EmailVerificationRequestDto verifyResetRequest;

      setUp(() {
        verifyResetRequestEntity = EmailVerificationRequestEntity(
          resetCode: "fake-reset-code",
        );
        verifyResetRequest = verifyResetRequestEntity.fromDomain();
      });

      test(
        "when call verifyResetCode it should return VerifyResetEntity from Api with correct parameters",
            () async {
          //Arrange
          var expectedResult = EmailVerificationDto(status: "fake-status");
          when(
            mockApiClient.emailVerification(verifyResetRequest),
          ).thenAnswer((_) async => expectedResult);
          //Act
          var result = await authRemoteDataSourceImpl.verifyResetCode(
            verifyResetRequestEntity,
          );
          //Assert
          verify(mockApiClient.emailVerification(verifyResetRequest)).called(1);
          expect(result, isA<ApiSuccessResult<EmailVerificationEntity>>());
          result as ApiSuccessResult<EmailVerificationEntity>;
          expect(result.data.status, equals(expectedResult.toEntity().status));
        },
      );

      test(
        "when verifyResetCode failed it should return an error result",
            () async {
          //Arrange
          var expectedError = "Server Error";
          when(
            mockApiClient.emailVerification(verifyResetRequest),
          ).thenThrow(Exception(expectedError));
          //Act
          var result = await authRemoteDataSourceImpl.verifyResetCode(
            verifyResetRequestEntity,
          );
          //Assert
          verify(mockApiClient.emailVerification(verifyResetRequest)).called(1);
          expect(result, isA<ApiErrorResult<EmailVerificationEntity>>());
          result as ApiErrorResult<EmailVerificationEntity>;
          expect(result.errorMessage, contains(expectedError));
        },
      );
    });

    group("test resetPassword", () {
      late ResetPasswordRequestEntity resetPasswordRequestEntity;
      late ResetPasswordRequestDto resetPasswordRequest;

      setUp(() {
        resetPasswordRequestEntity = ResetPasswordRequestEntity(
          email: "fake-email",
          newPassword: "fake-new-password",
        );
        resetPasswordRequest = resetPasswordRequestEntity.fromDomain();
      });

      test(
        "when call resetPassword it should return ResetPasswordEntity from Api with correct parameters",
            () async {
          //Arrange
          var expectedResult = ResetPasswordResponseDto(
            message: "fake-message",
            token: "fake-token",
          );
          when(
            mockApiClient.resetPassword(resetPasswordRequest),
          ).thenAnswer((_) async => expectedResult);
          //Act
          var result = await authRemoteDataSourceImpl.resetPassword(
            resetPasswordRequestEntity,
          );
          //Assert
          verify(mockApiClient.resetPassword(resetPasswordRequest)).called(1);
          expect(result, isA<ApiSuccessResult<ResetPasswordResponseEntity>>());
          result as ApiSuccessResult<ResetPasswordResponseEntity>;
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
          var expectedError = "Server Error";
          when(
            mockApiClient.resetPassword(resetPasswordRequest),
          ).thenThrow(Exception(expectedError));
          //Act
          var result = await authRemoteDataSourceImpl.resetPassword(
            resetPasswordRequestEntity,
          );
          //Assert
          verify(mockApiClient.resetPassword(resetPasswordRequest)).called(1);
          expect(result, isA<ApiErrorResult<ResetPasswordResponseEntity>>());
          result as ApiErrorResult<ResetPasswordResponseEntity>;
          expect(result.errorMessage, contains(expectedError));
        },
      );
    });
  });
}