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
  group("change password view model",(){

    late MockChangePasswordUseCase mockChangePasswordUseCase;
    late ChangePasswordStates changePasswordStates;
    late ChangePasswordViewModel changePasswordViewModel;

    setUp((){
      mockChangePasswordUseCase = MockChangePasswordUseCase();
      changePasswordViewModel =ChangePasswordViewModel(mockChangePasswordUseCase );
      changePasswordStates = ChangePasswordStates();
    });
    final  changePasswordEntity = ChangePasswordDummyData().fakeChangePasswordResponseEntity ;
    final  changePasswordRequestEntity = ChangePasswordDummyData().fakeChangePasswordRequestEntity ;
    final expectedResult= ApiSuccessResult<ChangePasswordResponseEntity>(changePasswordEntity);

    provideDummy <ApiResult<ChangePasswordResponseEntity>>(expectedResult);

    blocTest("when emit success state should call change password with valid data ",

        build:()=>changePasswordViewModel,

      act: (bloc) {
      when(mockChangePasswordUseCase(any)).thenAnswer((_) async => expectedResult);
      bloc.newPasswordController.text = changePasswordRequestEntity.newPassword!;
      bloc.currentPasswordController.text = changePasswordRequestEntity.password!;
      return bloc.doIntent(ChangePasswordEvent());

      },
      expect:
      ()=><ChangePasswordStates>[
        changePasswordStates.copyWith(isLoading: true),
        changePasswordStates.copyWith(isLoading: false,changePasswordResponseEntity: changePasswordEntity,
          isButtonEnabled: false,isSuccess: true,errorMessage:null
        )
      ]
      ,
      verify: (_) {
        verify(mockChangePasswordUseCase(any)).called(1);
      },


    );
   final expectedError = "fake_error" ;
   final expectedErrorResult= ApiErrorResult<ChangePasswordResponseEntity>(expectedError);

   provideDummy<ApiResult<ChangePasswordResponseEntity>>(expectedErrorResult);

    blocTest("when emit error state it should call change password fails ",
        build:() =>changePasswordViewModel,

      act: (bloc){
      when(mockChangePasswordUseCase(any)).thenAnswer((_) async =>expectedErrorResult);
      bloc.newPasswordController.text = changePasswordRequestEntity.newPassword!;
      bloc.currentPasswordController.text = changePasswordRequestEntity.password!;
      return bloc.doIntent(ChangePasswordEvent());
      },
        expect:
        ()=><ChangePasswordStates>[
      changePasswordStates.copyWith(isLoading: true),
      changePasswordStates.copyWith(isLoading: false,changePasswordResponseEntity: null,
          isButtonEnabled: false,isSuccess: false,errorMessage:expectedError,

      )
    ],
      verify: (_){
      verify(mockChangePasswordUseCase(any)).called(1);
      }


    );
    blocTest<ChangePasswordViewModel, ChangePasswordStates>(
      "should emit isButtonEnabled true when all fields are filled and passwords match",
      build: () => changePasswordViewModel,
      act: (bloc) {
        bloc.currentPasswordController.text = "old123";
        bloc.newPasswordController.text = "new123";
        bloc.confirmPasswordController.text = "new123";
        bloc.checkIfAllFieldsFilled();
      },
      expect: () => [
        changePasswordStates.copyWith(isButtonEnabled: true),
      ],
    );

    blocTest<ChangePasswordViewModel, ChangePasswordStates>(
      "should emit isButtonEnabled false when fields are empty or passwords do not match",
      build: () => changePasswordViewModel,
      act: (bloc) {
        bloc.currentPasswordController.text = "old123";
        bloc.newPasswordController.text = "new123";
        bloc.confirmPasswordController.text = "different";
        bloc.checkIfAllFieldsFilled();
      },
      expect: () => [
        changePasswordStates.copyWith(isButtonEnabled: false),
      ],
    );


  });
}