import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/domain/entities/forget_password_entity.dart';
import 'package:elevate_tracking_app/domain/entities/requests/forget_password_request_entity.dart';
import 'package:elevate_tracking_app/domain/repo/auth_repo.dart';
import 'package:elevate_tracking_app/domain/use_cases/forget_password_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'forget_password_use_case_test.mocks.dart';

@GenerateMocks([AuthRepo])
void main() {
  group('test ForgetPasswordUseCase', () {
    late MockAuthRepo mockAuthRepo;
    late ForgetPasswordUseCase forgetPasswordUseCase;
    late ForgetPasswordRequestEntity forgetPasswordRequestEntity;

    setUp((){
      mockAuthRepo = MockAuthRepo();
      forgetPasswordUseCase = ForgetPasswordUseCase(mockAuthRepo);
      forgetPasswordRequestEntity =const  ForgetPasswordRequestEntity(
        email: "fake-email",
      );
    });

    test("when call ForgetPasswordUseCase it should return ForgetPasswordEntity from repo with correct parameters", () async {
      //Arrange
      final expectedEntity = ForgetPasswordEntity(
          message: "fake-message",
          info: "fake-info"
      );
      final expectedResult = ApiSuccessResult<ForgetPasswordEntity>(expectedEntity);
      provideDummy<ApiResult<ForgetPasswordEntity>>(expectedResult);
      when(
        mockAuthRepo.forgetPassword(forgetPasswordRequestEntity),
      ).thenAnswer((_) async => expectedResult);

      //Act
      final result = await forgetPasswordUseCase(forgetPasswordRequestEntity);

      //Assert
      verify(mockAuthRepo.forgetPassword(forgetPasswordRequestEntity)).called(1);
      expect(result, isA<ApiSuccessResult<ForgetPasswordEntity>>());
      result as ApiSuccessResult<ForgetPasswordEntity>;
      expect(result.data.message, equals(expectedEntity.message));
      expect(result.data.info, equals(expectedEntity.info));
    });

    test(
      'when ForgetPasswordUseCase failed it should return an error result',
          () async {
        //Arrange
        final expectedError = "Server Error";
        final expectedResult = ApiErrorResult<ForgetPasswordEntity>(expectedError);
        provideDummy<ApiResult<ForgetPasswordEntity>>(expectedResult);
        when(
          mockAuthRepo.forgetPassword(forgetPasswordRequestEntity),
        ).thenAnswer((_) async => expectedResult);

        //Act
        final result = await forgetPasswordUseCase(forgetPasswordRequestEntity);

        //Assert
        verify(mockAuthRepo.forgetPassword(forgetPasswordRequestEntity)).called(1);
        expect(result, isA<ApiErrorResult<ForgetPasswordEntity>>());
        result as ApiErrorResult<ForgetPasswordEntity>;
        expect(result.errorMessage, expectedError);
      },
    );
  });
}