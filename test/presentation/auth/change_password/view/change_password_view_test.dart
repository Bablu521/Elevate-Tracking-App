import 'package:elevate_tracking_app/core/constants/widgets_keys.dart';
import 'package:elevate_tracking_app/core/custom_widget/test_app_wrapper.dart';
import 'package:elevate_tracking_app/core/di/di.config.dart';
import 'package:elevate_tracking_app/domain/use_cases/change_password_use_case.dart';
import 'package:elevate_tracking_app/generated/l10n.dart';
import 'package:elevate_tracking_app/presentation/auth/change_password/view/change_password_view.dart';
import 'package:elevate_tracking_app/presentation/auth/change_password/view_model/change_password_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([ChangePasswordUseCase])
void main() {
  group( "change password view test " , ( ) {

    final getIt = GetIt.instance;
    setUp ( () async {
      getIt.reset();
      getIt.init();




    });

    final currentPasswordField = find.byKey(
      const Key(WidgetsKeys.kChanePasswordPassword),
    );
    final newPasswordField = find.byKey(
      const Key(WidgetsKeys.kChanePasswordNewPassword),
    );
    final confirmPasswordField = find.byKey(
      const Key(WidgetsKeys.kChanePasswordConfirmPassword),
    );
    final confirmButton= find.byKey(
      const Key(WidgetsKeys.kChanePasswordConfirmButton),
    );
    testWidgets("verify  change password behavior " , (tester) async {
      await tester.pumpWidget(const TestAppWrapper(child: ChangePassword()));

      final viewModel = GetIt.instance<ChangePasswordViewModel>();
      final formKey = viewModel.changePasswordFormKey;

      expect(currentPasswordField, findsOneWidget);
      expect(newPasswordField, findsOneWidget);
      expect(confirmPasswordField, findsOneWidget);
       expect(confirmButton, findsOneWidget);

      expect(find.text(AppLocalizations().enterYourPassword), findsNothing);
      expect(find.text(AppLocalizations().passwordNotMatched), findsNothing);

      await tester.enterText(currentPasswordField, "123");
      await tester.enterText(confirmPasswordField, "466");
      await tester.pumpAndSettle();
       await tester.tap(confirmButton);
      await tester.pumpAndSettle();
      await tester.pump();

      final form = find.byType(Form).evaluate().first.widget as Form;
      final isValid = formKey.currentState?.validate() ?? false;
      expect(isValid, false);

    });
    testWidgets("Verify app bar behaviour", (tester) async {
      await tester.pumpWidget(const TestAppWrapper(child: ChangePassword()));

      expect(find.byType(AppBar), findsOneWidget);


    });
    testWidgets("verify success change password behavior " , (tester) async {
      await tester.pumpWidget(const TestAppWrapper(child: ChangePassword()));

      final viewModel = GetIt.instance<ChangePasswordViewModel>();
      final formKey = viewModel.changePasswordFormKey;

      expect(currentPasswordField, findsOneWidget);
      expect(newPasswordField, findsOneWidget);
      expect(confirmPasswordField, findsOneWidget);
       expect(confirmButton, findsOneWidget);

      expect(find.text(AppLocalizations().enterYourPassword), findsNothing);
      expect(find.text(AppLocalizations().passwordNotMatched), findsNothing);

      await tester.enterText(currentPasswordField, "123456");
      await tester.enterText(newPasswordField, "abcd1234");
      await tester.enterText(confirmPasswordField, "abcd1234");
      await tester.pumpAndSettle();



      final buttonWidget = tester.widget<ElevatedButton>(confirmButton);
      expect(buttonWidget.onPressed != null, true);

      await tester.tap(confirmButton);
      await tester.pump(const Duration(seconds: 2));
      expect(find.text(AppLocalizations().passwordNotMatched), findsNothing);
      expect(find.text(AppLocalizations().enterYourPassword), findsNothing);



    });
    testWidgets("verify error fields change password behavior " , (tester) async {
      await tester.pumpWidget(const TestAppWrapper(child: ChangePassword()));

      final viewModel = GetIt.instance<ChangePasswordViewModel>();
      final formKey = viewModel.changePasswordFormKey;

      expect(currentPasswordField, findsOneWidget);
      expect(newPasswordField, findsOneWidget);
      expect(confirmPasswordField, findsOneWidget);
       expect(confirmButton, findsOneWidget);

      expect(find.text(AppLocalizations().enterYourPassword), findsNothing);
      expect(find.text(AppLocalizations().passwordNotMatched), findsNothing);

      await tester.enterText(currentPasswordField, "123456");
      await tester.enterText(newPasswordField, "abcd1234");
      await tester.enterText(confirmPasswordField, "abcd123");
      await tester.pumpAndSettle();



      await tester.tap(confirmButton);
      await tester.pump(const Duration(seconds: 2));
      
      final buttonWidget = tester.widget<ElevatedButton>(confirmButton);
      expect(buttonWidget.onPressed != null, false);

      // expect(find.text(AppLocalizations().passwordNotMatched), findsOneWidget);
      // expect(find.text(AppLocalizations().enterYourPassword), findsNothing);



    });




  });
}