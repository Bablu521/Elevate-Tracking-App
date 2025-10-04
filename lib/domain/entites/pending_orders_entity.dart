import 'package:elevate_tracking_app/domain/entites/meta_data_entity.dart';
import 'package:elevate_tracking_app/domain/entites/order_entity.dart';

class PendingOrdersEntity {
  final MetaDataEntity? metadata;
  final List<OrderEntity>? orders;

  PendingOrdersEntity({this.metadata, this.orders});
}
