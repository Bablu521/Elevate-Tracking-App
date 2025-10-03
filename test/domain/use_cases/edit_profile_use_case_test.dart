import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/domain/entities/driver_entity.dart';
import 'package:elevate_tracking_app/domain/entities/requests/update_profile_info_request_entity.dart';
import 'package:elevate_tracking_app/domain/repo/auth_repo.dart';
import 'package:elevate_tracking_app/domain/use_cases/edit_profile_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy/profile_info_dummy.dart';
import 'edit_profile_use_case_test.mocks.dart';


@GenerateMocks([AuthRepo])
void main() {
  late MockAuthRepo mockedAuthRepo;
  late EditProfileUseCase editProfileUseCase;
  late UpdateProfileInfoRequestEntity updateProfileInfoRequestEntity;
  setUp(() {
    mockedAuthRepo = MockAuthRepo();
    editProfileUseCase = EditProfileUseCase(mockedAuthRepo);
    updateProfileInfoRequestEntity =
        ProfileInfoDummy.dummyUpdateProfileInfoRequestEntityFake;
  });
    group("test EditProfileUseCase", () {
    test(
      "when call it should return DriverEntity from repo with correct parameters",
      () async {
        //Arrange
        final expectedEntity = ProfileInfoDummy.dummyDriverEntityFake;
        final expectedResult = ApiSuccessResult<DriverEntity>(expectedEntity);

        provideDummy<ApiResult<DriverEntity>>(expectedResult);
        when(
          mockedAuthRepo.editProfile(updateProfileInfoRequestEntity),
        ).thenAnswer((_) async => expectedResult);

        //Act
        final result = await editProfileUseCase.call(updateProfileInfoRequestEntity);

        //Assert
        verify(mockedAuthRepo.editProfile(updateProfileInfoRequestEntity)).called(1);
        expect(result, isA<ApiSuccessResult<DriverEntity>>());
        result as ApiSuccessResult<DriverEntity>;
        expect(result.data, expectedEntity);
      },
    );

    test("when call failed it should return an error result", () async {
      //Arrange
      final expectedError = "Server-Error";
      final expectedResult = ApiErrorResult<DriverEntity>(expectedError);

      provideDummy<ApiResult<DriverEntity>>(expectedResult);
      when(
        mockedAuthRepo.editProfile(updateProfileInfoRequestEntity),
      ).thenAnswer((_) async => expectedResult);

      //Act
      final result = await editProfileUseCase.call(updateProfileInfoRequestEntity);

      //Assert
      verify(mockedAuthRepo.editProfile(updateProfileInfoRequestEntity)).called(1);
      expect(result, isA<ApiErrorResult<DriverEntity>>());
      result as ApiErrorResult<DriverEntity>;
      expect(result.errorMessage, expectedError);
    });
  });
}
