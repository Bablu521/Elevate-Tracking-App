import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/api_result/api_result.dart';
import '../../../../domain/entities/email_verification_entity.dart';
import '../../../../domain/entities/forget_password_entity.dart';
import '../../../../domain/entities/requests/email_verification_request_entity.dart';
import '../../../../domain/entities/requests/forget_password_request_entity.dart';
import '../../../../domain/entities/requests/reset_password_request_entity.dart';
import '../../../../domain/entities/reset_password_entity.dart';
import '../../../../domain/use_cases/email_verification_use_case.dart';
import '../../../../domain/use_cases/forget_password_use_case.dart';
import '../../../../domain/use_cases/reset_password_use_case.dart';
import 'forget_password_events.dart';
import 'forget_password_state.dart';

@injectable
class ForgetPasswordViewModel extends Cubit<ForgetPasswordState> {
  final ForgetPasswordUseCase _forgetPasswordUseCase;
  final EmailVerificationUseCase _emailVerificationUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;

  ForgetPasswordViewModel(
    this._forgetPasswordUseCase,
    this._emailVerificationUseCase,
    this._resetPasswordUseCase,
  ) : super(const ForgetPasswordState());

  final GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> emailVerificationFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> resetPasswordFormKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController resetCodeController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  void doIntent(ForgetPasswordEvents events) {
    switch (events) {
      case ForgetPasswordEvent():
        _forgetPassword();
      case EmailVerificationEvent():
        _emailVerification();
      case ResetPasswordEvent():
        _resetPassword();
    }
  }

  Future<void> _forgetPassword() async {
    emit(state.copyWith(isLoading: true));
    final result = await _forgetPasswordUseCase(
      ForgetPasswordRequestEntity(email: emailController.text),
    );
    switch (result) {
      case ApiSuccessResult<ForgetPasswordEntity>():
        emit(
          state.copyWith(
            isLoading: false,
            forgetPasswordResponse: result.data,
            pageNumber: 1,
          ),
        );
      case ApiErrorResult<ForgetPasswordEntity>():
        emit(
          state.copyWith(isLoading: false, errorMessage: result.errorMessage),
        );
    }
  }

  Future<void> _emailVerification() async {
    emit(state.copyWith(isLoading: true));
    final result = await _emailVerificationUseCase(
      EmailVerificationRequestEntity(resetCode: resetCodeController.text),
    );
    switch (result) {
      case ApiSuccessResult<EmailVerificationEntity>():
        emit(
          state.copyWith(
            isLoading: false,
            emailVerificationResponse: result.data,
            pageNumber: 2,
          ),
        );
      case ApiErrorResult<EmailVerificationEntity>():
        emit(state.copyWith(isLoading: false, validateResetCode: true));
    }
  }

  Future<void> _resetPassword() async {
    emit(state.copyWith(isLoading: true));
    final result = await _resetPasswordUseCase(
      ResetPasswordRequestEntity(
        email: emailController.text,
        newPassword: newPasswordController.text,
      ),
    );
    switch (result) {
      case ApiSuccessResult<ResetPasswordEntity>():
        emit(
          state.copyWith(
            isLoading: false,
            resetPasswordResponse: result.data,
            isSuccess: true,
          ),
        );
      case ApiErrorResult<ResetPasswordEntity>():
        emit(
          state.copyWith(isLoading: false, errorMessage: result.errorMessage),
        );
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
