part of 'order_details_view_model_cubit.dart';

class OrderDetailsViewModelState extends Equatable {
  const OrderDetailsViewModelState({this.orderDetails});
  final BaseState<OrderFirestoreEntity>? orderDetails;
  OrderDetailsViewModelState copyWith({
    BaseState<OrderFirestoreEntity>? orderDetails,
  }) {
    return OrderDetailsViewModelState(
      orderDetails: orderDetails ?? this.orderDetails,
    );
  }

  @override
  List<Object?> get props => [orderDetails];
}
