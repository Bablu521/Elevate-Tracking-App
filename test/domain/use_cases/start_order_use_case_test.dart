import 'package:elevate_tracking_app/api/mapper/orders_mapper.dart';
import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/domain/entities/start_order_entity.dart';
import 'package:elevate_tracking_app/domain/repo/orders_repo.dart';
import 'package:elevate_tracking_app/domain/use_cases/start_order_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy/orders_dummy_data.dart';
import 'start_order_use_case_test.mocks.dart';

@GenerateMocks([OrdersRepo])
void main() {
  final dummyData = OrdersDummyData();

  group("test StartOrderUseCase", () {
    late MockOrdersRepo mockOrdersRepo;
    late StartOrderUseCase startOrderUseCase;
    setUp(() {
      mockOrdersRepo = MockOrdersRepo();
      startOrderUseCase = StartOrderUseCase(mockOrdersRepo);
    });

    test("when call should return StartOrderEntity with right data", () async {
      final expectedOrderId = "fake-order-id";
      final expectedEntity = dummyData.startOrderDto.toEntity();
      final expectedResult = ApiSuccessResult<StartOrderEntity>(expectedEntity);

      provideDummy<ApiResult<StartOrderEntity>>(expectedResult);
      when(
        mockOrdersRepo.startOrder(expectedOrderId),
      ).thenAnswer((_) async => expectedResult);

      final result = await startOrderUseCase(orderId: expectedOrderId);

      verify(mockOrdersRepo.startOrder(expectedOrderId)).called(1);

      expect(result, isA<ApiSuccessResult<StartOrderEntity>>());
      result as ApiSuccessResult<StartOrderEntity>;
      expect(result.data, expectedEntity);
    });

    test("when call failed should return error result", () async {
      final expectedOrderId = "fake-order-id";
      final expectedError = "fake-error";
      final expectedResult = ApiErrorResult<StartOrderEntity>(expectedError);

      provideDummy<ApiResult<StartOrderEntity>>(expectedResult);
      when(
        mockOrdersRepo.startOrder(expectedOrderId),
      ).thenAnswer((_) async => expectedResult);

      final result = await startOrderUseCase(orderId: expectedOrderId);

      verify(mockOrdersRepo.startOrder(expectedOrderId)).called(1);

      expect(result, isA<ApiErrorResult<StartOrderEntity>>());
      result as ApiErrorResult<StartOrderEntity>;
      expect(result.errorMessage, expectedError);
    });
  });
}
