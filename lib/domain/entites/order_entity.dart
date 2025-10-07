import 'package:elevate_tracking_app/domain/entites/order_item_entity.dart';
import 'package:elevate_tracking_app/domain/entites/shipping_address_entity.dart';
import 'package:elevate_tracking_app/domain/entites/store_entity.dart';
import 'package:elevate_tracking_app/domain/entites/user_entity.dart';
import 'package:equatable/equatable.dart';

class OrderEntity extends Equatable {
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

  const OrderEntity({
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

  @override
  List<Object?> get props =>
      [
        id,
        user,
        orderItems,
        totalPrice,
        shippingAddress,
        paymentType,
        isPaid,
        isDelivered,
        state,
        createdAt,
        updatedAt,
        orderNumber,
        v,
        store,
      ];
}
