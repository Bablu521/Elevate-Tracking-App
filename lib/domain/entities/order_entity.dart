import 'package:elevate_tracking_app/domain/entities/order_item_entity.dart';
import 'package:elevate_tracking_app/domain/entities/shipping_address_entity.dart';
import 'package:elevate_tracking_app/domain/entities/store_entity.dart';
import 'package:elevate_tracking_app/domain/entities/user_entity.dart';

class OrderEntity {
  final String? id;
  final UserEntity? user;
  final List<OrderItemEntity>? orderItems;
  final int? totalPrice;
  final ShippingAddressEntity? shippingAddress;
  final String? paymentType;
  final bool? isPaid;
  final bool? isDelivered;
  final String? state;
  final String? createdAt;
  final String? updatedAt;
  final String? orderNumber;
  final int? v;
  final StoreEntity? store;

  OrderEntity({
    this.id,
    this.user,
    this.orderItems,
    this.totalPrice,
    this.shippingAddress,
    this.paymentType,
    this.isPaid,
    this.isDelivered,
    this.state,
    this.createdAt,
    this.updatedAt,
    this.orderNumber,
    this.v,
    this.store,
  });
}
