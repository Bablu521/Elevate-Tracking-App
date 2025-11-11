import 'package:bloc_test/bloc_test.dart';
import 'package:elevate_tracking_app/api/mapper/orders_mapper.dart';
import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/domain/entites/order_entity.dart';
import 'package:elevate_tracking_app/domain/entites/pending_orders_entity.dart';
import 'package:elevate_tracking_app/domain/entites/start_order_entity.dart';
import 'package:elevate_tracking_app/domain/use_cases/get_all_pending_orders_use_case.dart';
import 'package:elevate_tracking_app/domain/use_cases/start_order_use_case.dart';
import 'package:elevate_tracking_app/presentation/home/view_model/home_events.dart';
import 'package:elevate_tracking_app/presentation/home/view_model/home_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy/orders_dummy_data.dart';
import 'home_view_model_test.mocks.dart';

@GenerateMocks([GetAllPendingOrdersUseCase, StartOrderUseCase])
void main() {
  final dummyData = OrdersDummyData();

  group("test HomeViewModel", () {
    late MockGetAllPendingOrdersUseCase mockGetAllPendingOrdersUseCase;
    late MockStartOrderUseCase mockStartOrderUseCase;
    late HomeViewModel homeViewModel;
    late HomeState state;
    setUp(() {
      mockGetAllPendingOrdersUseCase = MockGetAllPendingOrdersUseCase();
      mockStartOrderUseCase = MockStartOrderUseCase();
      homeViewModel = HomeViewModel(
        mockGetAllPendingOrdersUseCase,
        mockStartOrderUseCase,
      );
      state = const HomeState();
    });

    group("test GetOrdersEvent", () {
      final expectedEntity = dummyData.pendingOrdersResponse.toEntity();
      final expectedResult = ApiSuccessResult<PendingOrdersEntity>(
        expectedEntity,
      );

      provideDummy<ApiResult<PendingOrdersEntity>>(expectedResult);

      blocTest<HomeViewModel, HomeState>(
        "call doIntent with GetOrdersEvent then load and succeeded",
        build: () => homeViewModel,
        act: (bloc) {
          when(
            mockGetAllPendingOrdersUseCase(),
          ).thenAnswer((_) async => expectedResult);
          return bloc.doIntent(GetOrdersEvent());
        },
        expect: () => <HomeState>[
          const HomeState(isLoading: true),
          state.copyWith(isLoading: false, ordersList: expectedEntity.orders),
        ],
        verify: (_) {
          verify(mockGetAllPendingOrdersUseCase()).called(1);
        },
      );

      final expectedError = "fake-error";
      final expectedErrorResult = ApiErrorResult<PendingOrdersEntity>(
        expectedError,
      );

      provideDummy<ApiResult<PendingOrdersEntity>>(expectedErrorResult);

      blocTest<HomeViewModel, HomeState>(
        "call doIntent with GetOrdersEvent then load and failed",
        build: () => homeViewModel,
        act: (bloc) {
          when(
            mockGetAllPendingOrdersUseCase(),
          ).thenAnswer((_) async => expectedErrorResult);
          return bloc.doIntent(GetOrdersEvent());
        },
        expect: () => <HomeState>[
          const HomeState(isLoading: true),
          state.copyWith(isLoading: false, errorMessage: expectedError),
        ],
        verify: (_) {
          verify(mockGetAllPendingOrdersUseCase()).called(1);
        },
      );
    });

    group("test AcceptOrderEvent", () {
      final expectedIndex = 1;
      final expectedList = dummyData.pendingOrdersResponse.toEntity().orders;
      final expectedEntity = dummyData.startOrderDto.toEntity();
      final expectedUpdatedList = List<OrderEntity>.from(expectedList ?? []);
      expectedUpdatedList.removeAt(expectedIndex);
      final expectedResult = ApiSuccessResult<StartOrderEntity>(expectedEntity);

      provideDummy<ApiResult<StartOrderEntity>>(expectedResult);

      blocTest<HomeViewModel, HomeState>(
        "call doIntent with AcceptOrderEvent then load and succeeded",
        build: () => homeViewModel,
        seed: () => state.copyWith(ordersList: expectedList),
        act: (bloc) {
          when(
            mockStartOrderUseCase(orderId: expectedList![expectedIndex].id),
          ).thenAnswer((_) async => expectedResult);
          return bloc.doIntent(AcceptOrderEvent(expectedIndex));
        },
        expect: () => <HomeState>[
          state.copyWith(
            ordersList: expectedUpdatedList,
            isAcceptSuccess: true,
          ),
        ],
        verify: (_) {
          verify(
            mockStartOrderUseCase(orderId: expectedList![expectedIndex].id),
          ).called(1);
        },
      );

      final expectedError = "fake-error";
      final expectedErrorResult = ApiErrorResult<StartOrderEntity>(
        expectedError,
      );

      provideDummy<ApiResult<StartOrderEntity>>(expectedErrorResult);

      blocTest<HomeViewModel, HomeState>(
        "call doIntent with AcceptOrderEvent then load and failed",
        build: () => homeViewModel,
        seed: () => state.copyWith(ordersList: expectedList),
        act: (bloc) {
          when(
            mockStartOrderUseCase(orderId: expectedList![expectedIndex].id),
          ).thenAnswer((_) async => expectedErrorResult);
          return bloc.doIntent(AcceptOrderEvent(expectedIndex));
        },
        expect: () => <HomeState>[
          state.copyWith(ordersList: expectedList, errorMessage: expectedError),
        ],
        verify: (_) {
          verify(
            mockStartOrderUseCase(orderId: expectedList![expectedIndex].id),
          ).called(1);
        },
      );
    });

    group("test RejectOrderEvent", () {
      final expectedIndex = 1;
      final expectedList = dummyData.pendingOrdersResponse.toEntity().orders;
      final expectedUpdatedList = List<OrderEntity>.from(expectedList ?? []);
      expectedUpdatedList.removeAt(expectedIndex);

      blocTest<HomeViewModel, HomeState>(
        "call doIntent with RejectOrderEvent then load and succeeded",
        build: () => homeViewModel,
        seed: () => state.copyWith(ordersList: expectedList),
        act: (bloc) {
          return bloc.doIntent(RejectOrderEvent(expectedIndex));
        },
        expect: () => <HomeState>[
          state.copyWith(ordersList: expectedUpdatedList),
        ],
      );
    });

    group("test LoadMoreOrdersEvent", () {
      final expectedPageNumber = 2;
      final expectedEntity = dummyData.pendingOrdersResponse.toEntity();
      final expectedUpdatedList = List<OrderEntity>.from(
        expectedEntity.orders ?? [],
      );
      expectedUpdatedList.addAll(expectedEntity.orders ?? []);
      final expectedResult = ApiSuccessResult<PendingOrdersEntity>(
        expectedEntity,
      );

      provideDummy<ApiResult<PendingOrdersEntity>>(expectedResult);

      blocTest<HomeViewModel, HomeState>(
        "call doIntent with LoadMoreOrdersEvent then load and succeeded",
        build: () => homeViewModel,
        seed: () => state.copyWith(ordersList: expectedEntity.orders),
        act: (bloc) {
          when(
            mockGetAllPendingOrdersUseCase(page: expectedPageNumber),
          ).thenAnswer((_) async => expectedResult);
          bloc.currentPage = expectedPageNumber - 1;
          bloc.totalPages = expectedPageNumber + 1;
          return bloc.doIntent(LoadMoreOrdersEvent());
        },
        expect: () => <HomeState>[
          state.copyWith(isLoadingMore: true, ordersList: expectedEntity.orders),
          state.copyWith(isLoadingMore: false, ordersList: expectedUpdatedList),
        ],
        verify: (_) {
          verify(
            mockGetAllPendingOrdersUseCase(page: expectedPageNumber),
          ).called(1);
        },
      );

      final expectedError = "fake-error";
      final expectedErrorResult = ApiErrorResult<PendingOrdersEntity>(
        expectedError,
      );

      provideDummy<ApiResult<PendingOrdersEntity>>(expectedErrorResult);

      blocTest<HomeViewModel, HomeState>(
        "call doIntent with LoadMoreOrdersEvent then load and failed",
        build: () => homeViewModel,
        seed: () => state.copyWith(ordersList: expectedEntity.orders),
        act: (bloc) {
          when(
            mockGetAllPendingOrdersUseCase(page: expectedPageNumber),
          ).thenAnswer((_) async => expectedErrorResult);
          bloc.currentPage = expectedPageNumber - 1;
          bloc.totalPages = expectedPageNumber + 1;
          return bloc.doIntent(LoadMoreOrdersEvent());
        },
        expect: () => <HomeState>[
          state.copyWith(isLoadingMore: true, ordersList: expectedEntity.orders),
          state.copyWith(isLoadingMore: false, ordersList: expectedEntity.orders, errorMessage: expectedError),
        ],
        verify: (_) {
          verify(
            mockGetAllPendingOrdersUseCase(page: expectedPageNumber),
          ).called(1);
        },
      );
    });
  });
}
