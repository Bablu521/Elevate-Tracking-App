import 'dart:async';

import 'package:elevate_tracking_app/api/mapper/orders_mapper.dart';
import 'package:elevate_tracking_app/api/models/order_dto.dart';
import 'package:elevate_tracking_app/core/custom_widget/custom_cached_network_image.dart';
import 'package:elevate_tracking_app/core/custom_widget/test_app_wrapper.dart';
import 'package:elevate_tracking_app/core/di/di.dart';
import 'package:elevate_tracking_app/domain/entities/order_entity.dart';
import 'package:elevate_tracking_app/generated/l10n.dart';
import 'package:elevate_tracking_app/presentation/home/view/screen/home_page.dart';
import 'package:elevate_tracking_app/presentation/home/view/widget/home_order_card.dart';
import 'package:elevate_tracking_app/presentation/home/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy/orders_dummy_data.dart';
import 'home_page_test.mocks.dart';

@GenerateMocks([HomeViewModel])
void main() {
  final dummyData = OrdersDummyData();

  group("widget test HomePage", () {
    late MockHomeViewModel mockHomeViewModel;
    late StreamController<HomeState> stateController;
    late ValueNotifier<int> mockAcceptOrderIndex;
    late ValueNotifier<int> mockRejectOrderIndex;

    setUpAll(() async {
      mockHomeViewModel = MockHomeViewModel();
      configureDependencies();
      await getIt.unregister<HomeViewModel>();
      getIt.registerSingleton<HomeViewModel>(mockHomeViewModel);
    });

    setUp(() {
      stateController = StreamController();
      mockAcceptOrderIndex = ValueNotifier(-1);
      mockRejectOrderIndex = ValueNotifier(-1);

      when(mockHomeViewModel.acceptOrderIndex).thenReturn(mockAcceptOrderIndex);
      when(mockHomeViewModel.rejectOrderIndex).thenReturn(mockRejectOrderIndex);

      final state = const HomeState(isLoading: true);
      provideDummy<HomeState>(state);

      when(mockHomeViewModel.state).thenReturn(state);
      when(mockHomeViewModel.stream).thenAnswer((_) => stateController.stream);
    });

    testWidgets("Verify HomePage structure", (tester) async {
      await tester.pumpWidget(const TestAppWrapper(child: HomePage()));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      final expectedResult = dummyData.pendingOrdersResponse.toEntity();

      final state = HomeState(
        isLoading: false,
        ordersList: expectedResult.orders,
      );
      provideDummy<HomeState>(state);

      when(mockHomeViewModel.state).thenReturn(state);
      stateController.add(state);

      await tester.pump();

      expect(find.byType(ListView), findsOneWidget);

      expect(find.byType(HomeOrderCard), findsAtLeast(1));

      expect(find.byKey(Key(expectedResult.orders![0].id!)), findsOneWidget);

      expect(find.byType(CustomCachedNetworkImage), findsAtLeast(1));

      expect(find.byType(Image), findsAtLeast(1));

      expect(find.byType(ElevatedButton), findsAtLeast(2));

      expect(find.text(AppLocalizations().floweryRider), findsAtLeast(1));

      expect(find.text(AppLocalizations().flowerOrder), findsAtLeast(1));

      expect(find.text(AppLocalizations().pickupAddress), findsAtLeast(1));

      expect(find.text(AppLocalizations().userAddress), findsAtLeast(1));

      expect(
        find.text(expectedResult.orders![0].store!.name!),
        findsAtLeast(1),
      );
      expect(
        find.text(expectedResult.orders![0].store!.address!),
        findsAtLeast(1),
      );
      expect(
        find.text(expectedResult.orders![0].user!.firstName!),
        findsAtLeast(1),
      );
      expect(
        find.text(
          "${expectedResult.orders![0].shippingAddress!.street!}, ${expectedResult.orders![0].shippingAddress!.city!}",
        ),
        findsAtLeast(1),
      );
      expect(
        find.text(
          "${AppLocalizations().egp} ${expectedResult.orders![0].totalPrice!}",
        ),
        findsAtLeast(1),
      );

      expect(find.text(AppLocalizations().reject), findsAtLeast(1));

      expect(find.text(AppLocalizations().accept), findsAtLeast(1));

      stateController.close();
    });

    testWidgets("Verify loading and empty state behaviour", (tester) async {
      await tester.pumpWidget(const TestAppWrapper(child: HomePage()));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      final state = const HomeState(isLoading: false, ordersList: []);
      provideDummy<HomeState>(state);

      when(mockHomeViewModel.state).thenReturn(state);
      stateController.add(state);

      await tester.pump();

      expect(find.text(AppLocalizations().noOrders), findsOneWidget);

      stateController.close();
    });

    testWidgets("Verify listView loadMore behaviour", (tester) async {
      final expectedEntity = dummyData.pendingOrdersResponse.toEntity();

      final loadState = HomeState(isLoading: false, ordersList: expectedEntity.orders!);
      provideDummy<HomeState>(loadState);

      when(mockHomeViewModel.state).thenReturn(loadState);
      stateController.add(loadState);

      await tester.pumpWidget(const TestAppWrapper(child: HomePage()));

      expect(find.byKey(Key(expectedEntity.orders![0].id!)), findsOneWidget);

      final expectedLastItemId = "expectedId";
      final List<OrderEntity> loadMoreList = [
        ...expectedEntity.orders!,
        ...expectedEntity.orders!,
      ];

      loadMoreList.add(
        OrderDTO(
          id: expectedLastItemId,
          user: dummyData.userDTO1,
          orderItems: [dummyData.orderItemDTO1, dummyData.orderItemDTO2],
          totalPrice: 55,
          shippingAddress: dummyData.shippingAddressDTO1,
          paymentType: 'Credit Card',
          isPaid: true,
          isDelivered: false,
          state: 'Preparing',
          createdAt: DateTime.now()
              .subtract(const Duration(hours: 1))
              .toIso8601String(),
          updatedAt: DateTime.now().toIso8601String(),
          orderNumber: "1001",
          v: 1,
          store: dummyData.storeDTO1,
        ).toEntity(),
      );

      final loadMoreState = HomeState(isLoading: false, ordersList: loadMoreList);
      provideDummy<HomeState>(loadMoreState);

      when(mockHomeViewModel.state).thenReturn(loadMoreState);
      stateController.add(loadMoreState);

      final lastItemFinder = find.byKey(Key(expectedLastItemId));

      expect(lastItemFinder, findsNothing);

      await tester.scrollUntilVisible(
        lastItemFinder,
        100.0,
        scrollable: find.byType(Scrollable),
      );

      await tester.pump();

      expect(lastItemFinder, findsOneWidget);

      stateController.close();
    });

    testWidgets("Verify listView item behaviour", (tester) async {
      final expectedResult = dummyData.pendingOrdersResponse.toEntity().orders!;

      final state = HomeState(
        isLoading: false,
        ordersList: expectedResult,
      );
      provideDummy<HomeState>(state);

      when(mockHomeViewModel.state).thenReturn(state);
      stateController.add(state);

      await tester.pumpWidget(const TestAppWrapper(child: HomePage()));

      final firstItemFinder = find.byKey(Key(expectedResult[0].id!));
      expect(firstItemFinder, findsOneWidget);

      final textFinder = find.descendant(
        of: firstItemFinder,
        matching: find.byType(Text),
      );
      expect(textFinder, findsNWidgets(10));

      final imageFinder = find.descendant(
        of: firstItemFinder,
        matching: find.byType(Image),
      );
      expect(imageFinder, findsNWidgets(4));

      final buttonFinder = find.descendant(
        of: firstItemFinder,
        matching: find.byType(ElevatedButton),
      );
      expect(buttonFinder, findsNWidgets(2));

      final loadingFinder = find.descendant(
        of: firstItemFinder,
        matching: find.byType(CircularProgressIndicator),
      );
      expect(loadingFinder, findsNWidgets(2));

      mockAcceptOrderIndex.value = 0;
      mockRejectOrderIndex.value = 0;

      await tester.pump();

      expect(buttonFinder, findsNWidgets(0));

      //there are tow loading widget for images
      expect(loadingFinder, findsNWidgets(4));

      stateController.close();
    });
  });
}
