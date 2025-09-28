import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/core/base_state/base_state.dart';
import 'package:elevate_tracking_app/domain/entites/apply_response_entity.dart';
import 'package:elevate_tracking_app/domain/entites/country_entity.dart';
import 'package:elevate_tracking_app/domain/entites/vehicles_entity.dart';
import 'package:elevate_tracking_app/domain/use_cases/apply_use_case.dart';
import 'package:elevate_tracking_app/domain/use_cases/get_all_country_use_case.dart';
import 'package:elevate_tracking_app/domain/use_cases/get_all_vehicles_use_case.dart';
import 'package:elevate_tracking_app/presentation/apply/view_model/apply_event.dart';
import 'package:elevate_tracking_app/presentation/apply/view_model/apply_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy/apply_fixture.dart';
import '../../../dummy/fake_image_file.dart';
import 'apply_view_model_state_test.mocks.dart';

@GenerateMocks([
  GetAllCountryUseCase,
  ApplyUseCase,
  GetAllVehiclesUseCase,
  ImagePicker,
  XFile,
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockGetAllCountryUseCase mockGetAllCountryUseCase;
  late MockGetAllVehiclesUseCase mockGetAllVehiclesUseCase;
  late MockApplyUseCase mockApplyUseCase;
  late ApplyViewModelState state;
  late ApplyViewModel viewModel;
  late MockImagePicker mockPicker;
  final ApplyResponseEntity applyResponseEntity =
      ApplyFixture.fakeResponseEntity();
  final List<VehicleEntity> vehicleResponseEntity =
      ApplyFixture.fakeVehicleEntity();
  final List<CountryEntity> countryResponseEntity =
      ApplyFixture.fakeCountryEntityList();

  final DioException dioException = DioException(
    requestOptions: RequestOptions(),
    message: "An unexpected error occurred: DioError",
  );

  setUp(() {
    mockPicker = MockImagePicker();
    mockApplyUseCase = MockApplyUseCase();
    mockGetAllVehiclesUseCase = MockGetAllVehiclesUseCase();
    mockGetAllCountryUseCase = MockGetAllCountryUseCase();
    viewModel = ApplyViewModel(
      mockGetAllVehiclesUseCase,
      mockGetAllCountryUseCase,
      mockApplyUseCase,
    );
    provideDummy<ApiResult<ApplyResponseEntity>>(
      ApiSuccessResult(applyResponseEntity),
    );
    provideDummy<ApiResult<ApplyResponseEntity>>(ApiErrorResult(dioException));
    state = const ApplyViewModelState();
    provideDummy<ApiResult<List<VehicleEntity>>>(
      ApiSuccessResult(vehicleResponseEntity),
    );
    provideDummy<ApiResult<List<VehicleEntity>>>(ApiErrorResult(dioException));
    provideDummy<ApiResult<List<CountryEntity>>>(
      ApiSuccessResult(countryResponseEntity),
    );
    provideDummy<ApiResult<List<CountryEntity>>>(ApiErrorResult(dioException));
  });

  group("Test Apply Function", () {
    blocTest<ApplyViewModel, ApplyViewModelState>(
      "test apply function emit success",
      build: () {
        when(
          mockApplyUseCase.call(any),
        ).thenAnswer((_) async => ApiSuccessResult(applyResponseEntity));
        return viewModel;
      },
      act: (cubit) => cubit.doIntent(ApplySendDataEvent()),
      expect: () => [
        state.copyWith(applyFun: BaseState.loading()),
        state.copyWith(applyFun: BaseState.success(applyResponseEntity)),
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
  group("Test get all vehicle Function", () {
    blocTest<ApplyViewModel, ApplyViewModelState>(
      "test get all vehicle function emit success",
      build: () {
        when(
          mockGetAllVehiclesUseCase.call(),
        ).thenAnswer((_) async => ApiSuccessResult(vehicleResponseEntity));
        when(
          mockGetAllCountryUseCase.call(),
        ).thenAnswer((_) async => ApiSuccessResult(countryResponseEntity));
        return viewModel;
      },
      act: (cubit) => cubit.doIntent(ApplyEventGetAllData()),
      expect: () => [
        state.copyWith(allCountry: BaseState.loading()),
        state.copyWith(allCountry: BaseState.success(countryResponseEntity)),
        state.copyWith(
          allVehicleList: BaseState.loading(),
          allCountry: BaseState.success(countryResponseEntity),
        ),
        state.copyWith(
          allVehicleList: BaseState.success(vehicleResponseEntity),
          allCountry: BaseState.success(countryResponseEntity),
        ),
      ],
    );

    blocTest<ApplyViewModel, ApplyViewModelState>(
      "test get all vehicle function emit Failure",
      build: () {
        when(
          mockGetAllCountryUseCase.call(),
        ).thenAnswer((_) async => ApiErrorResult(dioException));
        when(
          mockGetAllVehiclesUseCase.call(),
        ).thenAnswer((_) async => ApiErrorResult(dioException));
        return viewModel;
      },
      act: (cubit) => cubit.doIntent(ApplyEventGetAllData()),
      expect: () => [
        state.copyWith(allCountry: BaseState.loading()),

        anyOf([
          isA<ApplyViewModelState>().having(
            (s) => s.allCountry?.errorMessage,
            "error",
            contains(dioException.message),
          ),
          state.copyWith(allVehicleList: BaseState.loading()),
        ]),

        anyOf([
          isA<ApplyViewModelState>().having(
            (s) => s.allCountry?.errorMessage,
            "error",
            contains(dioException.message),
          ),
          state.copyWith(allVehicleList: BaseState.loading()),
        ]),

        isA<ApplyViewModelState>().having(
          (s) => s.allVehicleList?.errorMessage,
          "error",
          contains(dioException.message),
        ),
      ],
    );
  });
}
