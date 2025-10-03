import 'package:elevate_tracking_app/core/custom_widget/test_app_wrapper.dart';
import 'package:elevate_tracking_app/core/di/di.dart';
import 'package:elevate_tracking_app/core/enums/gender_enum.dart';
import 'package:elevate_tracking_app/presentation/profile/view_models/profile_states.dart';
import 'package:elevate_tracking_app/presentation/profile/view_models/profile_view_model.dart';
import 'package:elevate_tracking_app/presentation/profile/views/screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy/profile_info_dummy.dart';
import 'profile_screen_test.mocks.dart';

@GenerateMocks([ProfileViewModel])
void main() {
  group("Profile screen Widget Test", () {
    late MockProfileViewModel mockProfileViewModel;
    late TextEditingController mockFirstNameController;
    late TextEditingController mockLastNameController;
    late TextEditingController mockEmailController;
    late TextEditingController mockPhoneNumberController;
    late GlobalKey<FormState> mockFormKey;
    Gender? mockSelectedGender = Gender.male;
    String? mockInitialFirstName;
    String? mockInitialLastName;
    String? mockInitialEmail;
    String? mockInitialPhone;

    setUpAll(() async {
      mockProfileViewModel = MockProfileViewModel();
      mockFirstNameController = TextEditingController();
      mockFirstNameController = TextEditingController();
      mockLastNameController = TextEditingController();
      mockEmailController = TextEditingController();
      mockPhoneNumberController = TextEditingController();
      mockFormKey = GlobalKey<FormState>();

      configureDependencies();

      await getIt.unregister<ProfileViewModel>();
      getIt.registerSingleton<ProfileViewModel>(mockProfileViewModel);

      when(
        mockProfileViewModel.firstNameController,
      ).thenReturn(mockFirstNameController);
      when(
        mockProfileViewModel.lastNameController,
      ).thenReturn(mockLastNameController);
      when(
        mockProfileViewModel.emailController,
      ).thenReturn(mockEmailController);
      when(
        mockProfileViewModel.phoneNumberController,
      ).thenReturn(mockPhoneNumberController);
      when(mockProfileViewModel.formKey).thenReturn(mockFormKey);
      when(mockProfileViewModel.selectedGender).thenReturn(mockSelectedGender);
      when(
        mockProfileViewModel.initialFirstName,
      ).thenReturn(mockInitialFirstName);
      when(
        mockProfileViewModel.initialLastName,
      ).thenReturn(mockInitialLastName);
      when(mockProfileViewModel.initialEmail).thenReturn(mockInitialEmail);
      when(mockProfileViewModel.initialPhone).thenReturn(mockInitialPhone);
    });

    testWidgets('Verify Structure', (WidgetTester tester) async {
      final expectedEntity = ProfileInfoDummy.dummyDriverEntityFake;
      final expectedVehicleEntity = ProfileInfoDummy.dummyVehicleEntityFake;

      mockInitialFirstName = expectedEntity.firstName;
      mockInitialLastName = expectedEntity.lastName;
      mockInitialEmail = expectedEntity.email;
      mockInitialPhone = expectedEntity.phone;
      mockFirstNameController.text = expectedEntity.firstName!;
      mockLastNameController.text = expectedEntity.lastName!;
      mockEmailController.text = expectedEntity.email!;
      mockPhoneNumberController.text = expectedEntity.phone!;
      mockSelectedGender = genderFromString(expectedEntity.gender!);

      final state = ProfileStates(
        isLoading: false,
        driverData: expectedEntity,
        isFormChanged: false,
        vehicleData: expectedVehicleEntity,
      );

      when(mockProfileViewModel.state).thenReturn(state);

      when(
        mockProfileViewModel.stream,
      ).thenAnswer((_) => Stream.fromIterable([state]));

      //Arrange
      await tester.pumpWidget(TestAppWrapper(child: ProfileScreen()));

      await tester.pumpAndSettle();
      //Assert
      expect(find.byType(AppBar), findsOneWidget);
      //Act
    });
  });
}
