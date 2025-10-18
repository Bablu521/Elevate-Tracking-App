import 'package:elevate_tracking_app/domain/entites/order_item_entity_driver_related.dart';
import 'package:elevate_tracking_app/domain/entites/shipping_address_entity_driver_related.dart';
import 'package:elevate_tracking_app/domain/entites/user_entity_driver_related.dart';
import 'package:equatable/equatable.dart';

class OrderEntityDriverRelated extends Equatable {
  final String? id;
  final UserEntityDriverRelated? user;
  final List<OrderItemEntityDriverRelated>? orderItems;
  final double? totalPrice;
  final String? paymentType;
  final bool? isPaid;
  final bool? isDelivered;
  final String? state;
  final String? createdAt;
  final String? updatedAt;
  final String? orderNumber;
  final int? v;
  final String? paidAt;
  final ShippingAddressEntityDriverRelated? shippingAddress;

  const OrderEntityDriverRelated({
    this.id,
    this.user,
    this.orderItems,
    this.totalPrice,
    this.paymentType,
    this.isPaid,
    this.isDelivered,
    this.state,
    this.createdAt,
    this.updatedAt,
    this.orderNumber,
    this.v,
    this.paidAt,
    this.shippingAddress,
  });

  @override
  List<Object?> get props => [
    id,
    user,
    orderItems,
    totalPrice,
    paymentType,
    isPaid,
    isDelivered,
    state,
    createdAt,
    updatedAt,
    orderNumber,
    v,
    paidAt,
    shippingAddress,
  ];
}
