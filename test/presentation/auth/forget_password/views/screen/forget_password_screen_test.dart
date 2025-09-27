import 'package:elevate_tracking_app/core/custom_widget/test_app_wrapper.dart';
import 'package:elevate_tracking_app/core/di/di.dart';
import 'package:elevate_tracking_app/domain/entities/email_verification_entity.dart';
import 'package:elevate_tracking_app/domain/entities/forget_password_entity.dart';
import 'package:elevate_tracking_app/generated/l10n.dart';
import 'package:elevate_tracking_app/presentation/auth/forget_password/view_models/forget_password_state.dart';
import 'package:elevate_tracking_app/presentation/auth/forget_password/view_models/forget_password_view_model.dart';
import 'package:elevate_tracking_app/presentation/auth/forget_password/views/screen/forget_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pinput/pinput.dart';

import 'forget_password_screen_test.mocks.dart';

@GenerateMocks([ForgetPasswordViewModel])
void main() {
  group("widget test ForgetPasswordScreen", () {
    late MockForgetPasswordViewModel mockForgetPasswordViewModel;
    final mockForgetPasswordFormKey = GlobalKey<FormState>();
    final mockEmailVerificationFormKey = GlobalKey<FormState>();
    final mockResetPasswordFormKey = GlobalKey<FormState>();
    final mockEmailController = TextEditingController();
    final mockResetCodeController = TextEditingController();
    final mockNewPasswordController = TextEditingController();
    final mockConfirmPasswordController = TextEditingController();

    setUpAll(() async {
      mockForgetPasswordViewModel = MockForgetPasswordViewModel();
      configureDependencies();
      await getIt.unregister<ForgetPasswordViewModel>();
      getIt.registerSingleton<ForgetPasswordViewModel>(
        mockForgetPasswordViewModel,
      );

      when(
        mockForgetPasswordViewModel.forgetPasswordFormKey,
      ).thenReturn(mockForgetPasswordFormKey);
      when(
        mockForgetPasswordViewModel.emailVerificationFormKey,
      ).thenReturn(mockEmailVerificationFormKey);
      when(
        mockForgetPasswordViewModel.resetPasswordFormKey,
      ).thenReturn(mockResetPasswordFormKey);
      when(
        mockForgetPasswordViewModel.emailController,
      ).thenReturn(mockEmailController);

      when(
        mockForgetPasswordViewModel.resetCodeController,
      ).thenReturn(mockResetCodeController);

      when(
        mockForgetPasswordViewModel.newPasswordController,
      ).thenReturn(mockNewPasswordController);

      when(
        mockForgetPasswordViewModel.confirmPasswordController,
      ).thenReturn(mockConfirmPasswordController);
    });

    testWidgets("Verify ForgetPassword structure", (tester) async {
      final state = const ForgetPasswordState();

      when(mockForgetPasswordViewModel.state).thenReturn(state);

      when(
        mockForgetPasswordViewModel.stream,
      ).thenAnswer((_) => Stream.fromIterable([state]));

      await tester.pumpWidget(
        const TestAppWrapper(child: ForgetPasswordScreen()),
      );

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(IconButton), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.byType(Text), findsNWidgets(6));

      expect(find.text(AppLocalizations().password), findsOneWidget);
      expect(find.text(AppLocalizations().forgetPassword), findsOneWidget);
      expect(
        find.text(AppLocalizations().pleaseEnterYourEmail),
        findsOneWidget,
      );
      expect(find.text(AppLocalizations().email), findsOneWidget);
      expect(find.text(AppLocalizations().enterYourEmail), findsOneWidget);
      expect(find.text(AppLocalizations().confirm), findsOneWidget);
    });

    testWidgets("Verify EmailVerification structure", (tester) async {
      /*final emailVerificationEntity = EmailVerificationEntity(
        status: "fake-status",
      );*/

      final forgetPasswordEntity = ForgetPasswordEntity(
        message: "fake-message",
        info: "fake-info",
      );

      final state = ForgetPasswordState(
        isLoading: false,
        forgetPasswordResponse: forgetPasswordEntity,
        pageNumber: 1,
      );

      when(mockForgetPasswordViewModel.state).thenReturn(state);

      when(
        mockForgetPasswordViewModel.stream,
      ).thenAnswer((_) => Stream.fromIterable([state]));

      await tester.pumpWidget(
        const TestAppWrapper(child: ForgetPasswordScreen()),
      );

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(IconButton), findsOneWidget);
      expect(find.byType(Pinput), findsOneWidget);
      expect(find.byType(Text), findsNWidgets(11));

      expect(find.text(AppLocalizations().password), findsOneWidget);
      expect(find.text(AppLocalizations().emailVerification), findsOneWidget);
      expect(
        find.text(AppLocalizations().pleaseEnterYourVerificationCode),
        findsOneWidget,
      );
      expect(find.text(AppLocalizations().didNotReceiveCode), findsOneWidget);
      expect(find.text(AppLocalizations().resend), findsOneWidget);
    });

    testWidgets("Verify ResetPassword structure", (tester) async {
      final emailVerificationEntity = EmailVerificationEntity(
        status: "fake-status",
      );

      final state = ForgetPasswordState(
        isLoading: false,
        emailVerificationResponse: emailVerificationEntity,
        pageNumber: 2,
      );

      when(mockForgetPasswordViewModel.state).thenReturn(state);

      when(
        mockForgetPasswordViewModel.stream,
      ).thenAnswer((_) => Stream.fromIterable([state]));

      await tester.pumpWidget(
        const TestAppWrapper(child: ForgetPasswordScreen()),
      );

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(IconButton), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.byType(Text), findsNWidgets(8));

      expect(find.text(AppLocalizations().password), findsOneWidget);
      expect(find.text(AppLocalizations().resetPassword), findsOneWidget);
      expect(
        find.text(AppLocalizations().passwordMustNotEmpty),
        findsOneWidget,
      );
      expect(find.text(AppLocalizations().newPassword), findsOneWidget);
      expect(find.text(AppLocalizations().enterYourPassword), findsOneWidget);
      expect(find.text(AppLocalizations().confirmPassword), findsNWidgets(2));
      expect(find.text(AppLocalizations().confirm), findsOneWidget);
    });
  });
}
