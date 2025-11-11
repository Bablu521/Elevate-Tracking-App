import 'package:elevate_tracking_app/api/mapper/orders_mapper.dart';
import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/data/data_source/orders_remote_data_source.dart';
import 'package:elevate_tracking_app/data/repo/orders_repo_impl.dart';
import 'package:elevate_tracking_app/domain/entites/pending_orders_entity.dart';
import 'package:elevate_tracking_app/domain/entites/start_order_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy/orders_dummy_data.dart';
import 'orders_repo_impl_test.mocks.dart';

@GenerateMocks([OrdersRemoteDataSource])
void main() {
  final dummyData = OrdersDummyData();

  group("test OrdersRepoImpl", () {
    late MockOrdersRemoteDataSource mockOrdersRemoteDataSource;
    late OrdersRepoImpl ordersRepoImpl;
    setUp(() {
      mockOrdersRemoteDataSource = MockOrdersRemoteDataSource();
      ordersRepoImpl = OrdersRepoImpl(mockOrdersRemoteDataSource);
    });

    group("test getOrders", () {
      test(
        "when call getOrders should return PendingOrdersEntity with right data",
        () async {
          final expectedEntity = dummyData.pendingOrdersResponse.toEntity();
          final expectedResult = ApiSuccessResult<PendingOrdersEntity>(
            expectedEntity,
          );

          provideDummy<ApiResult<PendingOrdersEntity>>(expectedResult);
          when(
            mockOrdersRemoteDataSource.getOrders(null),
          ).thenAnswer((_) async => expectedResult);

          final result = await ordersRepoImpl.getOrders(null);

          verify(mockOrdersRemoteDataSource.getOrders(null)).called(1);

          expect(result, isA<ApiSuccessResult<PendingOrdersEntity>>());
          result as ApiSuccessResult<PendingOrdersEntity>;
          expect(result.data, expectedEntity);
        },
      );

      test("when getOrders failed should return error result", () async {
        final expectedError = "fake-error";
        final expectedResult = ApiErrorResult<PendingOrdersEntity>(
          expectedError,
        );

        provideDummy<ApiResult<PendingOrdersEntity>>(expectedResult);
        when(
          mockOrdersRemoteDataSource.getOrders(null),
        ).thenAnswer((_) async => expectedResult);

        final result = await ordersRepoImpl.getOrders(null);

        verify(mockOrdersRemoteDataSource.getOrders(null)).called(1);

        expect(result, isA<ApiErrorResult<PendingOrdersEntity>>());
        result as ApiErrorResult<PendingOrdersEntity>;
        expect(result.errorMessage, expectedError);
      });
    });

    group("test startOrder", () {
      test(
        "when call startOrder should return StartOrderEntity with right data",
        () async {
          final expectedOrderId = "fake-order-id";
          final expectedEntity = dummyData.startOrderDto.toEntity();
          final expectedResult = ApiSuccessResult<StartOrderEntity>(
            expectedEntity,
          );

          provideDummy<ApiResult<StartOrderEntity>>(expectedResult);
          when(
            mockOrdersRemoteDataSource.startOrder(expectedOrderId),
          ).thenAnswer((_) async => expectedResult);

          final result = await ordersRepoImpl.startOrder(expectedOrderId);

          verify(
            mockOrdersRemoteDataSource.startOrder(expectedOrderId),
          ).called(1);

          expect(result, isA<ApiSuccessResult<StartOrderEntity>>());
          result as ApiSuccessResult<StartOrderEntity>;
          expect(result.data, expectedEntity);
        },
      );

      test("when startOrder failed should return error result", () async {
        final expectedOrderId = "fake-order-id";
        final expectedError = "fake-error";
        final expectedResult = ApiErrorResult<StartOrderEntity>(expectedError);

        provideDummy<ApiResult<StartOrderEntity>>(expectedResult);
        when(
          mockOrdersRemoteDataSource.startOrder(expectedOrderId),
        ).thenAnswer((_) async => expectedResult);

        final result = await ordersRepoImpl.startOrder(expectedOrderId);

        verify(
          mockOrdersRemoteDataSource.startOrder(expectedOrderId),
        ).called(1);

        expect(result, isA<ApiErrorResult<StartOrderEntity>>());
        result as ApiErrorResult<StartOrderEntity>;
        expect(result.errorMessage, expectedError);
      });
    });
  });
}
