// ignore_for_file: deprecated_member_use

import 'package:elevate_tracking_app/core/constants/widgets_keys.dart';
import 'package:elevate_tracking_app/core/custom_widget/test_app_wrapper.dart';
import 'package:elevate_tracking_app/core/di/di.dart';
import 'package:elevate_tracking_app/domain/entites/driver_order_entity_driver_related.dart';
import 'package:elevate_tracking_app/presentation/orders/view_models/driver_orders_states.dart';
import 'package:elevate_tracking_app/presentation/orders/view_models/driver_orders_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:elevate_tracking_app/presentation/orders/views/screen/orders_screen.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy/driver_orders_driver_related_dummy.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'orders_screen_test.mocks.dart';

@GenerateMocks([DriverOrdersViewModel])
void main() {
  group("Orders Screen Widget test", () {
    late MockDriverOrdersViewModel mockDriverOrdersViewModel;
    setUpAll(() async {
      mockDriverOrdersViewModel = MockDriverOrdersViewModel();
      configureDependencies();
      await getIt.unregister<DriverOrdersViewModel>();
      getIt.registerSingleton<DriverOrdersViewModel>(mockDriverOrdersViewModel);
    });
    testWidgets('Verify Orders Screen Structure UI', (
      WidgetTester tester,
    ) async {
      //Arrange
      final state = const DriverOrdersStates();
      when(mockDriverOrdersViewModel.state).thenReturn(state);
      when(
        mockDriverOrdersViewModel.stream,
      ).thenAnswer((_) => Stream.fromIterable([state]));

      await tester.pumpWidget(const TestAppWrapper(child: OrdersScreen()));
      await tester.pumpAndSettle();

      //Assert
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text("My orders"), findsOneWidget);
      expect(find.byType(IconButton), findsNWidgets(1));
    });

    testWidgets('Verify Orders Screen Loading State UI', (
      WidgetTester tester,
    ) async {
      //Arrange
      final state = const DriverOrdersStates(driverOrdersLoading: true);

      when(mockDriverOrdersViewModel.state).thenReturn(state);

      when(
        mockDriverOrdersViewModel.stream,
      ).thenAnswer((_) => Stream.fromIterable([state]));

      await tester.pumpWidget(const TestAppWrapper(child: OrdersScreen()));

      await tester.pump();

      //Assert
      expect(
        find.byKey(const Key("driver_orders_screen_loading_indicator")),
        findsOneWidget,
      );
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Verify Orders Screen failure State UI', (
      WidgetTester tester,
    ) async {
      //Arrange
      final expectedfailure = "Server-Error";
      final state = DriverOrdersStates(
        driverOrdersLoading: false,
        driverOrdersErrorMessage: expectedfailure,
      );

      when(mockDriverOrdersViewModel.state).thenReturn(state);

      when(
        mockDriverOrdersViewModel.stream,
      ).thenAnswer((_) => Stream.fromIterable([state]));

      await tester.pumpWidget(const TestAppWrapper(child: OrdersScreen()));

      await tester.pump();

      //Assert
      expect(
        find.byKey(const Key("driver_orders_screen_error_message")),
        findsOneWidget,
      );
      expect(find.text(expectedfailure), findsOneWidget);
    });

    testWidgets('Verify Orders Screen Success State UI with data', (
      WidgetTester tester,
    ) async {
      //Arrange
      final expectedResult = [
        DriverOrdersDriverRelatedDummy.dummyDriverOrderEntityDriverRelated,
      ];
      final state = DriverOrdersStates(
        driverOrdersLoading: false,
        driverOrdersSuccess: expectedResult,
      );

      when(mockDriverOrdersViewModel.state).thenReturn(state);

      when(
        mockDriverOrdersViewModel.stream,
      ).thenAnswer((_) => Stream.fromIterable([state]));

      tester.binding.window.physicalSizeTestValue = const Size(1080, 1920);
      tester.binding.window.devicePixelRatioTestValue = 1.0;

      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(const TestAppWrapper(child: OrdersScreen()));

        await tester.pumpAndSettle();

        //Assert
        expect(
          find.byKey(const Key("driver_orders_screen_success_state")),
          findsOneWidget,
        );
        expect(find.text("Recent orders"), findsOneWidget);
        expect(find.text("Flower order"), findsNWidgets(expectedResult.length));

        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      });
    });

    testWidgets('Verify Orders Screen Success State UI with no orders', (
      WidgetTester tester,
    ) async {
      //Arrange
      final List<DriverOrderEntityDriverRelated> expectedResult = [];
      final state = DriverOrdersStates(
        driverOrdersLoading: false,
        driverOrdersSuccess: expectedResult,
      );

      when(mockDriverOrdersViewModel.state).thenReturn(state);

      when(
        mockDriverOrdersViewModel.stream,
      ).thenAnswer((_) => Stream.fromIterable([state]));

      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(const TestAppWrapper(child: OrdersScreen()));

        await tester.pumpAndSettle();

        //Assert
        expect(
          find.byKey(const Key("driver_orders_screen_success_no_orders")),
          findsOneWidget,
        );
        expect(find.text("No Orders Yet"), findsOneWidget);
      });
    });

    testWidgets(
      'Verify FlowerOrderCustomCard onTap behaviour Navigate to my orders details Screen',
      (WidgetTester tester) async {
        //Arrange
        final expectedResult = [
          DriverOrdersDriverRelatedDummy.dummyDriverOrderEntityDriverRelated,
        ];
        final state = DriverOrdersStates(
          driverOrdersLoading: false,
          driverOrdersSuccess: expectedResult,
        );

        when(mockDriverOrdersViewModel.state).thenReturn(state);

        when(
          mockDriverOrdersViewModel.stream,
        ).thenAnswer((_) => Stream.fromIterable([state]));

        tester.binding.window.physicalSizeTestValue = const Size(1080, 1920);
        tester.binding.window.devicePixelRatioTestValue = 1.0;

        await mockNetworkImagesFor(() async {
          await tester.pumpWidget(const TestAppWrapper(child: OrdersScreen()));

          final flowerOrderCustomCardFinder = find.byKey(
            const Key(WidgetsKeys.kDriverOrdersFlowerOrderCustomCard),
          );

          //Act
          await tester.tap(flowerOrderCustomCardFinder);

          await tester.pumpAndSettle();

          //Assert

          expect(find.text("Order details"), findsNWidgets(2));
          expect(find.text("Total"), findsOneWidget);
          expect(find.text("Payment method"), findsOneWidget);
          addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        });
      },
    );
  });
}
