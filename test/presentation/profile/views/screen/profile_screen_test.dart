import 'package:elevate_tracking_app/core/custom_widget/test_app_wrapper.dart';
import 'package:elevate_tracking_app/core/di/di.dart';
import 'package:elevate_tracking_app/presentation/profile/view_models/profile_view_model.dart';
import 'package:elevate_tracking_app/presentation/profile/views/screen/profile_screen.dart';
import 'package:elevate_tracking_app/domain/use_cases/edit_profile_use_case.dart';
import 'package:elevate_tracking_app/domain/use_cases/get_logged_driver_data_use_case.dart';
import 'package:elevate_tracking_app/domain/use_cases/get_vehicle_use_case.dart';
import 'package:elevate_tracking_app/domain/use_cases/logout_use_case.dart';
import 'package:elevate_tracking_app/domain/use_cases/upload_profile_photo_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'profile_screen_test.mocks.dart';


@GenerateMocks([GetLoggedDriverDataUseCase, EditProfileUseCase, GetVehicleUseCase, UploadProfilePhotoUseCase, LogoutUseCase])
void main() {
  group("Profile screen Widget Test", () {
    setUpAll(() {
      configureDependencies();
    });
     final viewModel = ProfileViewModel(
      MockGetLoggedDriverDataUseCase(),
      MockEditProfileUseCase(),
      MockGetVehicleUseCase(),
      MockUploadProfilePhotoUseCase(),
      MockLogoutUseCase(),
    );

    testWidgets('Verify Structure', (WidgetTester tester) async {
      //Arrange
      await tester.pumpWidget(TestAppWrapper(child: ProfileScreen()));
      //Assert
      expect(find.byType(AppBar), findsOneWidget);
      //Act
    });
  });
}

