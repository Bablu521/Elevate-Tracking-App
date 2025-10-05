import 'package:elevate_tracking_app/api/client/api_client.dart';
import 'package:elevate_tracking_app/api/data_source/orders_remote_data_source_impl.dart';
import 'package:elevate_tracking_app/api/mapper/driver_orders_driver_related_mapper.dart';
import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/domain/entites/driver_order_entity_driver_related.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy/driver_orders_driver_related_dummy.dart';
import 'orders_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  late MockApiClient mockApiClient;
  late OrdersRemoteDataSourceImpl ordersRemoteDataSourceImpl;

  setUp(() {
    mockApiClient = MockApiClient();
    ordersRemoteDataSourceImpl = OrdersRemoteDataSourceImpl(mockApiClient);
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
        final result = await ordersRemoteDataSourceImpl.getAllDriverOrders();

        //Assert
        verify(mockApiClient.getAllDriverOrders()).called(1);
        expect(result, isA<ApiSuccessResult<List<DriverOrderEntityDriverRelated>>>());
        result as ApiSuccessResult<List<DriverOrderEntityDriverRelated>>;
        expect(
          result.data.length,
          expectedResult.orders!.map((e) => e.toEntity()).toList().length,
        );
        expect(result.data[0], expectedResult.orders!.map((e) => e.toEntity()).toList()[0]);
      },
    );

    test(
      "when call failed it should return an error result",
      () async {
        //Arrange
        final expectedError = "Server-Error";
        when(
          mockApiClient.getAllDriverOrders(),
        ).thenThrow(Exception(expectedError));

        //Act
        final result = await ordersRemoteDataSourceImpl.getAllDriverOrders();

        //Assert
        verify(mockApiClient.getAllDriverOrders()).called(1);
        expect(
          result,
          isA<ApiErrorResult<List<DriverOrderEntityDriverRelated>>>(),
        );
        result as ApiErrorResult<List<DriverOrderEntityDriverRelated>>;
        expect(
          result.errorMessage,
          contains(expectedError),
        );
      },
    );
  });
}
