part of 'home_view_model.dart';

final class HomeState extends Equatable {
  final bool isLoading;
  final String? errorMessage;
  final List<OrderEntity>? orders;

  const HomeState({this.isLoading = false, this.errorMessage, this.orders});

  HomeState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<OrderEntity>? orders,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      orders: orders ?? this.orders,
    );
  }

  @override
  List<Object?> get props => [isLoading, errorMessage, orders];
}
