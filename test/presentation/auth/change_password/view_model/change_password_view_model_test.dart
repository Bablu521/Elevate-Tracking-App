import 'package:bloc_test/bloc_test.dart';
import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/domain/entites/response/change_password_response_entity.dart';
import 'package:elevate_tracking_app/domain/use_cases/change_password_use_case.dart';
import 'package:elevate_tracking_app/presentation/auth/change_password/view_model/change_password_event.dart';
import 'package:elevate_tracking_app/presentation/auth/change_password/view_model/change_password_states.dart';
import 'package:elevate_tracking_app/presentation/auth/change_password/view_model/change_password_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../../../dummy/change_password_dummy_data.dart';
import 'change_password_view_model_test.mocks.dart';


@GenerateMocks([ChangePasswordUseCase])
void main() {
  group("change password view model", () {
    late MockChangePasswordUseCase mockChangePasswordUseCase;
    late ChangePasswordStates changePasswordStates;
    late ChangePasswordViewModel changePasswordViewModel;

    setUp(() {
      mockChangePasswordUseCase = MockChangePasswordUseCase();
      changePasswordViewModel = ChangePasswordViewModel(mockChangePasswordUseCase);
      changePasswordStates = const ChangePasswordStates();
    });

    final changePasswordEntity = ChangePasswordDummyData().fakeChangePasswordResponseEntity;
    final changePasswordRequestEntity = ChangePasswordDummyData().fakeChangePasswordRequestEntity;
    final expectedResult = ApiSuccessResult<ChangePasswordResponseEntity>(changePasswordEntity);

    provideDummy<ApiResult<ChangePasswordResponseEntity>>(expectedResult);

    blocTest<ChangePasswordViewModel, ChangePasswordStates>(
      "when success should emit loading then success state",
      build: () => changePasswordViewModel,
      act: (bloc) {
        when(mockChangePasswordUseCase(any)).thenAnswer((_) async => expectedResult);
        bloc.newPasswordController.text = changePasswordRequestEntity.newPassword!;
        bloc.currentPasswordController.text = changePasswordRequestEntity.password!;
        return bloc.doIntent(ChangePasswordEvent());
      },
      expect: () => [
        changePasswordStates.copyWith(status: ChangePasswordStatus.loading),
        changePasswordStates.copyWith(
          status: ChangePasswordStatus.success,
          changePasswordResponseEntity: changePasswordEntity,
          errorMessage: null,
          isButtonEnabled: false,
        ),
      ],
      verify: (_) => verify(mockChangePasswordUseCase(any)).called(1),
    );

    final expectedError = "fake_error";
    final expectedErrorResult = ApiErrorResult<ChangePasswordResponseEntity>(expectedError);

    provideDummy<ApiResult<ChangePasswordResponseEntity>>(expectedErrorResult);

    blocTest<ChangePasswordViewModel, ChangePasswordStates>(
      "when error → should emit loading then error state",
      build: () => changePasswordViewModel,
      act: (bloc) {
        when(mockChangePasswordUseCase(any)).thenAnswer((_) async => expectedErrorResult);
        bloc.newPasswordController.text = changePasswordRequestEntity.newPassword!;
        bloc.currentPasswordController.text = changePasswordRequestEntity.password!;
        return bloc.doIntent(ChangePasswordEvent());
      },
      expect: () => [
        changePasswordStates.copyWith(status: ChangePasswordStatus.loading),
        changePasswordStates.copyWith(
          status: ChangePasswordStatus.error,
          errorMessage: expectedError,
          changePasswordResponseEntity: null,
          isButtonEnabled: false,
        ),
      ],
      verify: (_) => verify(mockChangePasswordUseCase(any)).called(1),
    );

    blocTest<ChangePasswordViewModel, ChangePasswordStates>(
      "should emit isButtonEnabled true when all fields are valid and match",
      build: () => changePasswordViewModel,
      act: (bloc) {
        bloc.currentPasswordController.text = "old123";
        bloc.newPasswordController.text = "new123";
        bloc.confirmPasswordController.text = "new123";
        bloc.doIntent(CheckAllFieldsEvent());
      },
      expect: () => [
        changePasswordStates.copyWith(isButtonEnabled: true),
      ],
    );

    blocTest<ChangePasswordViewModel, ChangePasswordStates>(
      "should emit isButtonEnabled false when passwords do not match",
      build: () => changePasswordViewModel,
      act: (bloc) {
        bloc.currentPasswordController.text = "old123";
        bloc.newPasswordController.text = "new123";
        bloc.confirmPasswordController.text = "different";
        bloc.doIntent(CheckAllFieldsEvent());
      },
      expect: () => [
        changePasswordStates.copyWith(isButtonEnabled: false),
      ],
    );
  });
}
