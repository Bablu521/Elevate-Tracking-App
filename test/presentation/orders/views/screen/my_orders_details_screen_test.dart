// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'dart:ui';

import 'package:elevate_tracking_app/core/custom_widget/test_app_wrapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:elevate_tracking_app/presentation/orders/views/screen/my_orders_details_screen.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../../../dummy/driver_orders_driver_related_dummy.dart';

void main() {
    group("My Orders Details Screen Widget test", (){
    testWidgets('My Orders Details Screen Structure UI', (
      WidgetTester tester,
    ) async {
      //Arrange
      final driverOrderEntityDriverRelated =
          DriverOrdersDriverRelatedDummy.dummyDriverOrderEntityDriverRelated;

      tester.binding.window.physicalSizeTestValue = Size(1080, 1920);
      tester.binding.window.devicePixelRatioTestValue = 1.0;

      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(
          TestAppWrapper(
            child: MyOrdersDetailsScreen(
              driverOrderEntityDriverRelated: driverOrderEntityDriverRelated,
            ),
          ),
        );

        await tester.pumpAndSettle();

        //Assert

        expect(find.text("Order details"), findsNWidgets(2));
        expect(
          find.text("# ${driverOrderEntityDriverRelated.order!.id}"),
          findsOneWidget,
        );
        expect(find.text("Pickup address"), findsOneWidget);
        expect(find.text("${driverOrderEntityDriverRelated.store!.name}"), findsOneWidget);
        expect(find.text("${driverOrderEntityDriverRelated.store!.address}"), findsOneWidget);
        expect(find.text("User address"), findsOneWidget);
        expect(find.text(
            "${driverOrderEntityDriverRelated.order!.user!.firstName} ${driverOrderEntityDriverRelated.order!.user!.lastName}",
          ), findsOneWidget);
        expect(find.text(
            "${driverOrderEntityDriverRelated.order!.shippingAddress?.street ?? "20th st, Sheikh Zayed,"} ${driverOrderEntityDriverRelated.order!.shippingAddress?.city ?? "Giza"}",
          ), findsOneWidget);
        expect(find.text("Total"), findsOneWidget);
        expect(find.text("Payment method"), findsOneWidget);
        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      });
    });
    });
    
  }
