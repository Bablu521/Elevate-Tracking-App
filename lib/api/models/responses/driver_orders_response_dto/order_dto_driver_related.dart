import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'user_dto_driver_related.dart';
import 'order_item_dto_driver_related.dart';
import 'shipping_address_dto_driver_related.dart';

part 'order_dto_driver_related.g.dart';

@JsonSerializable()
class OrderDtoDriverRelated extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final UserDtoDriverRelated? user;
  final List<OrderItemDtoDriverRelated>? orderItems;
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
  final ShippingAddressDtoDriverRelated? shippingAddress;

  const OrderDtoDriverRelated({
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

  factory OrderDtoDriverRelated.fromJson(Map<String, dynamic> json) =>
      _$OrderDtoDriverRelatedFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDtoDriverRelatedToJson(this);

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
