import 'dart:io';
import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/core/enums/gender_enum.dart';
import 'package:elevate_tracking_app/domain/entites/driver_entity.dart';
import 'package:elevate_tracking_app/domain/entites/logout_response_entity.dart';
import 'package:elevate_tracking_app/domain/entites/requests/update_profile_info_request_entity.dart';
import 'package:elevate_tracking_app/domain/entites/upload_profile_image_response_entity.dart';
import 'package:elevate_tracking_app/domain/entites/vehicle_entity.dart';
import 'package:elevate_tracking_app/domain/use_cases/edit_profile_use_case.dart';
import 'package:elevate_tracking_app/domain/use_cases/get_logged_driver_data_use_case.dart';
import 'package:elevate_tracking_app/domain/use_cases/get_vehicle_use_case.dart';
import 'package:elevate_tracking_app/domain/use_cases/logout_use_case.dart';
import 'package:elevate_tracking_app/domain/use_cases/upload_profile_photo_use_case.dart';
import 'package:elevate_tracking_app/presentation/profile/view_models/profile_events.dart';
import 'package:elevate_tracking_app/presentation/profile/view_models/profile_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@singleton
@injectable
class ProfileViewModel extends Cubit<ProfileStates> {
  final GetLoggedDriverDataUseCase _getLoggedDriverDataUseCase;
  final EditProfileUseCase _editProfileUseCase;
  final GetVehicleUseCase _getVehicleUseCase;
  final UploadProfilePhotoUseCase _uploadProfilePhotoUseCase;
  final LogoutUseCase _logoutUseCase;

  ProfileViewModel(
    this._getLoggedDriverDataUseCase,
    this._editProfileUseCase,
    this._getVehicleUseCase,
    this._uploadProfilePhotoUseCase,
    this._logoutUseCase,
  ) : super(const ProfileStates()) {
    firstNameController.addListener(_onFormChanged);
    lastNameController.addListener(_onFormChanged);
    emailController.addListener(_onFormChanged);
    phoneNumberController.addListener(_onFormChanged);
  }
  DriverEntity? driverEntity;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Gender? selectedGender = Gender.male;

  String? _initialFirstName;
  String? _initialLastName;
  String? _initialEmail;
  String? _initialPhone;

  void doIntent(ProfileEvents event) {
    switch (event) {
      case OnGetLoggedDriverDataUseCaseEvent():
        _getLoggedDriverData();
        break;
      case OnGetVehicleEvent():
        _getVehicle(event.id);
        break;
      case OnEditProfileEvent():
        _editProfile();
        break;
      case OnUploadProfileImageEvent():
        _uploadProfilePhoto(event.file);
        break;
      case OnLogoutEvent():
        _logout();
        break;
    }
  }

  void _onFormChanged() {
    final changed =
        firstNameController.text != _initialFirstName ||
        lastNameController.text != _initialLastName ||
        emailController.text != _initialEmail ||
        phoneNumberController.text != _initialPhone;

    emit(state.copyWith(isFormChanged: changed));
  }

  Future<void> _getLoggedDriverData() async {
    emit(state.copyWith(isLoading: true));
    final result = await _getLoggedDriverDataUseCase.call();
    switch (result) {
      case ApiSuccessResult<DriverEntity>():
        driverEntity = result.data;
        _initialFirstName = result.data.firstName;
        _initialLastName = result.data.lastName;
        _initialEmail = result.data.email;
        _initialPhone = result.data.phone;
        firstNameController.text = result.data.firstName!;
        lastNameController.text = result.data.lastName!;
        emailController.text = result.data.email!;
        phoneNumberController.text = result.data.phone!;
        selectedGender = genderFromString(result.data.gender!);
        emit(
          state.copyWith(
            isLoading: false,
            driverData: result.data,
            isFormChanged: false,
          ),
        );

        break;
      case ApiErrorResult<DriverEntity>():
        emit(
          state.copyWith(isLoading: false, errorMessage: result.errorMessage),
        );
    }
  }

  Future<void> _getVehicle(String id) async {
    emit(state.copyWith(isLoading: true));
    final result = await _getVehicleUseCase.call(id);
    switch (result) {
      case ApiSuccessResult<VehicleEntity>():
        emit(state.copyWith(isLoading: false, vehicleData: result.data));
      case ApiErrorResult<VehicleEntity>():
        emit(
          state.copyWith(isLoading: false, errorMessage: result.errorMessage),
        );
    }
  }

  Future<void> _editProfile() async {
    emit(state.copyWith(isLoading: true));
    final result = await _editProfileUseCase.call(
      UpdateProfileInfoRequestEntity(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
        phone: phoneNumberController.text,
      ),
    );
    switch (result) {
      case ApiSuccessResult<DriverEntity>():
        emit(
          state.copyWith(
            isLoading: false,
            driverData: result.data,
            isFormChanged: false,
          ),
        );
      case ApiErrorResult<DriverEntity>():
        emit(
          state.copyWith(isLoading: false, errorMessage: result.errorMessage),
        );
    }
  }

  Future<void> _uploadProfilePhoto(File file) async {
    emit(state.copyWith(localPickedImage: file));

    final result = await _uploadProfilePhotoUseCase.call(file);

    switch (result) {
      case ApiSuccessResult<UploadProfileImageResponseEntity>():
        await _getLoggedDriverData();
        emit(state.copyWith(localPickedImage: null));
      case ApiErrorResult<UploadProfileImageResponseEntity>():
        emit(
          state.copyWith(
            localPickedImage: null,
            errorMessage: result.errorMessage,
          ),
        );
    }
  }

  Future<void> _logout() async {
    emit(state.copyWith(isLoading: true));
    final result = await _logoutUseCase.call();
    switch (result) {
      case ApiSuccessResult<LogoutResponseEntity>():
        emit(state.copyWith(isLoading: false, isLogoutState: true));
      case ApiErrorResult<LogoutResponseEntity>():
        emit(
          state.copyWith(isLoading: false, errorMessage: result.errorMessage),
        );
    }
  }
}
