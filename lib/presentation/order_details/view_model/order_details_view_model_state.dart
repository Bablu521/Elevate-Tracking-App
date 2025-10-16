part of 'order_details_view_model_cubit.dart';

class OrderDetailsViewModelState extends Equatable {
  const OrderDetailsViewModelState({this.orderDetails, this.updateOrderStatus});
  final BaseState<OrderFirestoreEntity>? orderDetails;
  final BaseState<bool>? updateOrderStatus;
  OrderDetailsViewModelState copyWith({
    BaseState<OrderFirestoreEntity>? orderDetails,
    BaseState<bool>? updateOrderStatus,
  }) {
    return OrderDetailsViewModelState(
      orderDetails: orderDetails ?? this.orderDetails,
      updateOrderStatus: updateOrderStatus ?? this.updateOrderStatus,
    );
  }

  @override
  List<Object?> get props => [orderDetails, updateOrderStatus];
}
