import 'dart:io';
import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/core/base_state/base_state.dart';
import 'package:elevate_tracking_app/domain/entities/driver_entity.dart';
import 'package:elevate_tracking_app/domain/entities/requests/update_vehicle_request_entity.dart';
import 'package:elevate_tracking_app/domain/entities/vehicle_entity.dart';
import 'package:elevate_tracking_app/domain/entities/vehicles_entity.dart';
import 'package:elevate_tracking_app/domain/use_cases/get_all_vehicles_use_case.dart';
import 'package:elevate_tracking_app/domain/use_cases/update_vehicle_use_case.dart';
import 'package:elevate_tracking_app/generated/l10n.dart';
import 'package:elevate_tracking_app/presentation/profile/view_models/edit_vehicle_view_model/edit_vehicle_event.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart' as p;
import 'package:collection/collection.dart';
part 'edit_vehicle_view_model_state.dart';

@injectable
class EditVehicleViewModel extends Cubit<EditVehicleViewModelState> {
  EditVehicleViewModel(this._allVehiclesUseCase, this._updateVehicleUseCase)
    : super(const EditVehicleViewModelState()) {
    controllerVehicleLicense.addListener(checkEnableButton);
    controllerVehicleNumber.addListener(checkEnableButton);
    controllerVehicleType.addListener(checkEnableButton);
  }
  final GetAllVehiclesUseCase _allVehiclesUseCase;
  final UpdateVehicleUseCase _updateVehicleUseCase;
  Future<void> doIntent(EditVehicleEvent event) async {
    switch (event) {
      case EditVehicleInitializeAllDataEvent():
        _getAllData(event.vehicleId);
      case EditVehiclePickImageEvent():
        _getVehicleLicense();
      case EditVehiclePickUpdateDataEvent():
        _updateVehicleInfo();
    }
  }

  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  final ValueNotifier<bool> isUserAuthenticated = ValueNotifier(false);
  String? vehicleLicenseImagePath;
  ValueNotifier<VehicleEntity?> selectedVehicle = ValueNotifier<VehicleEntity?>(
    null,
  );
  TextEditingController controllerVehicleType = TextEditingController();
  TextEditingController controllerVehicleNumber = TextEditingController();
  TextEditingController controllerVehicleLicense = TextEditingController();
  String? _initialVehicleType;
  String? _initialVehicleNumber;
  String? _initialVehicleLicense;
  bool _isSettingInitial = false;

  void _initialValue() {
    _initialVehicleType = controllerVehicleType.text;
    _initialVehicleNumber = controllerVehicleNumber.text;
    _initialVehicleLicense = controllerVehicleLicense.text;
  }

  Future<void> _getAllData(String vehicleId) async {
    _isSettingInitial = true;
    await _getAllVehicles();
    _getSelectedVehicle(vehicleId);
    _initialValue();
    _isSettingInitial = false;
  }

  Future<void> _getAllVehicles() async {
    emit(state.copyWith(allVehicleList: BaseState.loading()));
    final result = await _allVehiclesUseCase.call();
    switch (result) {
      case ApiSuccessResult<List<VehiclesEntity>>():
        emit(state.copyWith(allVehicleList: BaseState.success(result.data)));
      case ApiErrorResult<List<VehiclesEntity>>():
        emit(
          state.copyWith(allVehicleList: BaseState.error(result.errorMessage)),
        );
    }
  }

  Future<void> _getVehicleLicense() async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      emit(state.copyWith(vehicleLicenseImagePath: pickedFile.path));
      vehicleLicenseImagePath = pickedFile.path;
      controllerVehicleLicense.text = p.basename(pickedFile.path);
    }
  }

  void _getSelectedVehicle(String vehicleId) async {
    final vehicle = state.allVehicleList?.data?.firstWhereOrNull(
      (v) => v.id == vehicleId,
    );
    selectedVehicle.value = vehicle as VehicleEntity;
    controllerVehicleType.text =
        vehicle?.type ?? AppLocalizations().vehicleNotFound;
  }

  Future<void> _updateVehicleInfo() async {
    emit(state.copyWith(updateData: BaseState.loading()));
    final file = vehicleLicenseImagePath != null
        ? File(vehicleLicenseImagePath!)
        : null;
    final result = await _updateVehicleUseCase.call(
      UpdateVehicleRequestEntity(
        vehicleType: selectedVehicle.value?.id,
        vehicleNumber: controllerVehicleNumber.text,
        vehicleLicense: file,
      ),
    );
    switch (result) {
      case ApiSuccessResult<DriverEntity>():
        emit(state.copyWith(updateData: BaseState.success(result.data)));

      case ApiErrorResult<DriverEntity>():
        emit(state.copyWith(updateData: BaseState.error(result.errorMessage)));
    }
  }

  void checkEnableButton() {
    if (_isSettingInitial) return;
    isUserAuthenticated.value =
        _initialVehicleNumber != controllerVehicleNumber.text ||
        _initialVehicleType != controllerVehicleType.text ||
        _initialVehicleLicense != controllerVehicleLicense.text;
  }
}
