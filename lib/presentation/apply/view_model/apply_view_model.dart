import 'dart:io';
import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/core/base_state/base_state.dart';
import 'package:elevate_tracking_app/core/constants/const_keys.dart';
import 'package:elevate_tracking_app/domain/entites/apply_response_entity.dart';
import 'package:elevate_tracking_app/domain/entites/country_entity.dart';
import 'package:elevate_tracking_app/domain/entites/request/apply_request_entity.dart';
import 'package:elevate_tracking_app/domain/entites/vehicles_entity.dart';
import 'package:elevate_tracking_app/domain/use_cases/apply_use_case.dart';
import 'package:elevate_tracking_app/domain/use_cases/get_all_country_use_case.dart';
import 'package:elevate_tracking_app/domain/use_cases/get_all_vehicles_use_case.dart';
import 'package:elevate_tracking_app/presentation/apply/view_model/apply_event.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart' as p;
part 'apply_view_model_state.dart';

@injectable
class ApplyViewModel extends Cubit<ApplyViewModelState> {
  ApplyViewModel(
    this._allVehiclesUseCase,
    this._allCountryUseCase,
    this._applyUseCase,
  ) : super(const ApplyViewModelState()) {
    controllerFirstName.addListener(checkEnableButton);
    controllerSecondName.addListener(checkEnableButton);
    controllerCountry.addListener(checkEnableButton);
    controllerVehicleType.addListener(checkEnableButton);
    controllerVehicleNumber.addListener(checkEnableButton);
    controllerVehicleLicense.addListener(checkEnableButton);
    controllerEmail.addListener(checkEnableButton);
    controllerPhoneNumber.addListener(checkEnableButton);
    controllerIdNumber.addListener(checkEnableButton);
    controllerIdImage.addListener(checkEnableButton);
    controllerPassword.addListener(checkEnableButton);
    controllerConfirmPassword.addListener(checkEnableButton);
  }
  final GetAllVehiclesUseCase _allVehiclesUseCase;
  final GetAllCountryUseCase _allCountryUseCase;
  final ApplyUseCase _applyUseCase;
  TextEditingController controllerCountry = TextEditingController();
  TextEditingController controllerFirstName = TextEditingController();
  TextEditingController controllerSecondName = TextEditingController();
  TextEditingController controllerVehicleType = TextEditingController();
  TextEditingController controllerVehicleNumber = TextEditingController();
  TextEditingController controllerVehicleLicense = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPhoneNumber = TextEditingController();
  TextEditingController controllerIdNumber = TextEditingController();
  TextEditingController controllerIdImage = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerConfirmPassword = TextEditingController();
  ValueNotifier<String?> gender = ValueNotifier<String?>(null);
  final ValueNotifier<bool> isUserAuthenticated = ValueNotifier(false);
  String? vehicleImagePath;
  String? idImagePath;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  ValueNotifier<VehicleEntity?> selectedVehicle = ValueNotifier<VehicleEntity?>(
    null,
  );
  ValueNotifier<CountryEntity?> selectedCountry = ValueNotifier<CountryEntity?>(
    null,
  );
  ValueNotifier<bool> isPasswordVisible = ValueNotifier<bool>(false);
  Future<void> doIntent(ApplyEvent event) async {
    switch (event) {
      case ApplyEventPickVehicleLicensePhoto():
        _getVehicleLicense();
      case ApplyEventPickIDImage():
        _getIdImage();
      case ApplyEventGetAllData():
        _getAllData();
      case ApplyValidationField():
        _validateFiled();
      case ApplyPasswordVisibilityEvent():
        _passwordVisibility();
    }
  }

