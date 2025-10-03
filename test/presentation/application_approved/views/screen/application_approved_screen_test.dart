import 'package:elevate_tracking_app/core/constants/app_images.dart';
import 'package:elevate_tracking_app/core/constants/widgets_keys.dart';
import 'package:elevate_tracking_app/core/custom_widget/test_app_wrapper.dart';
import 'package:elevate_tracking_app/core/di/di.dart';
import 'package:elevate_tracking_app/presentation/application_approved/views/screen/application_approved_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() {
    configureDependencies();
  });
  group("Application Approved screen Widget Test", () {
    setUpAll(() {
      configureDependencies();
    });
    testWidgets('Verify Structure', (WidgetTester tester) async {
      //Arrange
      await tester.pumpWidget(
        const TestAppWrapper(child: ApplicationApprovedScreen()),
      );
      //Assert
      expect(find.byType(Text), findsNWidgets(3));
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(
        find.text("Your application has been \n submitted!"),
        findsOneWidget,
      );
      expect(
        find.text(
          "Thank you for providing your application,  \n we will review your application and will \n get back to you soon.",
        ),
        findsOneWidget,
      );
      expect(find.text("Login"), findsOneWidget);
      expect(find.widgetWithText(ElevatedButton, "Login"), findsOneWidget);
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Image &&
              widget.image is AssetImage &&
              (widget.image as AssetImage).assetName == AppImages.imageBg,
        ),
        findsOneWidget,
      );
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Container &&
              widget.decoration is BoxDecoration &&
              (widget.decoration as BoxDecoration).image != null &&
              (widget.decoration as BoxDecoration).image!.image is AssetImage &&
              ((widget.decoration as BoxDecoration).image!.image as AssetImage)
                      .assetName ==
                  AppImages.imageApplySuccess,
        ),
        findsOneWidget,
      );
    });

    testWidgets("Verify login elevatedButton behaviour", (
      WidgetTester tester,
    ) async {
      //Arrange
      await tester.pumpWidget(
        const TestAppWrapper(child: ApplicationApprovedScreen()),
      );
      final loginButtonFinder = find.byKey(
        const Key(WidgetsKeys.kApplicationApprovedScreenLoginButton),
      );
      expect(loginButtonFinder, findsOneWidget);
      //Act
      await tester.scrollUntilVisible(loginButtonFinder, 200);
      await tester.tap(loginButtonFinder);
      await tester.pumpAndSettle();
      //Assert
      expect(find.text("Login"), findsOneWidget);
    });
  });
}
