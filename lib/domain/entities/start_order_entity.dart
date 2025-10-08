import 'package:elevate_tracking_app/domain/entities/start_order_items_entity.dart';
import 'package:equatable/equatable.dart';

class StartOrderEntity extends Equatable {
  final String? id;
  final String? user;
  final List<StartOrderItemsEntity>? orderItems;
  final int? totalPrice;
  final String? paymentType;
  final bool? isPaid;
  final bool? isDelivered;
  final String? state;
  final String? createdAt;
  final String? updatedAt;
  final String? orderNumber;
  final int? v;

  const StartOrderEntity({
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
  });

  @override
  List<Object?> get props =>
      [
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
      ];
}
