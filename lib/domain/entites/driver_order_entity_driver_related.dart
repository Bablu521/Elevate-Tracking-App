import 'package:elevate_tracking_app/domain/entites/order_entity_driver_related.dart';
import 'package:elevate_tracking_app/domain/entites/store_entity_driver_related.dart';
import 'package:equatable/equatable.dart';

class DriverOrderEntityDriverRelated extends Equatable {
  final String? id;
  final String? driver;
  final OrderEntityDriverRelated? order;
  final StoreEntityDriverRelated? store;
  final int? v;
  final String? createdAt;
  final String? updatedAt;

  const DriverOrderEntityDriverRelated({
    this.id,
    this.driver,
    this.order,
    this.store,
    this.v,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    driver,
    order,
    store,
    v,
    createdAt,
    updatedAt,
  ];
}
