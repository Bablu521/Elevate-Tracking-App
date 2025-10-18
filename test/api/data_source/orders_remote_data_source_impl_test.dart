import 'package:elevate_tracking_app/api/client/api_client.dart';
import 'package:elevate_tracking_app/api/data_source/orders_remote_data_source_impl.dart';
import 'package:elevate_tracking_app/api/mapper/orders_mapper.dart';
import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/domain/entities/pending_orders_entity.dart';
import 'package:elevate_tracking_app/domain/entities/start_order_entity.dart';
import 'package:elevate_tracking_app/api/mapper/driver_orders_driver_related_mapper.dart';
import 'package:elevate_tracking_app/domain/entites/driver_order_entity_driver_related.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../dummy/orders_dummy_data.dart';
import '../../dummy/driver_orders_driver_related_dummy.dart';
import 'orders_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  final dummyData = OrdersDummyData();

  group("test OrdersRemoteDataSourceImpl", () {
    late MockApiClient mockApiClient;
    late OrdersRemoteDataSourceImpl dataSource;

    setUp(() {
      mockApiClient = MockApiClient();
      dataSource = OrdersRemoteDataSourceImpl(mockApiClient);
    });

    group("test getOrders", () {
      test(
        "when call getOrders should return PendingOrdersEntity with right data",
        () async {
          final expectedResult = dummyData.ordersResponse;
          when(
            mockApiClient.getOrders(null),
          ).thenAnswer((_) async => expectedResult);

          final result = await dataSource.getOrders(null);

          verify(mockApiClient.getOrders(null)).called(1);

          expect(result, isA<ApiSuccessResult<PendingOrdersEntity>>());
          result as ApiSuccessResult<PendingOrdersEntity>;
          expect(result.data, expectedResult.toEntity());
        },
      );

      test("when getOrders failed should return error result", () async {
        final expectedError = "fake-error";
        when(mockApiClient.getOrders(null)).thenThrow(Exception(expectedError));
        final result = await dataSource.getOrders(null);
        verify(mockApiClient.getOrders(null)).called(1);
        expect(result, isA<ApiErrorResult<PendingOrdersEntity>>());
        result as ApiErrorResult<PendingOrdersEntity>;
        expect(result.errorMessage, contains(expectedError));
      });
    });

    group("test startOrder", () {
      test(
        "when call startOrder should return StartOrderEntity with right data",
        () async {
          final expectedOrderId = "fake-order-id";
          final expectedResult = dummyData.startOrderResponse;
          when(
            mockApiClient.startOrder(expectedOrderId),
          ).thenAnswer((_) async => expectedResult);

          final result = await dataSource.startOrder(expectedOrderId);

          verify(mockApiClient.startOrder(expectedOrderId)).called(1);

          expect(result, isA<ApiSuccessResult<StartOrderEntity>>());
          result as ApiSuccessResult<StartOrderEntity>;
          expect(result.data, expectedResult.orders?.toEntity());
        },
      );

      test("when startOrder failed should return error result", () async {
        final expectedOrderId = "fake-order-id";
        final expectedError = "fake-error";
        when(
          mockApiClient.startOrder(expectedOrderId),
        ).thenThrow(Exception(expectedError));
        final result = await dataSource.startOrder(expectedOrderId);
        verify(mockApiClient.startOrder(expectedOrderId)).called(1);
        expect(result, isA<ApiErrorResult<StartOrderEntity>>());
        result as ApiErrorResult<StartOrderEntity>;
        expect(result.errorMessage, contains(expectedError));
      });
    });

    group("test getAllDriverOrders", () {
      test(
        "when call it should return DriverOrdersResponseDtoDriverRelated from api with correct parameters",
        () async {
          //Arrange
          final expectedResult = DriverOrdersDriverRelatedDummy
              .dummyDriverOrdersResponseDtoDriverRelated;
          when(
            mockApiClient.getAllDriverOrders(),
          ).thenAnswer((_) async => expectedResult);

          //Act
          final result = await dataSource.getAllDriverOrders();

          //Assert
          verify(mockApiClient.getAllDriverOrders()).called(1);
          expect(
            result,
            isA<ApiSuccessResult<List<DriverOrderEntityDriverRelated>>>(),
          );
          result as ApiSuccessResult<List<DriverOrderEntityDriverRelated>>;
          expect(
            result.data.length,
            expectedResult.orders!.map((e) => e.toEntity()).toList().length,
          );
          expect(
            result.data[0],
            expectedResult.orders!.map((e) => e.toEntity()).toList()[0],
          );
        },
      );

      test("when call failed it should return an error result", () async {
        //Arrange
        final expectedError = "Server-Error";
        when(
          mockApiClient.getAllDriverOrders(),
        ).thenThrow(Exception(expectedError));

        //Act
        final result = await dataSource.getAllDriverOrders();

        //Assert
        verify(mockApiClient.getAllDriverOrders()).called(1);
        expect(
          result,
          isA<ApiErrorResult<List<DriverOrderEntityDriverRelated>>>(),
        );
        result as ApiErrorResult<List<DriverOrderEntityDriverRelated>>;
        expect(result.errorMessage, contains(expectedError));
      });
    });
  });
}
