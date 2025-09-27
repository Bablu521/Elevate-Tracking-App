import 'package:elevate_tracking_app/api/mapper/auth/forget_password/forget_password_mapper.dart';
import 'package:elevate_tracking_app/api/models/responses/auth/forget_password/email_verification_response.dart';
import 'package:elevate_tracking_app/api/models/responses/auth/forget_password/forget_password_response.dart';
import 'package:elevate_tracking_app/api/models/responses/auth/forget_password/reset_password_response.dart';
import 'package:elevate_tracking_app/domain/entities/requests/email_verification_request_entity.dart';
import 'package:elevate_tracking_app/domain/entities/requests/forget_password_request_entity.dart';
import 'package:elevate_tracking_app/domain/entities/requests/reset_password_request_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("test ForgetPasswordMapper", () {
    test(
      'when call toEntity with null values should return ForgetPasswordEntity with empty values',
          () {
        //Arrange
        final response = ForgetPasswordResponse(message: null, info: null);
        //Act
        final result = response.toEntity();
        //Assert
        expect(result.message, isNull);
        expect(result.info, isNull);
      },
    );

    test(
      'when call toEntity with non-null values should return ForgetPasswordEntity with right values',
          () {
        //Arrange
        final response = ForgetPasswordResponse(
          message: "message",
          info: "info",
        );
        //Act
        final result = response.toEntity();
        //Assert
        expect(result.message, equals(response.message));
        expect(result.info, equals(response.info));
      },
    );

    test(
      'when call toRequest with null values should return ForgetPasswordRequest with empty values',
          () {
        //Arrange
        final response = const ForgetPasswordRequestEntity(email: null);
        //Act
        final result = response.toRequest();
        //Assert
        expect(result.email, isNull);
      },
    );

    test(
      'when call toRequest with non-null values should return ForgetPasswordRequest with right values',
          () {
        //Arrange
        final response = const ForgetPasswordRequestEntity(email: "fake-email");
        //Act
        final result = response.toRequest();
        //Assert
        expect(result.email, equals(response.email));
      },
    );
  });

  group("test ResetPasswordMapper", () {
    test(
      'when call toEntity with null values should return ResetPasswordEntity with empty values',
          () {
        //Arrange
        final response = ResetPasswordResponse(message: null, token: null);
        //Act
        final result = response.toEntity();
        //Assert
        expect(result.message, isNull);
      },
    );

    test(
      'when call toEntity with non-null values should return ResetPasswordEntity with right values',
          () {
        //Arrange
        final response = ResetPasswordResponse(
          message: "message",
          token: "token",
        );
        //Act
        final result = response.toEntity();
        //Assert
        expect(result.message, equals(response.message));
      },
    );

    test(
      'when call toRequest with null values should return ResetPasswordRequest with empty values',
          () {
        //Arrange
        final response = const ResetPasswordRequestEntity(
          email: null,
          newPassword: null,
        );
        //Act
        final result = response.toRequest();
        //Assert
        expect(result.email, isNull);
        expect(result.newPassword, isNull);
      },
    );

    test(
      'when call toRequest with non-null values should return ResetPasswordRequest with right values',
          () {
        //Arrange
        final response = const ResetPasswordRequestEntity(
          email: "fake-email",
          newPassword: "fake-password",
        );
        //Act
        final result = response.toRequest();
        //Assert
        expect(result.email, equals(response.email));
        expect(result.newPassword, equals(response.newPassword));
      },
    );
  });

  group("test EmailVerificationMapper", () {
    test(
      'when call toEntity with null values should return EmailVerificationEntity with empty values',
          () {
        //Arrange
        final response = EmailVerificationResponse(status: null);
        //Act
        final result = response.toEntity();
        //Assert
        expect(result.status, isNull);
      },
    );

    test(
      'when call toEntity with non-null values should return EmailVerificationEntity with right values',
          () {
        //Arrange
        final response = EmailVerificationResponse(status: "status");
        //Act
        final result = response.toEntity();
        //Assert
        expect(result.status, equals(response.status));
      },
    );

    test(
      'when call toRequest with null values should return EmailVerificationRequest with empty values',
          () {
        //Arrange
        final response = const EmailVerificationRequestEntity(resetCode: null);
        //Act
        final result = response.toRequest();
        //Assert
        expect(result.resetCode, isNull);
      },
    );

    test(
      'when call toRequest with non-null values should return EmailVerificationRequest with right values',
          () {
        //Arrange
        final response = const EmailVerificationRequestEntity(resetCode: "fake-reset-code");
        //Act
        final result = response.toRequest();
        //Assert
        expect(result.resetCode, equals(response.resetCode));
      },
    );
  });
}