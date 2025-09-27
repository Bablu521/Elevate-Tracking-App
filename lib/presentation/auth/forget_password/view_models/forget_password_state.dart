import 'package:elevate_tracking_app/domain/entities/email_verification_entity.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/forget_password_entity.dart';
import '../../../../domain/entities/reset_password_entity.dart';

class ForgetPasswordState extends Equatable {
  final bool isLoading;
  final ForgetPasswordEntity? forgetPasswordResponse;
  final EmailVerificationEntity? emailVerificationResponse;
  final ResetPasswordEntity? resetPasswordResponse;
  final String? errorMessage;
  final int pageNumber;
  final bool isSuccess;
  final bool validateResetCode;

  const ForgetPasswordState({
    this.isLoading = false,
    this.forgetPasswordResponse,
    this.emailVerificationResponse,
    this.resetPasswordResponse,
    this.errorMessage,
    this.pageNumber = 0,
    this.isSuccess = false,
    this.validateResetCode = false,
  });

  ForgetPasswordState copyWith({
    bool? isLoading,
    ForgetPasswordEntity? forgetPasswordResponse,
    EmailVerificationEntity? emailVerificationResponse,
    ResetPasswordEntity? resetPasswordResponse,
    String? errorMessage,
    int? pageNumber,
    bool? isSuccess,
    bool? validateResetCode,
  }) {
    return ForgetPasswordState(
      isLoading: isLoading ?? this.isLoading,
      forgetPasswordResponse:
          forgetPasswordResponse ?? this.forgetPasswordResponse,
      emailVerificationResponse:
          emailVerificationResponse ?? this.emailVerificationResponse,
      resetPasswordResponse:
          resetPasswordResponse ?? this.resetPasswordResponse,
      errorMessage: errorMessage,
      pageNumber: pageNumber ?? this.pageNumber,
      isSuccess: isSuccess ?? this.isSuccess,
      validateResetCode: validateResetCode ?? this.validateResetCode,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    forgetPasswordResponse,
    emailVerificationResponse,
    resetPasswordResponse,
    errorMessage,
    pageNumber,
    isSuccess,
    validateResetCode,
  ];
}
