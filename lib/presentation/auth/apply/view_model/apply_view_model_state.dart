part of 'apply_view_model.dart';

class ApplyViewModelState extends Equatable {
  const ApplyViewModelState({
    this.vehicleImagePath,
    this.allVehicleList,
    this.allCountry,
    this.idImagePath,
    this.applyFun,
  });
  final BaseState<List<VehicleEntity>>? allVehicleList;
  final BaseState<List<CountryEntity>>? allCountry;
  final BaseState<ApplyResponseEntity>? applyFun;
  final String? vehicleImagePath;
  final String? idImagePath;
  ApplyViewModelState copyWith({
    String? vehicleImagePath,
    String? idImagePath,
    BaseState<List<VehicleEntity>>? allVehicleList,
    BaseState<List<CountryEntity>>? allCountry,
    BaseState<ApplyResponseEntity>? applyFun,
  }) {
    return ApplyViewModelState(
      idImagePath: idImagePath ?? this.idImagePath,
      vehicleImagePath: vehicleImagePath ?? this.vehicleImagePath,
      allVehicleList: allVehicleList ?? this.allVehicleList,
      allCountry: allCountry ?? this.allCountry,
      applyFun: applyFun ?? this.applyFun,
    );
  }

  @override
  List<Object?> get props => [
    vehicleImagePath,
    allVehicleList,
    allCountry,
    idImagePath,
    applyFun,
  ];
}
