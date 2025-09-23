import 'package:elevate_tracking_app/core/constants/widgets_keys.dart';
import 'package:elevate_tracking_app/core/custom_widget/test_app_wrapper.dart';
import 'package:elevate_tracking_app/presentation/onboarding/views/screen/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Onboarding screen Widget Test", () {
    testWidgets('Verify Structure', (WidgetTester tester) async {
      //Arrange
      await tester.pumpWidget(const TestAppWrapper(child: OnboardingScreen()));
      //Assert
      expect(find.byType(ElevatedButton), findsNWidgets(2));
      expect(find.byType(Text), findsNWidgets(3));
      expect(find.text("Login"), findsNWidgets(1));
      expect(find.text("Apply now"), findsNWidgets(1));
      expect(find.text("Welcome to \nFlowery rider app"), findsNWidgets(1));
      expect(find.widgetWithText(ElevatedButton, "Login"), findsOneWidget);
      expect(find.widgetWithText(ElevatedButton, "Apply now"), findsOneWidget);
      
    });
    testWidgets("Verify login elevatedButton behaviour", (
      WidgetTester tester,
    ) async {
      //Arrange
      await tester.pumpWidget(const TestAppWrapper(child: OnboardingScreen(),));
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
