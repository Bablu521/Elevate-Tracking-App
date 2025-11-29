import '../../../../domain/entites/response/change_password_response_entity.dart';
import 'package:equatable/equatable.dart';

// enum ChangePasswordStatus { initial, loading, success, error }
//
// class ChangePasswordStates extends Equatable {
//   final bool isLoading;
//   final ChangePasswordResponseEntity? changePasswordResponseEntity;
//   final String? errorMessage;
//   final bool isSuccess;
//   final bool isButtonEnabled;
//
//   const ChangePasswordStates({
//     this.isLoading = false,
//    this.changePasswordResponseEntity,
//     this.errorMessage,
//     this.isSuccess = false,
//     this.isButtonEnabled = false,
//
//   });
//
//   ChangePasswordStates copyWith({
//     bool? isLoading,
//     ChangePasswordResponseEntity? changePasswordResponseEntity,
//     String? errorMessage,
//     bool? isSuccess,
//     bool? isButtonEnabled,
//   })
//
//   {
//     return ChangePasswordStates(
//       isLoading: isLoading ?? this.isLoading,
//       changePasswordResponseEntity: changePasswordResponseEntity ?? this.changePasswordResponseEntity,
//       errorMessage: errorMessage ?? this.errorMessage,
//       isSuccess: isSuccess ?? this.isSuccess,
//       isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
//     );
//   }
//
//   @override
//   List<Object?> get props => [
//     isLoading,
//     changePasswordResponseEntity,
//     errorMessage,
//     isSuccess,
//     isButtonEnabled,
//   ];
// }
import 'package:equatable/equatable.dart';
import '../../../../domain/entites/response/change_password_response_entity.dart';

enum ChangePasswordStatus { initial, loading, success, error }

class ChangePasswordStates extends Equatable {
  final ChangePasswordStatus status;
  final ChangePasswordResponseEntity? changePasswordResponseEntity;
  final String? errorMessage;
  final bool isButtonEnabled;

  const ChangePasswordStates({
    this.status = ChangePasswordStatus.initial,
    this.changePasswordResponseEntity,
    this.errorMessage,
    this.isButtonEnabled = false,
  });

  ChangePasswordStates copyWith({
    ChangePasswordStatus? status,
    ChangePasswordResponseEntity? changePasswordResponseEntity,
    String? errorMessage,
    bool? isButtonEnabled,
  }) {
    return ChangePasswordStates(
      status: status ?? this.status,
      changePasswordResponseEntity:
      changePasswordResponseEntity ?? this.changePasswordResponseEntity,
      errorMessage: errorMessage,
      isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
    );
  }

  @override
  List<Object?> get props => [
    status,
    changePasswordResponseEntity,
    errorMessage,
    isButtonEnabled,
  ];
}
