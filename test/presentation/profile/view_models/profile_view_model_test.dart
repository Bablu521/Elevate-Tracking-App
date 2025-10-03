import 'package:bloc_test/bloc_test.dart';
import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/domain/entites/driver_entity.dart';
import 'package:elevate_tracking_app/domain/entites/logout_response_entity.dart';
import 'package:elevate_tracking_app/domain/entites/vehicle_entity.dart';
import 'package:elevate_tracking_app/presentation/profile/view_models/profile_events.dart';
import 'package:elevate_tracking_app/presentation/profile/view_models/profile_states.dart';
import 'package:elevate_tracking_app/presentation/profile/view_models/profile_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:elevate_tracking_app/domain/use_cases/edit_profile_use_case.dart';
import 'package:elevate_tracking_app/domain/use_cases/get_logged_driver_data_use_case.dart';
import 'package:elevate_tracking_app/domain/use_cases/get_vehicle_use_case.dart';
import 'package:elevate_tracking_app/domain/use_cases/logout_use_case.dart';
import 'package:elevate_tracking_app/domain/use_cases/upload_profile_photo_use_case.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy/profile_info_dummy.dart';
import 'profile_view_model_test.mocks.dart';


@GenerateMocks([
  GetLoggedDriverDataUseCase,
  EditProfileUseCase,
  GetVehicleUseCase,
  UploadProfilePhotoUseCase,
  LogoutUseCase,
])
void main() {
  group("test ProfileViewModel", () {
    late MockGetLoggedDriverDataUseCase mockGetLoggedDriverDataUseCase;
    late MockEditProfileUseCase mockEditProfileUseCase;
    late MockGetVehicleUseCase mockGetVehicleUseCase;
    late MockUploadProfilePhotoUseCase mockUploadProfilePhotoUseCase;
    late MockLogoutUseCase mockLogoutUseCase;
    late ProfileViewModel profileViewModel;
    late ProfileStates state;
    const id = "vehicle-id";
    const errorMsg = "Server Error";

    setUp(() {
      mockGetLoggedDriverDataUseCase = MockGetLoggedDriverDataUseCase();
      mockEditProfileUseCase = MockEditProfileUseCase();
      mockGetVehicleUseCase = MockGetVehicleUseCase();
      mockUploadProfilePhotoUseCase = MockUploadProfilePhotoUseCase();
      mockLogoutUseCase = MockLogoutUseCase();
      profileViewModel = ProfileViewModel(
        mockGetLoggedDriverDataUseCase,
        mockEditProfileUseCase,
        mockGetVehicleUseCase,
        mockUploadProfilePhotoUseCase,
        mockLogoutUseCase,
      );
      state = const ProfileStates();
    });

    group("test doItent with OnGetLoggedDriverDataUseCaseEvent", () {
      final expectedEntity = ProfileInfoDummy.dummyDriverEntityFake;
      final expectedResult = ApiSuccessResult<DriverEntity>(expectedEntity);
      provideDummy<ApiResult<DriverEntity>>(expectedResult);
      blocTest<ProfileViewModel, ProfileStates>(
        'call doIntent with OnGetLoggedDriverDataUseCaseEvent then load and successed',
        build: () => profileViewModel,
        act: (profileViewModel) async {
          when(
            mockGetLoggedDriverDataUseCase.call(),
          ).thenAnswer((_) async => expectedResult);
          return profileViewModel.doIntent(OnGetLoggedDriverDataUseCaseEvent());
        },
        expect: () => [
          state.copyWith(isLoading: true),
          state.copyWith(isLoading: true, isFormChanged: true),
          state.copyWith(isLoading: true, isFormChanged: false),
          state.copyWith(
            isLoading: false,
            driverData: expectedEntity,
            isFormChanged: false,
          ),
        ],
        verify: (_) {
          verify(mockGetLoggedDriverDataUseCase.call()).called(1);
        },
      );

      final expectedfailure = ApiErrorResult<DriverEntity>(errorMsg);
      provideDummy<ApiResult<DriverEntity>>(expectedfailure);
      blocTest<ProfileViewModel, ProfileStates>(
        'call doIntent with OnGetLoggedDriverDataUseCaseEvent then load and failed',
        build: () => profileViewModel,
        act: (profileViewModel) async {
          when(
            mockGetLoggedDriverDataUseCase.call(),
          ).thenAnswer((_) async => expectedfailure);
          return profileViewModel.doIntent(OnGetLoggedDriverDataUseCaseEvent());
        },
        expect: () => [
          state.copyWith(isLoading: true),
          state.copyWith(isLoading: false, errorMessage: errorMsg),
        ],
        verify: (_) {
          verify(mockGetLoggedDriverDataUseCase.call()).called(1);
        },
      );
    });

    group("test doItent with OnGetVehicleEvent", () {
      final expectedEntity = ProfileInfoDummy.dummyVehicleEntityFake;
      final expectedResult = ApiSuccessResult<VehicleEntity>(expectedEntity);
      provideDummy<ApiResult<VehicleEntity>>(expectedResult);
      blocTest<ProfileViewModel, ProfileStates>(
        'call doIntent with OnGetVehicleEvent then load and successed',
        build: () => profileViewModel,
        act: (profileViewModel) async {
          when(
            mockGetVehicleUseCase.call(id),
          ).thenAnswer((_) async => expectedResult);
          return profileViewModel.doIntent(OnGetVehicleEvent(id: id));
        },
        expect: () => [
          state.copyWith(isLoading: true),
          state.copyWith(isLoading: false, vehicleData: expectedEntity),
        ],
        verify: (_) {
          verify(mockGetVehicleUseCase.call(id)).called(1);
        },
      );

      final expectedfailure = ApiErrorResult<VehicleEntity>(errorMsg);
      provideDummy<ApiResult<VehicleEntity>>(expectedfailure);
      blocTest<ProfileViewModel, ProfileStates>(
        'call doIntent with OnGetVehicleEvent then load and failed',
        build: () => profileViewModel,
        act: (profileViewModel) async {
          when(
            mockGetVehicleUseCase.call(id),
          ).thenAnswer((_) async => expectedfailure);
          return profileViewModel.doIntent(OnGetVehicleEvent(id: id));
        },
        expect: () => [
          state.copyWith(isLoading: true),
          state.copyWith(isLoading: false, errorMessage: errorMsg),
        ],
        verify: (_) {
          verify(mockGetVehicleUseCase.call(id)).called(1);
        },
      );
    });

    group("test doItent with OnEditProfileEvent", () {
      final updateProfileInfoRequestEntity =
          ProfileInfoDummy.dummyUpdateProfileInfoRequestEntityFake;
      final expectedEntity = ProfileInfoDummy.dummyDriverEntityFake;
      final expectedResult = ApiSuccessResult<DriverEntity>(expectedEntity);
      provideDummy<ApiResult<DriverEntity>>(expectedResult);
      blocTest<ProfileViewModel, ProfileStates>(
        'call doIntent with OnEditProfileEvent then load and successed',
        build: () => profileViewModel,
        act: (profileViewModel) async {
          when(
            mockEditProfileUseCase.call(updateProfileInfoRequestEntity),
          ).thenAnswer((_) async => expectedResult);
          profileViewModel.firstNameController.text = "Ahmed";
          profileViewModel.lastNameController.text = "Mahmoud";
          profileViewModel.emailController.text = "ahmed@example.com";
          profileViewModel.phoneNumberController.text = "+201234567890";
          return profileViewModel.doIntent(OnEditProfileEvent());
        },
        expect: () => [
          state.copyWith(isFormChanged: true, isLoading: false),
          state.copyWith(isLoading: true, isFormChanged: true),
          state.copyWith(
            isLoading: false,
            driverData: expectedEntity,
            isFormChanged: false,
          ),
        ],
        verify: (_) {
          verify(
            mockEditProfileUseCase.call(updateProfileInfoRequestEntity),
          ).called(1);
        },
      );

      final expectedfailure = ApiErrorResult<DriverEntity>(errorMsg);
      provideDummy<ApiResult<DriverEntity>>(expectedfailure);
      blocTest<ProfileViewModel, ProfileStates>(
        'call doIntent with OnEditProfileEvent then load and failed',
        build: () => profileViewModel,
        act: (profileViewModel) async {
          when(
            mockEditProfileUseCase.call(updateProfileInfoRequestEntity),
          ).thenAnswer((_) async => expectedfailure);
          profileViewModel.firstNameController.text = "Ahmed";
          profileViewModel.lastNameController.text = "Mahmoud";
          profileViewModel.emailController.text = "ahmed@example.com";
          profileViewModel.phoneNumberController.text = "+201234567890";
          return profileViewModel.doIntent(OnEditProfileEvent());
        },
        expect: () => [
          state.copyWith(isFormChanged: true, isLoading: false),
          state.copyWith(isLoading: true, isFormChanged: true),
          state.copyWith(
            isLoading: false,
            errorMessage: errorMsg,
            isFormChanged: true,
          ),
        ],
        verify: (_) {
          verify(
            mockEditProfileUseCase.call(updateProfileInfoRequestEntity),
          ).called(1);
        },
      );
    });

    group("test doItent with OnLogoutEvent", () {
      final expectedEntity = ProfileInfoDummy.fakeLogoutResponseEntity();
      final expectedResult = ApiSuccessResult<LogoutResponseEntity>(
        expectedEntity,
      );
      provideDummy<ApiResult<LogoutResponseEntity>>(expectedResult);
      blocTest<ProfileViewModel, ProfileStates>(
        'call doIntent with OnLogoutEvent then load and successed',
        build: () => profileViewModel,
        act: (profileViewModel) async {
          when(
            mockLogoutUseCase.call(),
          ).thenAnswer((_) async => expectedResult);
          return profileViewModel.doIntent(OnLogoutEvent());
        },
        expect: () => [
          state.copyWith(isLoading: true),
          state.copyWith(isLoading: false, isLogoutState: true),
        ],
        verify: (_) {
          verify(mockLogoutUseCase.call()).called(1);
        },
      );

      final expectedfailure = ApiErrorResult<LogoutResponseEntity>(errorMsg);
      provideDummy<ApiResult<LogoutResponseEntity>>(expectedfailure);
      blocTest<ProfileViewModel, ProfileStates>(
        'call doIntent with OnLogoutEvent then load and failed',
        build: () => profileViewModel,
        act: (profileViewModel) async {
          when(
            mockLogoutUseCase.call(),
          ).thenAnswer((_) async => expectedfailure);
          return profileViewModel.doIntent(OnLogoutEvent());
        },
        expect: () => [
          state.copyWith(isLoading: true),
          state.copyWith(isLoading: false, errorMessage: errorMsg),
        ],
        verify: (_) {
          verify(mockLogoutUseCase.call()).called(1);
        },
      );
    });

  });
}



