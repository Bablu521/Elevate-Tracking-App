import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/domain/entites/requests/change_password_request_entity.dart';
import 'package:elevate_tracking_app/domain/entites/response/change_password_response_entity.dart';
import 'package:elevate_tracking_app/domain/repo/auth_repo.dart';
import 'package:elevate_tracking_app/domain/use_cases/change_password_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../dummy/change_password_dummy_data.dart';
import 'login_use_case_test.mocks.dart';

@GenerateMocks([AuthRepo])
void main() {

 group(" test changePassword use case",(){

   late MockAuthRepo mockAuthRepo;
   late ChangePasswordUseCase changePasswordUseCase;

   setUp( (){
      mockAuthRepo = MockAuthRepo();
      changePasswordUseCase =ChangePasswordUseCase(mockAuthRepo);
   });

   test("when call auth repo it should return change password with right data", () async {

    final changePasswordRequest = ChangePasswordRequestEntity(password: "123",newPassword: "1234");

    final expectedEntity=ChangePasswordDummyData().fakeChangePasswordResponseEntity;
    final expectedResult = ApiSuccessResult<ChangePasswordResponseEntity>(expectedEntity );
    provideDummy <ApiResult<ChangePasswordResponseEntity>>(expectedResult);
    when(mockAuthRepo.changePassword(changePasswordRequest)).thenAnswer( (_) async =>expectedResult);

     final result = await changePasswordUseCase(changePasswordRequest);

     verify(mockAuthRepo.changePassword(changePasswordRequest)).called(1);
     expect(result, isA<ApiSuccessResult<ChangePasswordResponseEntity>>());
     result as ApiSuccessResult<ChangePasswordResponseEntity>;
     expect(result.data.token, expectedResult.data.token);
     expect(result.data.message, expectedResult.data.message);

   });

   test("when failed call it should return error data", () async {

    final changePasswordRequest = ChangePasswordRequestEntity(password: "123",newPassword: "1234");

    final expectedError="fake-error";
    final expectedResult = ApiErrorResult<ChangePasswordResponseEntity>(expectedError);
    provideDummy <ApiResult<ChangePasswordResponseEntity>>(expectedResult);
    when(mockAuthRepo.changePassword(changePasswordRequest)).thenAnswer( (_) async => expectedResult);

     final result = await changePasswordUseCase(changePasswordRequest);

     verify(mockAuthRepo.changePassword(changePasswordRequest)).called(1);
     expect(result, isA<ApiErrorResult<ChangePasswordResponseEntity>>());
     result as ApiErrorResult<ChangePasswordResponseEntity>;
     expect(result.errorMessage, expectedResult.errorMessage);
     expect(result.error, expectedResult.error);

   });

 });
}