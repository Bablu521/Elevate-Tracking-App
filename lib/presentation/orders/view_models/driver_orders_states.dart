import 'package:elevate_tracking_app/domain/entites/driver_order_entity_driver_related.dart';
import 'package:equatable/equatable.dart';

class DriverOrdersStates extends Equatable {
  final bool driverOrdersLoading;
  final List<DriverOrderEntityDriverRelated> driverOrdersSuccess;
  final String? driverOrdersErrorMessage;

  const DriverOrdersStates({
    this.driverOrdersLoading = false,
    this.driverOrdersSuccess = const [],
    this.driverOrdersErrorMessage,
  });

  DriverOrdersStates copyWith({
    bool? driverOrdersLoading,
    List<DriverOrderEntityDriverRelated>? driverOrdersSuccess,
    String? driverOrdersErrorMessage,
  }) {
    return DriverOrdersStates(
      driverOrdersLoading: driverOrdersLoading ?? this.driverOrdersLoading,
      driverOrdersSuccess: driverOrdersSuccess ?? this.driverOrdersSuccess,
      driverOrdersErrorMessage:
          driverOrdersErrorMessage ?? this.driverOrdersErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
    driverOrdersLoading,
    driverOrdersSuccess,
    driverOrdersErrorMessage,
  ];
}
