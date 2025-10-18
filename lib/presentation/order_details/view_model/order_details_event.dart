sealed class OrderDetailsEvent {}

class OrderDetailsGetOrderFromFireBase extends OrderDetailsEvent {
  final String orderId;

  OrderDetailsGetOrderFromFireBase({required this.orderId});
}

class OrderDetailsUpdateOrderStatus extends OrderDetailsEvent {}

class OrderDetailsDirectToWhatsApp extends OrderDetailsEvent {
  final String phoneNumber;

  OrderDetailsDirectToWhatsApp({required this.phoneNumber});
}
class OrderDetailsDirectToCallNumber extends OrderDetailsEvent {
  final String phoneNumber;

  OrderDetailsDirectToCallNumber({required this.phoneNumber});
}
