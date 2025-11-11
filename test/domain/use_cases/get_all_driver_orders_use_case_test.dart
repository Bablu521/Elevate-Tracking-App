import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/domain/entites/driver_order_entity_driver_related.dart';
import 'package:elevate_tracking_app/domain/repo/orders_repo.dart';
import 'package:elevate_tracking_app/domain/use_cases/get_all_driver_orders_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy/driver_orders_driver_related_dummy.dart';
import 'get_all_driver_orders_use_case_test.mocks.dart';

@GenerateMocks([OrdersRepo])
void main() {
  late MockOrdersRepo mockOrdersRepo;
  late GetAllDriverOrdersUseCase getAllDriverOrdersUseCase;
  setUp(() {
    mockOrdersRepo = MockOrdersRepo();
    getAllDriverOrdersUseCase = GetAllDriverOrdersUseCase(mockOrdersRepo);
  });
  group("test GetAllDriverOrdersUseCase", () {
    test(
      "when call it should return DriverOrderEntityDriverRelated from repo with correct parameters",
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
          mockOrdersRepo.getAllDriverOrders(),
        ).thenAnswer((_) async => expectedResult);

        //Act
        final result = await getAllDriverOrdersUseCase.call();

        //Assert
        verify(mockOrdersRepo.getAllDriverOrders()).called(1);
        expect(result, isA<ApiSuccessResult<List<DriverOrderEntityDriverRelated>>>());
        result as ApiSuccessResult<List<DriverOrderEntityDriverRelated>>;
        expect(result.data.length, expectedEntity.length);
        expect(result.data[0], expectedEntity[0]);
      },
    );

    test(
      "when call failed it should return an error result",
      () async {
        //Arrange
        final expectedError = "Server-Error"; 
        final expectedResult = ApiErrorResult<List<DriverOrderEntityDriverRelated>>(expectedError);
        provideDummy<ApiResult<List<DriverOrderEntityDriverRelated>>>(
          expectedResult,
        );
        when(
          mockOrdersRepo.getAllDriverOrders(),
        ).thenAnswer((_) async => expectedResult);

        //Act
        final result = await getAllDriverOrdersUseCase.call();

        //Assert
        verify(mockOrdersRepo.getAllDriverOrders()).called(1);
        expect(
          result,
          isA<ApiErrorResult<List<DriverOrderEntityDriverRelated>>>(),
        );
        result as ApiErrorResult<List<DriverOrderEntityDriverRelated>>;
        expect(result.errorMessage, expectedError);
      },
    );
  });
}
