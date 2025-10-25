part of 'order_details_view_model_cubit.dart';

class OrderDetailsViewModelState extends Equatable {
  const OrderDetailsViewModelState({
    this.orderDetails,
    this.updateOrderStatus,
    this.isDelivered = false,
  });

  final BaseState<OrderFirestoreEntity>? orderDetails;
  final BaseState<bool>? updateOrderStatus;
  final bool isDelivered;

  OrderDetailsViewModelState copyWith({
    BaseState<OrderFirestoreEntity>? orderDetails,
    BaseState<bool>? updateOrderStatus,
    bool? isDelivered,
  }) {
    return OrderDetailsViewModelState(
      orderDetails: orderDetails ?? this.orderDetails,
      updateOrderStatus: updateOrderStatus ?? this.updateOrderStatus,
      isDelivered: isDelivered ?? this.isDelivered,
    );
  }

  @override
  List<Object?> get props => [orderDetails, updateOrderStatus, isDelivered];
}
