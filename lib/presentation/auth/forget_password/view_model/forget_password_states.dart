
import 'package:elevate_tracking_app/domain/entites/forget_password_response_entity.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entites/email_verification_entity.dart';
import '../../../../domain/entites/reset_password_response_entity.dart';


class ForgetPasswordState extends Equatable {
 final bool isLoading;
 final ForgetPasswordResponseEntity? forgetPasswordResponse;
 final EmailVerificationEntity? emailVerificationEntity;
 final ResetPasswordResponseEntity? resetPasswordResponse;
 final String? errorMessage;
 final bool isSuccess;
 final bool validateResetCode;

  const ForgetPasswordState({
    this.isLoading = false,
    this.forgetPasswordResponse,
     this.emailVerificationEntity,
    this.resetPasswordResponse,
    this.errorMessage,
    this.isSuccess = false,
    this.validateResetCode = false,
  });

  ForgetPasswordState copyWith({
    bool? isLoading,
    ForgetPasswordResponseEntity? forgetPasswordResponse,
    EmailVerificationEntity? emailVerificationEntity,
    ResetPasswordResponseEntity? resetPasswordResponse,
    String? errorMessage,
    int? pageNumber,
    bool? isSuccess,
    bool? validateResetCode,
  }) {
    return ForgetPasswordState(
      isLoading: isLoading ?? this.isLoading,
      forgetPasswordResponse: forgetPasswordResponse ?? this.forgetPasswordResponse,
      emailVerificationEntity: emailVerificationEntity ?? this.emailVerificationEntity,
      resetPasswordResponse: resetPasswordResponse ?? this.resetPasswordResponse,
      errorMessage: errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
      validateResetCode: validateResetCode ?? this.validateResetCode,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    forgetPasswordResponse,
    emailVerificationEntity,
    resetPasswordResponse,
    errorMessage,
    isSuccess,
    validateResetCode,
  ];
}
