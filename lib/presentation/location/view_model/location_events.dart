sealed class LocationEvents {}

class GetOrderLocationEvent extends LocationEvents {
  final String orderId;
  final bool isUser;

  GetOrderLocationEvent({required this.orderId, required this.isUser});
}

class LunchCallLocationEvent extends LocationEvents {
  final String phoneNumber;

  LunchCallLocationEvent(this.phoneNumber);
}

class LunchWhatsAppLocationEvent extends LocationEvents {
  final String phoneNumber;

  LunchWhatsAppLocationEvent(this.phoneNumber);
}