// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/api_result/api_result.dart';
import '../../../../domain/entites/email_verification_entity.dart';
import '../../../../domain/entites/email_verification_request_entity.dart';
import '../../../../domain/entites/forget_password_request_entity.dart';
import '../../../../domain/entites/forget_password_response_entity.dart';
import '../../../../domain/entites/reset_password_request_entity.dart';
import '../../../../domain/entites/reset_password_response_entity.dart';
import '../../../../domain/use_case/email_verification_use_case.dart';
import '../../../../domain/use_case/forget_password_use_case.dart';
import '../../../../domain/use_case/reset_passwoed_use_case.dart';
import 'forget_password_event.dart';
import 'forget_password_states.dart';

@injectable
class ForgetPasswordViewModel extends Cubit<ForgetPasswordState> {
  final ForgetPasswordUseCase _forgetPasswordUseCase;
final EmailVerificationUseCase _emailVerificationUseCase;
final ResetPasswordUseCase _resetPasswordUseCase;


  ForgetPasswordViewModel(
      this._forgetPasswordUseCase,
      this._emailVerificationUseCase,
      this._resetPasswordUseCase
      ) : super(const ForgetPasswordState());

  final GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
   final GlobalKey<FormState> verifyResetCodeFormKey = GlobalKey<FormState>();
  final TextEditingController resetCodeController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final GlobalKey<FormState> resetPasswordFormKey = GlobalKey<FormState>();




  void doIntent(ForgetPasswordEvents events) {
    switch (events) {
      case ForgetPasswordEvent():
        _forgetPassword();
      case VerifyResetCodeEvent():
        _verifyResetCode();
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
      case ApiSuccessResult<ForgetPasswordResponseEntity>():
        emit(
          state.copyWith(
            isLoading: false,
            forgetPasswordResponse: result.data,
            pageNumber: 1,
          ),
        );
      case ApiErrorResult<ForgetPasswordResponseEntity>():
        emit(
          state.copyWith(isLoading: false, errorMessage: result.errorMessage),
        );
    }
  }

  Future<void> _verifyResetCode() async {
    emit(state.copyWith(isLoading: true));
    final result = await _emailVerificationUseCase(
      EmailVerificationRequestEntity(resetCode: resetCodeController.text),
    );
    switch (result) {
      case ApiSuccessResult< EmailVerificationEntity>():
        emit(
          state.copyWith(
            isLoading: false,
            emailVerificationEntity: result.data,
            pageNumber: 2,
          ),
        );
      case ApiErrorResult< EmailVerificationEntity>():
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
      case ApiSuccessResult<ResetPasswordResponseEntity>():
        emit(
          state.copyWith(
            isLoading: false,
            resetPasswordResponse: result.data,
            isSuccess: true,
          ),
        );
      case ApiErrorResult<ResetPasswordResponseEntity>():
        emit(
          state.copyWith(isLoading: false, errorMessage: result.errorMessage),
        );
    }
  }


  // @override
  // Future<void> close() {
  //   emailController.dispose();
  //   newPasswordController.dispose();
  //   confirmPasswordController.dispose();
  //   return super.close();
  // }
}