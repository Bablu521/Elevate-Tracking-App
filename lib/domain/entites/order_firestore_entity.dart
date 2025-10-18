import 'package:elevate_tracking_app/domain/entites/driver_entity.dart';
import 'package:elevate_tracking_app/domain/entites/live_location_entity.dart';
import 'package:equatable/equatable.dart';

import '../entities/order_entity.dart';

class OrderFirestoreEntity extends Equatable {
  final DriverEntity? driver;
  final OrderEntity? order;
  final LiveLocationEntity? location;

  const OrderFirestoreEntity({this.driver, this.order, this.location});

  Map<String, dynamic> toMap() {
    return {
      'driver': driver?.toMap(),
      'order': order?.toMap(),
      'location': location?.toMap(),
    };
  }

  factory OrderFirestoreEntity.fromMap(Map<String, dynamic> map) {
    return OrderFirestoreEntity(
      driver: DriverEntity.fromMap(Map<String, dynamic>.from(map['driver'])),
      order: OrderEntity.fromMap(Map<String, dynamic>.from(map['order'])),
      location: LiveLocationEntity.fromMap(
        Map<String, dynamic>.from(map['location']),
      ),
    );
  }

  OrderFirestoreEntity copyWith({
    DriverEntity? driver,
    OrderEntity? order,
    LiveLocationEntity? location,
  }) {
    return OrderFirestoreEntity(
      driver: driver ?? this.driver,
      order: order ?? this.order,
      location: location ?? this.location,
    );
  }

  @override
  List<Object?> get props => [driver, order, location];
}
