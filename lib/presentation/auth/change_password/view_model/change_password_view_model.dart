import 'package:elevate_tracking_app/presentation/auth/change_password/view_model/change_password_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/api_result/api_result.dart';
import '../../../../domain/entites/requests/change_password_request_entity.dart';
import '../../../../domain/entites/response/change_password_response_entity.dart';
import '../../../../domain/use_cases/change_password_use_case.dart';
import 'change_password_states.dart';

@injectable
class ChangePasswordViewModel extends Cubit<ChangePasswordStates> {
  final ChangePasswordUseCase _changePasswordUseCase;

  ChangePasswordViewModel(this._changePasswordUseCase)
    : super(const ChangePasswordStates());

  final GlobalKey<FormState> changePasswordFormKey = GlobalKey<FormState>();
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  void doIntent(ChangePasswordEvents events) {
    switch (events) {
      case ChangePasswordEvent():
        _changePassword();
      case CheckAllFieldsEvent():
        _checkIfAllFieldsFilled();
    }
  }

  void _checkIfAllFieldsFilled() {
    final isFilled =
        currentPasswordController.text.isNotEmpty &&
        newPasswordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty &&
        newPasswordController.text == confirmPasswordController.text;

    // emit(state.copyWith(isButtonEnabled: isFilled));
    emit(state.copyWith(
      isButtonEnabled: isFilled,
      status: state.status,
    ));
  }

  Future<void> _changePassword() async {
    // emit(state.copyWith(isLoading: true));
    emit(state.copyWith(status: ChangePasswordStatus.loading));
    final result = await _changePasswordUseCase(
      ChangePasswordRequestEntity(
        password: currentPasswordController.text,
        newPassword: newPasswordController.text,
      ),
    );
    switch (result) {
      // case ApiSuccessResult<ChangePasswordResponseEntity>():
      //   emit(
      //     state.copyWith(
      //       isLoading: false,
      //       changePasswordResponseEntity: result.data,
      //       isSuccess: true,
      //     ),
      //   );
      // case ApiErrorResult<ChangePasswordResponseEntity>():
      //   emit(
      //     state.copyWith(isLoading: false, errorMessage: result.errorMessage),
    case ApiSuccessResult<ChangePasswordResponseEntity>():
    emit(state.copyWith(
    status: ChangePasswordStatus.success,
    changePasswordResponseEntity: result.data,
    ));
    case ApiErrorResult<ChangePasswordResponseEntity>():
    emit(state.copyWith(
    status: ChangePasswordStatus.error,
    errorMessage: result.errorMessage,
    ));

    }
  }

  @override
  Future<void> close() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    return super.close();
  }
}
