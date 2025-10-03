import '../../../../domain/entites/response/change_password_response_entity.dart';
import 'package:equatable/equatable.dart';

class ChangePasswordStates extends Equatable {
  final bool isLoading;
  final ChangePasswordResponseEntity? changePasswordResponseEntity;
  final String? errorMessage;
  final bool isSuccess;
  final bool isButtonEnabled;

  const ChangePasswordStates({
    this.isLoading = false,
   this.changePasswordResponseEntity,
    this.errorMessage,
    this.isSuccess = false,
    this.isButtonEnabled = false,

  });

  ChangePasswordStates copyWith({
    bool? isLoading,
    ChangePasswordResponseEntity? changePasswordResponseEntity,
    String? errorMessage,
    bool? isSuccess,
    bool? isButtonEnabled,
  })

  {
    return ChangePasswordStates(
      isLoading: isLoading ?? this.isLoading,
      changePasswordResponseEntity: changePasswordResponseEntity ?? this.changePasswordResponseEntity,
      errorMessage: errorMessage ?? this.errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
      isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    changePasswordResponseEntity,
    errorMessage,
    isSuccess,
    isButtonEnabled,
  ];
}
