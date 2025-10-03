import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/core/custom_widget/test_app_wrapper.dart';
import 'package:elevate_tracking_app/core/di/di.dart';
import 'package:elevate_tracking_app/domain/entites/driver_entity.dart';
import 'package:elevate_tracking_app/domain/entites/vehicle_entity.dart';
import 'package:elevate_tracking_app/presentation/profile/views/screen/profile_screen.dart';
import 'package:elevate_tracking_app/domain/use_cases/edit_profile_use_case.dart';
import 'package:elevate_tracking_app/domain/use_cases/get_logged_driver_data_use_case.dart';
import 'package:elevate_tracking_app/domain/use_cases/get_vehicle_use_case.dart';
import 'package:elevate_tracking_app/domain/use_cases/logout_use_case.dart';
import 'package:elevate_tracking_app/domain/use_cases/upload_profile_photo_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy/profile_info_dummy.dart';
import 'profile_screen_test.mocks.dart';

@GenerateMocks([
  GetLoggedDriverDataUseCase,
  EditProfileUseCase,
  GetVehicleUseCase,
  UploadProfilePhotoUseCase,
  LogoutUseCase,
])
void main() {
  group("Profile screen Widget Test", () {
    final MockGetLoggedDriverDataUseCase mockGetLoggedDriverDataUseCase =
        MockGetLoggedDriverDataUseCase();
    final MockEditProfileUseCase mockEditProfileUseCase =
        MockEditProfileUseCase();
    final MockGetVehicleUseCase mockGetVehicleUseCase = MockGetVehicleUseCase();
    final MockUploadProfilePhotoUseCase mockUploadProfilePhotoUseCase =
        MockUploadProfilePhotoUseCase();
    final MockLogoutUseCase mockLogoutUseCase = MockLogoutUseCase();
    setUpAll(() async {
      configureDependencies();
      await getIt.unregister<GetLoggedDriverDataUseCase>();
      getIt.registerSingleton<GetLoggedDriverDataUseCase>(
        mockGetLoggedDriverDataUseCase,
      );
      await getIt.unregister<EditProfileUseCase>();
      getIt.registerSingleton<EditProfileUseCase>(mockEditProfileUseCase);
      await getIt.unregister<GetVehicleUseCase>();
      getIt.registerSingleton<GetVehicleUseCase>(mockGetVehicleUseCase);
      await getIt.unregister<UploadProfilePhotoUseCase>();
      getIt.registerSingleton<UploadProfilePhotoUseCase>(
        mockUploadProfilePhotoUseCase,
      );
      await getIt.unregister<LogoutUseCase>();
      getIt.registerSingleton<LogoutUseCase>(mockLogoutUseCase);
    });

    testWidgets('Verify Structure', (WidgetTester tester) async {
      final expectedEntity = ProfileInfoDummy.dummyDriverEntityFake;
      final expectedResult = ApiSuccessResult<DriverEntity>(expectedEntity);
      provideDummy<ApiResult<DriverEntity>>(expectedResult);
      when(
        mockGetLoggedDriverDataUseCase.call(),
      ).thenAnswer((_) async => expectedResult);
      final expecteVehicledEntity = ProfileInfoDummy.dummyVehicleEntityFake;
      final expecteVehicledResult = ApiSuccessResult<VehicleEntity>(expecteVehicledEntity);
      provideDummy<ApiResult<VehicleEntity>>(expecteVehicledResult);
      when(
        mockGetVehicleUseCase.call(expectedEntity.vehicleType),
      ).thenAnswer((_) async => expecteVehicledResult);

      //Arrange
      await tester.pumpWidget(TestAppWrapper(child: ProfileScreen()));
      //Assert
      expect(find.byType(AppBar), findsOneWidget);
      //Act
    });
  });
}
