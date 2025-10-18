sealed class LocationEvents {}

class GetOrderLocationEvent extends LocationEvents {
  final String orderId;
  final bool isUser;

  GetOrderLocationEvent({required this.orderId, required this.isUser});
}
