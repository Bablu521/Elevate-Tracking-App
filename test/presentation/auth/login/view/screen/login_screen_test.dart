import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/core/constants/const_keys.dart';
import 'package:elevate_tracking_app/core/constants/widgets_keys.dart';
import 'package:elevate_tracking_app/core/custom_widget/test_app_wrapper.dart';
import 'package:elevate_tracking_app/core/di/di.dart';
import 'package:elevate_tracking_app/domain/entites/login_entity.dart';
import 'package:elevate_tracking_app/domain/entites/requests/login_request_entity.dart';
import 'package:elevate_tracking_app/domain/use_cases/login_use_case.dart';
import 'package:elevate_tracking_app/generated/l10n.dart';
import 'package:elevate_tracking_app/presentation/auth/login/view/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../../dummy/login_dummy_data.dart';
import 'login_screen_test.mocks.dart';

@GenerateMocks([LoginUseCase, FlutterSecureStorage])
void main() {
  group("widget test LoginScreen", () {
    late MockLoginUseCase mockLoginUseCase;
    late MockFlutterSecureStorage mockFlutterSecureStorage;

    final appBarButton = find.byKey(
      const Key(WidgetsKeys.kLoginScreenAppBarButton),
    );
    final emailField = find.byKey(
      const Key(WidgetsKeys.kLoginScreenEmailField),
    );
    final passwordField = find.byKey(
      const Key(WidgetsKeys.kLoginScreenPasswordField),
    );
    final passwordVisibilityButton = find.byKey(
      const Key(WidgetsKeys.kLoginScreenPasswordVisibilityButton),
    );
    final rememberMeCheckbox = find.byKey(
      const Key(WidgetsKeys.kLoginScreenRememberMeCheckbox),
    );
    final forgotPasswordButton = find.byKey(
      const Key(WidgetsKeys.kLoginScreenForgotPasswordButton),
    );
    final continueButton = find.byKey(
      const Key(WidgetsKeys.kLoginScreenContinueButton),
    );

    setUpAll(() async {
      configureDependencies();
      await getIt.unregister<LoginUseCase>();
      await getIt.unregister<FlutterSecureStorage>();
      mockLoginUseCase = MockLoginUseCase();
      mockFlutterSecureStorage = MockFlutterSecureStorage();
      getIt.registerSingleton<LoginUseCase>(mockLoginUseCase);
      getIt.registerSingleton<FlutterSecureStorage>(mockFlutterSecureStorage);
      when(
        mockFlutterSecureStorage.read(key: ConstKeys.keyRememberMe),
      ).thenAnswer((_) async => ConstKeys.falseKey);
    });

    testWidgets("Verify structure", (tester) async {
      await tester.pumpWidget(const TestAppWrapper(child: LoginScreen()));

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.byType(IconButton), findsNWidgets(2));
      expect(find.byType(CheckboxListTile), findsNWidgets(1));
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.byType(Text), findsNWidgets(8));

      expect(find.text(AppLocalizations().login), findsOneWidget);
      expect(find.text(AppLocalizations().email), findsOneWidget);
      expect(find.text(AppLocalizations().enterYourEmail), findsOneWidget);
      expect(find.text(AppLocalizations().password), findsOneWidget);
      expect(find.text(AppLocalizations().enterYourPassword), findsOneWidget);
      expect(find.text(AppLocalizations().rememberMe), findsOneWidget);
      expect(
        find.text(AppLocalizations().forgotPasswordWithQuestionMark),
        findsOneWidget,
      );
      expect(find.text(AppLocalizations().continueWord), findsOneWidget);
    });

    testWidgets("Verify app bar behaviour", (tester) async {
      await tester.pumpWidget(const TestAppWrapper(child: LoginScreen()));

      expect(find.byType(AppBar), findsOneWidget);
      expect(appBarButton, findsOneWidget);

      //await tester.tap(appBarButton);
      //await tester.pumpAndSettle();

      //expect(find.text(AppLocalizations().welcomeToFloweryRiderApp), findsOneWidget);
    });

    testWidgets("Verify login form fields behaviour", (tester) async {
      await tester.pumpWidget(const TestAppWrapper(child: LoginScreen()));

      expect(emailField, findsOneWidget);
      expect(passwordField, findsOneWidget);
      expect(continueButton, findsOneWidget);

      expect(find.text(AppLocalizations().enterValidEmail), findsNothing);
      expect(find.text(AppLocalizations().passwordNotMatched), findsNothing);

      await tester.enterText(emailField, "test");
      await tester.enterText(passwordField, "test");
      await tester.pumpAndSettle();
      await tester.tap(continueButton);
      await tester.pumpAndSettle();

      expect(find.text(AppLocalizations().enterValidEmail), findsOneWidget);
      expect(find.text(AppLocalizations().passwordNotMatched), findsOneWidget);
    });

    testWidgets("Verify password visibility button behaviour", (tester) async {
      await tester.pumpWidget(const TestAppWrapper(child: LoginScreen()));

      expect(passwordField, findsOneWidget);
      expect(passwordVisibilityButton, findsOneWidget);

      expect(
        tester
            .getSemantics(passwordField)
            .getSemanticsData()
            .flagsCollection
            .isObscured,
        isTrue,
      );
      await tester.tap(passwordVisibilityButton);
      await tester.pumpAndSettle();
      expect(
        tester
            .getSemantics(passwordField)
            .getSemanticsData()
            .flagsCollection
            .isObscured,
        isFalse,
      );
    });

    testWidgets("Verify remember me checkbox behaviour", (tester) async {
      await tester.pumpWidget(const TestAppWrapper(child: LoginScreen()));

      expect(rememberMeCheckbox, findsOneWidget);

      expect(
        tester
            .getSemantics(rememberMeCheckbox)
            .getSemanticsData()
            .flagsCollection
            .isChecked,
        isFalse,
      );
      await tester.tap(rememberMeCheckbox);
      await tester.pumpAndSettle();
      expect(
        tester
            .getSemantics(rememberMeCheckbox)
            .getSemanticsData()
            .flagsCollection
            .isChecked,
        isTrue,
      );
    });

    testWidgets("Verify forgetPassword button behaviour", (tester) async {
      await tester.pumpWidget(const TestAppWrapper(child: LoginScreen()));

      expect(forgotPasswordButton, findsOneWidget);

      await tester.tap(forgotPasswordButton);
      await tester.pumpAndSettle();

      expect(find.text("Page Not Found"), findsOneWidget);
    });

    testWidgets("Verify continue button behaviour", (tester) async {
      await tester.pumpWidget(const TestAppWrapper(child: LoginScreen()));

      expect(emailField, findsOneWidget);
      expect(passwordField, findsOneWidget);
      expect(continueButton, findsOneWidget);

      expect(
        tester
            .getSemantics(continueButton)
            .getSemanticsData()
            .flagsCollection
            .isEnabled,
        isFalse,
      );

      await tester.enterText(emailField, "test");
      await tester.enterText(passwordField, "test");
      await tester.pumpAndSettle();

      expect(
        tester
            .getSemantics(continueButton)
            .getSemanticsData()
            .flagsCollection
            .isEnabled,
        isTrue,
      );
    });

    testWidgets("Verify success login behaviour", (tester) async {
      final expectedRequestEntity = const LoginRequestEntity(
        email: "test@gmail.com",
        password: "test123654A#",
      );
      final expectedResponseEntity = LoginDummyData().fakeLoginEntity;
      final expectedResult = ApiSuccessResult<LoginEntity>(
        expectedResponseEntity,
      );
      provideDummy<ApiResult<LoginEntity>>(expectedResult);
      when(
        mockLoginUseCase(expectedRequestEntity),
      ).thenAnswer((_) async => expectedResult);

      await tester.pumpWidget(const TestAppWrapper(child: LoginScreen()));

      expect(emailField, findsOneWidget);
      expect(passwordField, findsOneWidget);
      expect(continueButton, findsOneWidget);

      await tester.enterText(emailField, expectedRequestEntity.email);
      await tester.enterText(passwordField, expectedRequestEntity.password);
      await tester.pumpAndSettle();
      await tester.tap(continueButton);
      //await tester.pump();

      //expect(find.text(AppLocalizations().home), findsOneWidget);
    });

    testWidgets("Verify error login behaviour", (tester) async {
      final expectedRequestEntity = const LoginRequestEntity(
        email: "test@gmail.com",
        password: "test123654A#",
      );
      final expectedResponse = "errorMessage";
      final expectedResult = ApiErrorResult<LoginEntity>(expectedResponse);
      provideDummy<ApiResult<LoginEntity>>(expectedResult);
      when(
        mockLoginUseCase(expectedRequestEntity),
      ).thenAnswer((_) async => expectedResult);

      await tester.pumpWidget(const TestAppWrapper(child: LoginScreen()));

      expect(emailField, findsOneWidget);
      expect(passwordField, findsOneWidget);
      expect(continueButton, findsOneWidget);

      await tester.enterText(emailField, expectedRequestEntity.email);
      await tester.enterText(passwordField, expectedRequestEntity.password);
      await tester.pumpAndSettle();
      await tester.tap(continueButton);
      await tester.pumpAndSettle();

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text(expectedResponse), findsOneWidget);
    });
  });
}
