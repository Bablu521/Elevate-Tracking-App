import 'package:elevate_tracking_app/core/constants/widgets_keys.dart';
import 'package:elevate_tracking_app/core/custom_widget/test_app_wrapper.dart';
import 'package:elevate_tracking_app/core/di/di.dart';
import 'package:elevate_tracking_app/core/enums/gender_enum.dart';
import 'package:elevate_tracking_app/presentation/profile/view_models/profile_states.dart';
import 'package:elevate_tracking_app/presentation/profile/view_models/profile_view_model.dart';
import 'package:elevate_tracking_app/presentation/profile/views/screen/edit_profile_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../../../dummy/profile_info_dummy.dart';
import 'edit_profile_info_screen_test.mocks.dart';

@GenerateMocks([ProfileViewModel])
void main() {
  group("Edit Profile Info Screen Widget Test", () {
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

    testWidgets('Verify Edit Profile Info Screen Structure UI', (
      WidgetTester tester,
    ) async {
      //Arrange
      final state = const ProfileStates();

      when(mockProfileViewModel.state).thenReturn(state);

      when(
        mockProfileViewModel.stream,
      ).thenAnswer((_) => Stream.fromIterable([state]));

      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(
          const TestAppWrapper(child: EditProfileInfoScreen()),
        );

        await tester.pumpAndSettle();
        //Assert
        expect(find.byType(AppBar), findsOneWidget);
        expect(find.text("Edit profile"), findsOneWidget);
        expect(find.byType(TextFormField), findsNWidgets(5));
        expect(find.byType(ElevatedButton), findsNWidgets(1));
        expect(find.byType(Text), findsNWidgets(11));
        expect(find.bySemanticsLabel("First name"), findsOneWidget);
        expect(find.bySemanticsLabel("Last name"), findsOneWidget);
        expect(find.bySemanticsLabel("Email"), findsOneWidget);
        expect(find.bySemanticsLabel("Phone number"), findsOneWidget);
        expect(find.bySemanticsLabel("Password"), findsOneWidget);
        expect(find.widgetWithText(ElevatedButton, "Update"), findsOneWidget);
      });
    });

    testWidgets('Verify Edit Profile Info Screen Success State UI', (
      WidgetTester tester,
    ) async {
      //Arrange
      final expectedEntity = ProfileInfoDummy.dummyDriverEntityFake;

      final state = ProfileStates(
        isLoading: false,
        driverData: expectedEntity,
        isUpdated: true,
        isFormChanged: false,
      );

      when(mockProfileViewModel.state).thenReturn(state);

      when(
        mockProfileViewModel.stream,
      ).thenAnswer((_) => Stream.fromIterable([state]));

      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(
          const TestAppWrapper(child: EditProfileInfoScreen()),
        );

        await tester.pumpAndSettle();
        //Assert
        expect(find.byType(SnackBar), findsOneWidget);
        expect(find.byKey(const Key(WidgetsKeys.kEditProfileInfoScreenSuccessSnackBar)), findsOneWidget);
      });
    });

    testWidgets('Verify Edit Profile Info Screen failure State UI', (
      WidgetTester tester,
    ) async {
      //Arrange
      final expectedFailure = "Server-Error";

      final state = ProfileStates(
        isLoading: false,
        errorMessage:expectedFailure 
      );

      when(mockProfileViewModel.state).thenReturn(state);

      when(
        mockProfileViewModel.stream,
      ).thenAnswer((_) => Stream.fromIterable([state]));

      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(
          const TestAppWrapper(child: EditProfileInfoScreen()),
        );

        await tester.pumpAndSettle();
        //Assert
        expect(find.byType(SnackBar), findsOneWidget);
        expect(
          find.byKey(
            const Key(WidgetsKeys.kEditProfileInfoScreenFailureSnackBar),
          ),
          findsOneWidget,
        );
      });
    });
  });
}
