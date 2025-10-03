import 'dart:io';
import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/domain/entities/upload_profile_image_response_entity.dart';
import 'package:elevate_tracking_app/domain/repo/auth_repo.dart';
import 'package:elevate_tracking_app/domain/use_cases/upload_profile_photo_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy/profile_info_dummy.dart';
import 'upload_profile_photo_use_case_test.mocks.dart';

@GenerateMocks([AuthRepo])
void main() {
  late MockAuthRepo mockedAuthRepo;
  late UploadProfilePhotoUseCase uploadProfilePhotoUseCase;
  final File file = File('path/to/file');
  setUp(() {
    mockedAuthRepo = MockAuthRepo();
    uploadProfilePhotoUseCase = UploadProfilePhotoUseCase(mockedAuthRepo);
  });
  group("test UploadProfilePhotoUseCase", () {
    test(
      "when call it should return UploadProfileImageResponseEntity from repo with correct parameters",
      () async {
        //Arrange
        final expectedEntity =
            ProfileInfoDummy.dummyUploadProfileImageResponseEntityFake;
        final expectedResult =
            ApiSuccessResult<UploadProfileImageResponseEntity>(expectedEntity);

        provideDummy<ApiResult<UploadProfileImageResponseEntity>>(
          expectedResult,
        );

          when(
          mockedAuthRepo.uploadProfilePhoto(file),
        ).thenAnswer((_) async => expectedResult);

        //Act
        final result = await uploadProfilePhotoUseCase.call(file);

        //Assert
        verify(mockedAuthRepo.uploadProfilePhoto(file)).called(1);
        expect(
          result,
          isA<ApiSuccessResult<UploadProfileImageResponseEntity>>(),
        );
        result as ApiSuccessResult<UploadProfileImageResponseEntity>;
        expect(result.data, expectedEntity);
      },
    );

    test("when call failed it should return an error result", () async {
      //Arrange
      final expectedError = "Server-Error";
      final expectedResult = ApiErrorResult<UploadProfileImageResponseEntity>(
        expectedError,
      );

      provideDummy<ApiResult<UploadProfileImageResponseEntity>>(expectedResult);
      when(
        mockedAuthRepo.uploadProfilePhoto(file),
      ).thenAnswer((_) async => expectedResult);

      //Act
      final result = await uploadProfilePhotoUseCase.call(file);

      //Assert
      verify(mockedAuthRepo.uploadProfilePhoto(file)).called(1);
      expect(result, isA<ApiErrorResult<UploadProfileImageResponseEntity>>());
      result as ApiErrorResult<UploadProfileImageResponseEntity>;
      expect(result.errorMessage, expectedError);
    });
  });
}
