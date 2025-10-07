import 'package:elevate_tracking_app/domain/entites/meta_data_entity.dart';
import 'package:elevate_tracking_app/domain/entites/order_entity.dart';
import 'package:equatable/equatable.dart';

class PendingOrdersEntity extends Equatable {
  final MetaDataEntity? metadata;
  final List<OrderEntity>? orders;

  const PendingOrdersEntity({this.metadata, this.orders});

  @override
  List<Object?> get props => [metadata, orders];
}
