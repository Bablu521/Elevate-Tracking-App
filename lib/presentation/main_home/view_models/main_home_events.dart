sealed class MainHomeEvent {}

class BottomNavBarTappedEvent extends MainHomeEvent {
  final int index;
  BottomNavBarTappedEvent(this.index);
}

class PageChangedEvent extends MainHomeEvent {
  final int index;
  PageChangedEvent(this.index);
}
