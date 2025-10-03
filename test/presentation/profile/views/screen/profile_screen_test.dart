import 'package:elevate_tracking_app/core/constants/widgets_keys.dart';
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
import 'package:network_image_mock/network_image_mock.dart';

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

    testWidgets('Verify Profile Screen Structure UI', (
      WidgetTester tester,
    ) async {
      //Arrange
      final state = const ProfileStates();

      when(mockProfileViewModel.state).thenReturn(state);

      when(
        mockProfileViewModel.stream,
      ).thenAnswer((_) => Stream.fromIterable([state]));

      await tester.pumpWidget(TestAppWrapper(child: ProfileScreen()));

      await tester.pumpAndSettle();
      //Assert
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text("Profile"), findsOneWidget);
      expect(find.byType(IconButton), findsNWidgets(2));
    });

    testWidgets('Verify Profile Screen Loading State UI', (
      WidgetTester tester,
    ) async {
      //Arrange
      final state = const ProfileStates(isLoading: true);

      when(mockProfileViewModel.state).thenReturn(state);

      when(
        mockProfileViewModel.stream,
      ).thenAnswer((_) => Stream.fromIterable([state]));

      await tester.pumpWidget(TestAppWrapper(child: ProfileScreen()));

      await tester.pump();

      //Assert
      expect(
        find.byKey(const Key("profile_screen_loading_indicator")),
        findsOneWidget,
      );
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Verify Profile Screen failure State UI', (
      WidgetTester tester,
    ) async {
      //Arrange
      final expectedfailure = "Server-Error";
      final state = ProfileStates(
        isLoading: false,
        errorMessage: expectedfailure,
      );

      when(mockProfileViewModel.state).thenReturn(state);

      when(
        mockProfileViewModel.stream,
      ).thenAnswer((_) => Stream.fromIterable([state]));

      await tester.pumpWidget(TestAppWrapper(child: ProfileScreen()));

      await tester.pumpAndSettle();

      //Assert
      expect(
        find.byKey(const Key("profile_screen_error_message")),
        findsOneWidget,
      );
      expect(find.text(expectedfailure), findsOneWidget);
    });

    testWidgets('Verify Profile Screen Success State UI', (
      WidgetTester tester,
    ) async {
      final expectedEntity = ProfileInfoDummy.dummyDriverEntityFake;
      final expectedVehicleEntity = ProfileInfoDummy.dummyVehicleEntityFake;

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

      await tester.pumpWidget(TestAppWrapper(child: ProfileScreen()));

      await tester.pumpAndSettle();
      //Assert
      expect(find.byType(AppBar), findsOneWidget);
      expect(
        find.text("${expectedEntity.firstName} ${expectedEntity.lastName}"),
        findsOneWidget,
      );
      expect(find.text(expectedEntity.email!), findsOneWidget);
      expect(find.text(expectedEntity.phone!), findsOneWidget);
      expect(find.text(expectedVehicleEntity.type!), findsOneWidget);
      expect(find.text(expectedEntity.vehicleNumber!), findsOneWidget);
    });

    testWidgets(
      "Verify Forward icon behaviour Navigate edit profile info Screen",
      (WidgetTester tester) async {
        //Arrange
        final expectedEntity = ProfileInfoDummy.dummyDriverEntityFake;
        final expectedVehicleEntity = ProfileInfoDummy.dummyVehicleEntityFake;
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

        await mockNetworkImagesFor(() async {
          await tester.pumpWidget(TestAppWrapper(child: ProfileScreen()));
          final forwardIconFinder = find.byKey(
            const Key(WidgetsKeys.kProfileScreenForwardIconToEditProfileInfo),
          );
          expect(forwardIconFinder, findsOneWidget);
          //Act
          await tester.tap(forwardIconFinder);
          await tester.pumpAndSettle();
          //Assert
          expect(find.text("Edit profile"), findsOneWidget);
        });
      },
    );

    testWidgets(
      "Verify Forward icon behaviour Navigate edit vehicle info Screen",
      (WidgetTester tester) async {
        //Arrange
        final expectedEntity = ProfileInfoDummy.dummyDriverEntityFake;
        final expectedVehicleEntity = ProfileInfoDummy.dummyVehicleEntityFake;
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

        await tester.pumpWidget(TestAppWrapper(child: ProfileScreen()));
        final forwardIconFinder = find.byKey(
          const Key(WidgetsKeys.kProfileScreenForwardIconToEditVehicleInfo),
        );
        expect(forwardIconFinder, findsOneWidget);
        //Act
        await tester.tap(forwardIconFinder);
        await tester.pumpAndSettle();
        //Assert
        expect(find.text("Edit profile"), findsOneWidget);
      },
    );

    testWidgets(
      "Verify Forward icon behaviour Navigate edit vehicle info Screen",
      (WidgetTester tester) async {
        //Arrange
        final expectedEntity = ProfileInfoDummy.dummyDriverEntityFake;
        final expectedVehicleEntity = ProfileInfoDummy.dummyVehicleEntityFake;
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

        await tester.pumpWidget(TestAppWrapper(child: ProfileScreen()));
        final forwardIconFinder = find.byKey(
          const Key(WidgetsKeys.kProfileScreenForwardIconToEditVehicleInfo),
        );
        expect(forwardIconFinder, findsOneWidget);
        //Act
        await tester.tap(forwardIconFinder);
        await tester.pumpAndSettle();
        //Assert
        expect(find.text("Edit profile"), findsOneWidget);
      },
    );

    testWidgets("Verify Logout icon behaviour", (WidgetTester tester) async {
      //Arrange
      final expectedEntity = ProfileInfoDummy.dummyDriverEntityFake;
      final expectedVehicleEntity = ProfileInfoDummy.dummyVehicleEntityFake;
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

      await tester.pumpWidget(TestAppWrapper(child: ProfileScreen()));
      final logoutIconFinder = find.byKey(
        const Key(WidgetsKeys.kProfileScreenLogoutIcon),
      );
      expect(logoutIconFinder, findsOneWidget);
      //Act
      await tester.tap(logoutIconFinder);
      await tester.pumpAndSettle();
      //Assert
      expect(
        find.byKey(const Key(WidgetsKeys.kProfileScreenLogoutDialog)),
        findsOneWidget,
      );
      expect(find.text("LOGOUT"), findsOneWidget);
    });

    testWidgets("Verify Logout elevatedbutton behaviour Navigate to login screen", (WidgetTester tester) async {
      //Arrange
      final expectedEntity = ProfileInfoDummy.dummyDriverEntityFake;
      final expectedVehicleEntity = ProfileInfoDummy.dummyVehicleEntityFake;
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

      await tester.pumpWidget(TestAppWrapper(child: ProfileScreen()));
      final logoutIconFinder = find.byKey(
          const Key(WidgetsKeys.kProfileScreenLogoutIcon),
        );
        expect(logoutIconFinder, findsOneWidget);
        await tester.tap(logoutIconFinder);
        await tester.pumpAndSettle();
      final logoutElevatedButtonFinder = find.byKey(
        const Key(WidgetsKeys.kProfileScreenLogoutButton),
      );
      expect(logoutElevatedButtonFinder, findsOneWidget);
      //Act
      await tester.tap(logoutElevatedButtonFinder);
      await tester.pumpAndSettle();
      //Assert
      expect(find.text("Login"), findsOneWidget);
    });
  });
}
