import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/core/base_state/base_state.dart';
import 'package:elevate_tracking_app/domain/entites/driver_entity.dart';
import 'package:elevate_tracking_app/domain/entites/vehicle_entity.dart';
import 'package:elevate_tracking_app/domain/use_cases/get_all_vehicles_use_case.dart';
import 'package:elevate_tracking_app/domain/use_cases/update_vehicle_use_case.dart';
import 'package:elevate_tracking_app/presentation/profile/view_models/edit_vehicle_view_model/edit_vehicle_event.dart';
import 'package:elevate_tracking_app/presentation/profile/view_models/edit_vehicle_view_model/edit_vehicle_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy/profile_info_dummy.dart';
import 'edit_vehicle_view_model_test.mocks.dart';

@GenerateMocks([GetAllVehiclesUseCase, UpdateVehicleUseCase])
void main() {
  group("test EditVehicleViewModel", () {
    late MockGetAllVehiclesUseCase getAllVehiclesUseCase;
    late MockUpdateVehicleUseCase updateVehicleUseCase;
    late EditVehicleViewModelState state;
    late EditVehicleViewModel viewModel;
    final DriverEntity driverEntity = ProfileInfoDummy.dummyDriverEntityFake;
    final DioException dioException = DioException(
      requestOptions: RequestOptions(),
      error: "fake_dio_error",
      message: "fake_dio",
    );

    setUp(() {
      getAllVehiclesUseCase = MockGetAllVehiclesUseCase();
      updateVehicleUseCase = MockUpdateVehicleUseCase();
      state = const EditVehicleViewModelState();
      viewModel = EditVehicleViewModel(
        getAllVehiclesUseCase,
        updateVehicleUseCase,
      );

      provideDummy<ApiResult<DriverEntity>>(
        ApiSuccessResult<DriverEntity>(driverEntity),
      );
      provideDummy<ApiResult<DriverEntity>>(
        ApiErrorResult<DriverEntity>(dioException),
      );
      provideDummy<ApiResult<List<VehicleEntity>>>(
        ApiSuccessResult<List<VehicleEntity>>([]),
      );
      provideDummy<ApiResult<List<VehicleEntity>>>(
        ApiErrorResult<List<VehicleEntity>>(dioException),
      );
    });

    group("test update vehicle info", () {
      blocTest(
        "update vehicle info emit success",
        build: () {
          when(updateVehicleUseCase.call(any)).thenAnswer(
            (_) async => ApiSuccessResult<DriverEntity>(driverEntity),
          );
          return viewModel;
        },
        act: (bloc) => viewModel.doIntent(EditVehiclePickUpdateDataEvent()),
        expect: () => [
          state.copyWith(updateData: BaseState.loading()),
          state.copyWith(updateData: BaseState.success(driverEntity)),
        ],
        verify: (_) => verify(updateVehicleUseCase.call(any)).called(1),
      );
      blocTest(
        "update vehicle info emit failure",
        build: () {
          when(
            updateVehicleUseCase.call(any),
          ).thenAnswer((_) async => ApiErrorResult<DriverEntity>(dioException));
          return viewModel;
        },
        act: (bloc) => viewModel.doIntent(EditVehiclePickUpdateDataEvent()),
        expect: () => [
          state.copyWith(updateData: BaseState.loading()),
          state.copyWith(
            updateData: BaseState.error(
              "An unexpected error occurred: fake_dio",
            ),
          ),
        ],
        verify: (_) => verify(updateVehicleUseCase.call(any)).called(1),
      );
    });
    group("test get all data", () {
      blocTest(
        "get all vehicle emit success",
        build: () {
          when(
            getAllVehiclesUseCase.call(),
          ).thenAnswer((_) async => ApiSuccessResult<List<VehicleEntity>>([]));
          return viewModel;
        },
        act: (bloc) => viewModel.doIntent(
          EditVehicleInitializeAllDataEvent(vehicleId: ''),
        ),
        expect: () => [
          state.copyWith(allVehicleList: BaseState.loading()),
          state.copyWith(allVehicleList: BaseState.success([])),
        ],
        verify: (_) => verify(getAllVehiclesUseCase.call()).called(1),
      );
      blocTest(
        "get all vehicle emit failure",
        build: () {
          when(getAllVehiclesUseCase.call()).thenAnswer(
            (_) async => ApiErrorResult<List<VehicleEntity>>(dioException),
          );
          return viewModel;
        },
        act: (bloc) => viewModel.doIntent(
          EditVehicleInitializeAllDataEvent(vehicleId: ''),
        ),
        expect: () => [
          state.copyWith(allVehicleList: BaseState.loading()),
          state.copyWith(
            allVehicleList: BaseState.error(
              "An unexpected error occurred: fake_dio",
            ),
          ),
        ],
        verify: (_) => verify(getAllVehiclesUseCase.call()).called(1),
      );
    });
  });
}
