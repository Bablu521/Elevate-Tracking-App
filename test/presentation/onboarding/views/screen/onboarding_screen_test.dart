// import 'dart:async';
// import 'package:elevate_tracking_app/core/api_result/api_result.dart';
// import 'package:elevate_tracking_app/core/base_state/base_state.dart';
import 'package:elevate_tracking_app/core/constants/app_images.dart';
import 'package:elevate_tracking_app/core/constants/widgets_keys.dart';
import 'package:elevate_tracking_app/core/custom_widget/test_app_wrapper.dart';
// import 'package:elevate_tracking_app/domain/entites/apply_response_entity.dart';
// import 'package:elevate_tracking_app/domain/entites/country_entity.dart';
// import 'package:elevate_tracking_app/domain/entites/vehicles_entity.dart';
import 'package:elevate_tracking_app/presentation/onboarding/views/screen/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:get_it/get_it.dart';
// import 'package:mockito/annotations.dart';
// import 'package:elevate_tracking_app/presentation/auth/apply/view_model/apply_view_model.dart';
// import 'package:elevate_tracking_app/domain/use_cases/apply_use_case.dart';
// import 'package:elevate_tracking_app/domain/use_cases/get_all_country_use_case.dart';
// import 'package:elevate_tracking_app/domain/use_cases/get_all_vehicles_use_case.dart';
// import 'package:mockito/mockito.dart';

// import 'onboarding_screen_test.mocks.dart';

// @GenerateMocks([
//   ApplyViewModel,
//   GetAllVehiclesUseCase,
//   GetAllCountryUseCase,
//   ApplyUseCase,
// ])
void main() {
  // provideDummy<ApiResult<List<VehicleEntity>>>(
  //   ApiSuccessResult<List<VehicleEntity>>([
  //     const VehicleEntity(id: "1", type: "Car", image: "car.png"),
  //   ]),
  // );
  // provideDummy<ApiResult<List<CountryEntity>>>(
  //   ApiSuccessResult<List<CountryEntity>>([
  //     const CountryEntity(
  //       name: "Country",
  //       flag: "flag_code",
  //       currency: "USD",
  //       flagImage: "flag.png",
  //     ),
  //   ]),
  // );
  // provideDummy<ApiResult<ApplyResponseEntity>>(
  //   ApiSuccessResult<ApplyResponseEntity>(const ApplyResponseEntity()),
  // );
  // final getIt = GetIt.instance;

  // setUp(() async {
  //   await getIt.reset();

  //   // إنشاء mocks للتبعيات
  //   final mockGetAllVehiclesUseCase = MockGetAllVehiclesUseCase();
  //   final mockGetAllCountryUseCase = MockGetAllCountryUseCase();
  //   final mockApplyUseCase = MockApplyUseCase();
  //   final mockApplyViewModel = MockApplyViewModel();

  //   // Stub لـ doIntent
  //   when(mockApplyViewModel.doIntent(any)).thenAnswer((_) async {});

  //   // Stub لـ stream و state
  //   final initialState = const ApplyViewModelState(
  //     allVehicleList: BaseState<List<VehicleEntity>>(),
  //     allCountry: BaseState<List<CountryEntity>>(),
  //     applyFun: BaseState<ApplyResponseEntity>(),
  //   );
  //   when(
  //     mockApplyViewModel.stream,
  //   ).thenAnswer((_) => Stream.value(initialState));
  //   when(mockApplyViewModel.state).thenReturn(initialState);

  //   // Stub للتبعيات
  //   when(mockGetAllVehiclesUseCase.call()).thenAnswer(
  //     (_) async => ApiSuccessResult<List<VehicleEntity>>([
  //       const VehicleEntity(id: "1", type: "Car", image: "car.png"),
  //     ]),
  //   );
  //   when(mockGetAllCountryUseCase.call()).thenAnswer(
  //     (_) async => ApiSuccessResult<List<CountryEntity>>([
  //       const CountryEntity(
  //         name: "Country",
  //         flag: "flag_code",
  //         currency: "USD",
  //         flagImage: "flag.png",
  //       ),
  //     ]),
  //   );
  //   when(mockApplyUseCase.call(any)).thenAnswer(
  //     (_) async =>
  //         ApiSuccessResult<ApplyResponseEntity>(const ApplyResponseEntity()),
  //   );

  //   // تسجيل في GetIt
  //   getIt.registerFactory<GetAllVehiclesUseCase>(
  //     () => mockGetAllVehiclesUseCase,
  //   );
  //   getIt.registerFactory<GetAllCountryUseCase>(() => mockGetAllCountryUseCase);
  //   getIt.registerFactory<ApplyUseCase>(() => mockApplyUseCase);
  //   getIt.registerFactory<ApplyViewModel>(() => mockApplyViewModel);
  // });
  // tearDown(() async {
  //   await getIt.reset();
  // });
  group("Onboarding screen Widget Test", () {
    testWidgets('Verify Structure', (WidgetTester tester) async {
      //Arrange
      await tester.pumpWidget(const TestAppWrapper(child: OnboardingScreen()));
      //Assert
      expect(find.byType(ElevatedButton), findsNWidgets(2));
      expect(find.byType(Text), findsNWidgets(3));
      expect(find.text("Login"), findsOneWidget);
      expect(find.text("Apply now"), findsOneWidget);
      expect(find.text("Welcome to \nFlowery rider app"), findsOneWidget);
      expect(find.widgetWithText(ElevatedButton, "Login"), findsOneWidget);
      expect(find.widgetWithText(ElevatedButton, "Apply now"), findsOneWidget);
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Center &&
              widget.child is Container &&
              (widget.child as Container).decoration is BoxDecoration &&
              ((widget.child as Container).decoration as BoxDecoration).image !=
                  null &&
              ((widget.child as Container).decoration as BoxDecoration)
                      .image!
                      .image
                  is AssetImage &&
              (((widget.child as Container).decoration as BoxDecoration)
                              .image!
                              .image
                          as AssetImage)
                      .assetName ==
                  AppImages.imageOnboarding,
        ),
        findsOneWidget,
      );
    });
    testWidgets("Verify login elevatedButton behaviour", (
      WidgetTester tester,
    ) async {
      //Arrange
      await tester.pumpWidget(const TestAppWrapper(child: OnboardingScreen()));
      final loginButtonFinder = find.byKey(
        const Key(WidgetsKeys.kOnboardingScreenLoginButton),
      );
      expect(loginButtonFinder, findsOneWidget);
      //Act
      await tester.tap(loginButtonFinder);
      await tester.pumpAndSettle();
      //Assert
      expect(find.text("Login"), findsOneWidget);
    });

    testWidgets("Verify Apply now elevatedButton behaviour", (
      WidgetTester tester,
    ) async {
      //Arrange
      await tester.pumpWidget(const TestAppWrapper(child: OnboardingScreen()));
      final applyButtonFinder = find.byKey(
        const Key(WidgetsKeys.kOnboardingScreenApplyNowButton),
      );
      expect(applyButtonFinder, findsOneWidget);
      //Act
      await tester.tap(applyButtonFinder);
      await tester.pumpAndSettle();
      //Assert
      expect(find.text("Apply"), findsOneWidget);
    });
  });
}
