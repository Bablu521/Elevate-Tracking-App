sealed class HomeEvents {}

class GetOrdersEvent extends HomeEvents {}
class AcceptOrderEvent extends HomeEvents {
  final int index;
  AcceptOrderEvent(this.index);
}
class RejectOrderEvent extends HomeEvents {
  final int index;
  RejectOrderEvent(this.index);
}
class LoadMoreOrdersEvent extends HomeEvents {}