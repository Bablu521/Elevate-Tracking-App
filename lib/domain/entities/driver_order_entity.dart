import 'package:elevate_tracking_app/domain/entities/order_entity.dart';
import 'package:elevate_tracking_app/domain/entities/store_entity.dart';

class DriverOrderEntity {
  final String? id;
  final String? driver;
  final OrderEntity? order;
  final int? v;
  final String? createdAt;
  final String? updatedAt;
  final StoreEntity? store;

  DriverOrderEntity({
    this.id,
    this.driver,
    this.order,
    this.v,
    this.createdAt,
    this.updatedAt,
    this.store,
  });
}
