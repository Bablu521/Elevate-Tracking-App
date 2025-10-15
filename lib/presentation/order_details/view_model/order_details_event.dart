sealed class OrderDetailsEvent {}

class OrderDetailsGetOrderFromFireBase extends OrderDetailsEvent {
  final String orderId;

  OrderDetailsGetOrderFromFireBase({required this.orderId});
}

class OrderDetailsUpdateOrderStatus extends OrderDetailsEvent {}
