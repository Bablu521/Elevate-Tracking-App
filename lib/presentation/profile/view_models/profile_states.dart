import 'dart:io';

import 'package:elevate_tracking_app/domain/entites/driver_entity.dart';
import 'package:elevate_tracking_app/domain/entites/vehicle_entity.dart';
import 'package:equatable/equatable.dart';

class ProfileStates extends Equatable {
  final bool isLoading;
  final DriverEntity? driverData;
  final String? errorMessage;
  final VehicleEntity? vehicleData;
  final bool isFormChanged;
  final File? localPickedImage;

  const ProfileStates({
    this.isLoading = false,
    this.driverData,
    this.errorMessage,
    this.vehicleData,
    this.isFormChanged = false,
    this.localPickedImage
  });

  ProfileStates copyWith({
    bool? isLoading,
    DriverEntity? driverData,
    String? errorMessage,
    VehicleEntity? vehicleData,
    bool? isFormChanged,
    File? localPickedImage
  }) {
    return ProfileStates(
      isLoading: isLoading ?? this.isLoading,
      driverData: driverData ?? this.driverData,
      errorMessage: errorMessage ?? this.errorMessage,
      vehicleData: vehicleData ?? this.vehicleData,
      isFormChanged: isFormChanged ?? this.isFormChanged,
      localPickedImage: localPickedImage ?? this.localPickedImage
    );
  }

  @override
  List<Object?> get props => [isLoading, driverData, errorMessage, vehicleData, isFormChanged, localPickedImage];
}
