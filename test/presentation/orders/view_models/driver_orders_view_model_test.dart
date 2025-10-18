import 'package:bloc_test/bloc_test.dart' show blocTest;
import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/domain/entites/driver_order_entity_driver_related.dart';
import 'package:elevate_tracking_app/domain/use_cases/get_all_driver_orders_use_case.dart';
import 'package:elevate_tracking_app/presentation/orders/view_models/driver_orders_events.dart';
import 'package:elevate_tracking_app/presentation/orders/view_models/driver_orders_states.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:elevate_tracking_app/presentation/orders/view_models/driver_orders_view_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy/driver_orders_driver_related_dummy.dart';
import 'driver_orders_view_model_test.mocks.dart';

@GenerateMocks([GetAllDriverOrdersUseCase])
void main() {
  late MockGetAllDriverOrdersUseCase mockGetAllDriverOrdersUseCase;
  late DriverOrdersViewModel driverOrdersViewModel;
  late DriverOrdersStates state;
  const errorMsg = "Server Error";
  setUp(() {
    mockGetAllDriverOrdersUseCase = MockGetAllDriverOrdersUseCase();
    driverOrdersViewModel = DriverOrdersViewModel(
      mockGetAllDriverOrdersUseCase,
    );
    state = const DriverOrdersStates();
  });
  group('test DriverOrdersViewModel', () {
    final expectedEntity = [DriverOrdersDriverRelatedDummy.dummyDriverOrderEntityDriverRelated];
    final expectedResult = ApiSuccessResult<List<DriverOrderEntityDriverRelated>>(expectedEntity);
    provideDummy<ApiResult<List<DriverOrderEntityDriverRelated>>>(expectedResult);
    blocTest<DriverOrdersViewModel, DriverOrdersStates>(
      'call doIntent with OnGetAllDriverOrdersEvent then load and successed',
      build: () => driverOrdersViewModel,
      act: (driverOrdersViewModel) async {
        when(
          mockGetAllDriverOrdersUseCase.call(),
        ).thenAnswer((_) async => expectedResult);
        return driverOrdersViewModel.doIntent(OnGetAllDriverOrdersEvent());
      },
      expect: () => [
        state.copyWith(driverOrdersLoading: true),
        state.copyWith(driverOrdersLoading: false, driverOrdersSuccess: expectedEntity),
      ],
       verify: (_) {
        verify(mockGetAllDriverOrdersUseCase.call()).called(1);
      },
    );


    final expectedfailure = ApiErrorResult<List<DriverOrderEntityDriverRelated>>(errorMsg);
    provideDummy<ApiResult<List<DriverOrderEntityDriverRelated>>>(expectedfailure);

    blocTest<DriverOrdersViewModel, DriverOrdersStates>(
      'call doIntent with OnGetAllDriverOrdersEvent then load and failed',
      build: () => driverOrdersViewModel,
      act: (driverOrdersViewModel) async {
        when(
          mockGetAllDriverOrdersUseCase.call(),
        ).thenAnswer((_) async => expectedfailure);
        return driverOrdersViewModel.doIntent(OnGetAllDriverOrdersEvent());
      },
      expect: () => [
        state.copyWith(driverOrdersLoading: true),
        state.copyWith(
          driverOrdersLoading: false,
          driverOrdersErrorMessage: errorMsg,
        ),
      ],
      verify: (_) {
        verify(mockGetAllDriverOrdersUseCase.call()).called(1);
      },
    );
  });
}