  void _passwordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> _validateFiled() async {
    if (globalKey.currentState!.validate()) {
      emit(state.copyWith(applyFun: BaseState<ApplyResponseEntity>.loading()));
      final result = await _applyUseCase.call(
        ApplyRequestEntity(
          country: controllerCountry.text,
          firstName: controllerFirstName.text,
          lastName: controllerSecondName.text,
          vehicleType: selectedVehicle.value?.id ?? "",
          vehicleNumber: controllerVehicleNumber.text,
          nid: controllerIdNumber.text,
          email: controllerEmail.text,
          password: controllerPassword.text,
          rePassword: controllerConfirmPassword.text,
          gender: gender.value ?? ConstKeys.kMale,
          phone: controllerPhoneNumber.text,
          nidImg: File(idImagePath!),
          vehicleLicense: File(vehicleImagePath!),
        ),
      );
      switch (result) {
        case ApiSuccessResult<ApplyResponseEntity>():
          emit(
            state.copyWith(
              applyFun: BaseState<ApplyResponseEntity>.success(result.data),
            ),
          );
        case ApiErrorResult<ApplyResponseEntity>():
          emit(
            state.copyWith(
              applyFun: BaseState<ApplyResponseEntity>.error(
                result.errorMessage,
              ),
            ),
          );
      }
    }
  }

  void checkEnableButton() {
    if (controllerCountry.text.isNotEmpty &&
        controllerFirstName.text.isNotEmpty &&
        controllerSecondName.text.isNotEmpty &&
        controllerVehicleType.text.isNotEmpty &&
        controllerVehicleNumber.text.isNotEmpty &&
        controllerVehicleLicense.text.isNotEmpty &&
        controllerEmail.text.isNotEmpty &&
        controllerPhoneNumber.text.isNotEmpty &&
        controllerIdNumber.text.isNotEmpty &&
        controllerIdImage.text.isNotEmpty &&
        controllerPassword.text.isNotEmpty &&
        controllerConfirmPassword.text.isNotEmpty) {
      isUserAuthenticated.value = true;
    } else {
      isUserAuthenticated.value = false;
    }
  }

  Future<void> _getAllData() async {
    await Future.wait([_getAllCountry(), _getAllVehicles()]);
  }

  Future<void> _getVehicleLicense() async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      emit(state.copyWith(vehicleImagePath: pickedFile.path));
      vehicleImagePath = pickedFile.path;
      controllerVehicleLicense.text = p.basename(pickedFile.path);
    }
  }

  Future<void> _getIdImage() async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      emit(state.copyWith(idImagePath: pickedFile.path));
      idImagePath = pickedFile.path;
      controllerIdImage.text = p.basename(pickedFile.path);
    }
  }

  Future<void> _getAllVehicles() async {
    emit(state.copyWith(allVehicleList: BaseState.loading()));
    final result = await _allVehiclesUseCase.call();
    switch (result) {
      case ApiSuccessResult<List<VehicleEntity>>():
        emit(state.copyWith(allVehicleList: BaseState.success(result.data)));
      case ApiErrorResult<List<VehicleEntity>>():
        emit(
          state.copyWith(allVehicleList: BaseState.error(result.errorMessage)),
        );
    }
  }

  Future<void> _getAllCountry() async {
    emit(state.copyWith(allCountry: BaseState.loading()));
    final result = await _allCountryUseCase.call();
    switch (result) {
      case ApiSuccessResult<List<CountryEntity>>():
        emit(state.copyWith(allCountry: BaseState.success(result.data)));
      case ApiErrorResult<List<CountryEntity>>():
        emit(state.copyWith(allCountry: BaseState.error(result.errorMessage)));
    }
  }

  @override
  Future<void> close() {
    controllerCountry.dispose();
    controllerFirstName.dispose();
    controllerSecondName.dispose();
    controllerVehicleType.dispose();
    controllerVehicleNumber.dispose();
    controllerVehicleLicense.dispose();
    controllerEmail.dispose();
    controllerPhoneNumber.dispose();
    controllerIdNumber.dispose();
    controllerIdImage.dispose();
    controllerPassword.dispose();
    controllerConfirmPassword.dispose();
    return super.close();
  }
}
