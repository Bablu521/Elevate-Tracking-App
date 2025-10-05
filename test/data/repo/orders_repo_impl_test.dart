
import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/data/data_source/orders_remote_data_source.dart';
import 'package:elevate_tracking_app/data/repo/orders_repo_impl.dart';
import 'package:elevate_tracking_app/domain/entites/driver_order_entity_driver_related.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy/driver_orders_driver_related_dummy.dart';
import 'orders_repo_impl_test.mocks.dart';

@GenerateMocks([OrdersRemoteDataSource])
void main() {
  late MockOrdersRemoteDataSource mockOrdersRemoteDataSource;
  late OrdersRepoImpl ordersRepoImpl;
  setUp(() {
    mockOrdersRemoteDataSource = MockOrdersRemoteDataSource();
    ordersRepoImpl = OrdersRepoImpl(mockOrdersRemoteDataSource);
  });
  group("test getAllDriverOrders", () {
    test(
      "when call it should return DriverOrderEntityDriverRelated from data source with correct parameters",
      () async {
        //Arrange
        final expectedEntity = [
          DriverOrdersDriverRelatedDummy.dummyDriverOrderEntityDriverRelated,
        ];
        final expectedResult = ApiSuccessResult(expectedEntity);
        provideDummy<ApiResult<List<DriverOrderEntityDriverRelated>>>(
          expectedResult,
        );
        when(
          mockOrdersRemoteDataSource.getAllDriverOrders(),
        ).thenAnswer((_) async => expectedResult);

        //Act
        final result = await ordersRepoImpl.getAllDriverOrders();

        //Assert
        verify(mockOrdersRemoteDataSource.getAllDriverOrders()).called(1);
        expect(
          result,
          isA<ApiSuccessResult<List<DriverOrderEntityDriverRelated>>>(),
        );
        result as ApiSuccessResult<List<DriverOrderEntityDriverRelated>>;
        expect(result.data.length, expectedEntity.length);
        expect(result.data[0], expectedEntity[0]);
      },
    );

    test("when call failed it should return an error result", () async {
      //Arrange
      final expectedError = "Server-Error";
      final expectedResult =
          ApiErrorResult<List<DriverOrderEntityDriverRelated>>(expectedError);
      provideDummy<ApiResult<List<DriverOrderEntityDriverRelated>>>(
        expectedResult,
      );
      when(
        mockOrdersRemoteDataSource.getAllDriverOrders(),
      ).thenAnswer((_) async => expectedResult);

      //Act
      final result = await ordersRepoImpl.getAllDriverOrders();

      //Assert
      verify(mockOrdersRemoteDataSource.getAllDriverOrders()).called(1);
      expect(
        result,
        isA<ApiErrorResult<List<DriverOrderEntityDriverRelated>>>(),
      );
      result as ApiErrorResult<List<DriverOrderEntityDriverRelated>>;
      expect(result.errorMessage, expectedError);
    });
  });
}
