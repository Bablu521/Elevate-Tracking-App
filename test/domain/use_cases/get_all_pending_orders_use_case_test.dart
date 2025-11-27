import 'package:elevate_tracking_app/api/mapper/orders_mapper.dart';
import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/domain/entites/pending_orders_entity.dart';
import 'package:elevate_tracking_app/domain/repo/orders_repo.dart';
import 'package:elevate_tracking_app/domain/use_cases/get_all_pending_orders_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy/orders_dummy_data.dart';
import 'get_all_pending_orders_use_case_test.mocks.dart';

@GenerateMocks([OrdersRepo])
void main() {
  final dummyData = OrdersDummyData();

  group("test GetAllPendingOrdersUseCase", () {
    late MockOrdersRepo mockOrdersRepo;
    late GetAllPendingOrdersUseCase getAllPendingOrdersUseCase;
    setUp(() {
      mockOrdersRepo = MockOrdersRepo();
      getAllPendingOrdersUseCase = GetAllPendingOrdersUseCase(mockOrdersRepo);
    });

    test(
      "when call should return PendingOrdersEntity with right data",
      () async {
        final expectedEntity = dummyData.pendingOrdersResponse.toEntity();
        final expectedResult = ApiSuccessResult<PendingOrdersEntity>(
          expectedEntity,
        );

        provideDummy<ApiResult<PendingOrdersEntity>>(expectedResult);
        when(
          mockOrdersRepo.getOrders(null),
        ).thenAnswer((_) async => expectedResult);

        final result = await getAllPendingOrdersUseCase(page: null);

        verify(mockOrdersRepo.getOrders(null)).called(1);

        expect(result, isA<ApiSuccessResult<PendingOrdersEntity>>());
        result as ApiSuccessResult<PendingOrdersEntity>;
        expect(result.data, expectedEntity);
      },
    );

    test("when call failed should return error result", () async {
      final expectedError = "fake-error";
      final expectedResult = ApiErrorResult<PendingOrdersEntity>(expectedError);

      provideDummy<ApiResult<PendingOrdersEntity>>(expectedResult);
      when(
        mockOrdersRepo.getOrders(null),
      ).thenAnswer((_) async => expectedResult);

      final result = await getAllPendingOrdersUseCase(page: null);

      verify(mockOrdersRepo.getOrders(null)).called(1);

      expect(result, isA<ApiErrorResult<PendingOrdersEntity>>());
      result as ApiErrorResult<PendingOrdersEntity>;
      expect(result.errorMessage, expectedError);
    });
  });
}
