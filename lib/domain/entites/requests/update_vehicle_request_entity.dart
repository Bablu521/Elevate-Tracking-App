import 'dart:io';

class UpdateVehicleRequestEntity {
  final String? vehicleType;
  final String? vehicleNumber;
  final File? vehicleLicense;

  UpdateVehicleRequestEntity({
    required this.vehicleType,
    required this.vehicleNumber,
    required this.vehicleLicense,
  });
}
