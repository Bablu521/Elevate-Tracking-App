import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/core/base_state/base_state.dart';
import 'package:elevate_tracking_app/domain/entites/apply_response_entity.dart';
import 'package:elevate_tracking_app/domain/entites/request/apply_request_entity.dart';
import 'package:elevate_tracking_app/domain/use_cases/apply_use_case.dart';
import 'package:elevate_tracking_app/domain/use_cases/get_all_country_use_case.dart';
import 'package:elevate_tracking_app/domain/use_cases/get_all_vehicles_use_case.dart';
import 'package:elevate_tracking_app/presentation/apply/view_model/apply_event.dart';
import 'package:elevate_tracking_app/presentation/apply/view_model/apply_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../fixture/apply_fixture.dart';
import 'apply_view_model_state_test.mocks.dart';

@GenerateMocks([GetAllCountryUseCase, ApplyUseCase, GetAllVehiclesUseCase])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockGetAllCountryUseCase mockGetAllCountryUseCase;
  late MockGetAllVehiclesUseCase mockGetAllVehiclesUseCase;
  late MockApplyUseCase mockApplyUseCase;
  late ApplyViewModelState state;
  late ApplyViewModel viewModel;
  final ApplyResponseEntity responseEntity = ApplyFixture.fakeResponseEntity();

  final DioException dioException = DioException(
    requestOptions: RequestOptions(),
    message: "An unexpected error occurred: DioError",
  );

  setUp(() {
    mockApplyUseCase = MockApplyUseCase();
    mockGetAllVehiclesUseCase = MockGetAllVehiclesUseCase();
    mockGetAllCountryUseCase = MockGetAllCountryUseCase();
    viewModel = ApplyViewModel(
      mockGetAllVehiclesUseCase,
      mockGetAllCountryUseCase,
      mockApplyUseCase,
    );
    provideDummy<ApiResult<ApplyResponseEntity>>(
      ApiSuccessResult(responseEntity),
    );
    provideDummy<ApiResult<ApplyResponseEntity>>(ApiErrorResult(dioException));
    state = const ApplyViewModelState();
  });

  group("Test Apply Function", () {
    blocTest<ApplyViewModel, ApplyViewModelState>(
      "test apply function emit success",
      build: () {
        when(
          mockApplyUseCase.call(any),
        ).thenAnswer((_) async => ApiSuccessResult(responseEntity));
        return viewModel;
      },
      act: (cubit) => cubit.doIntent(ApplySendDataEvent()),
      expect: () => [
        state.copyWith(applyFun: BaseState.loading()),
        state.copyWith(applyFun: BaseState.success(responseEntity)),
      ],
    );
    blocTest<ApplyViewModel, ApplyViewModelState>(
      "test apply function emit Failure",
      build: () {
        when(
          mockApplyUseCase.call(any),
        ).thenAnswer((_) async => ApiErrorResult(dioException));
        return viewModel;
      },
      act: (cubit) => cubit.doIntent(ApplySendDataEvent()),
      expect: () => [
        state.copyWith(applyFun: BaseState.loading()),
        isA<ApplyViewModelState>().having(
          (s) => s.applyFun?.errorMessage,
          "error",
          contains(dioException.message),
        ),
      ],
    );
  });
}
