part of 'home_view_model.dart';

final class HomeState extends Equatable {
  final bool isLoading;
  final bool isLoadingMore;
  final String? errorMessage;
  final List<OrderEntity>? ordersList;
  final bool isAcceptSuccess;

  const HomeState({
    this.isLoading = false,
    this.isLoadingMore = false,
    this.errorMessage,
    this.ordersList,
    this.isAcceptSuccess = false,
  });

  HomeState copyWith({
    bool? isLoading,
    bool? isLoadingMore,
    String? errorMessage,
    List<OrderEntity>? ordersList,
    bool? isAcceptSuccess,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      errorMessage: errorMessage,
      ordersList: ordersList ?? this.ordersList,
      isAcceptSuccess: isAcceptSuccess ?? false,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isLoadingMore,
    errorMessage,
    ordersList,
    isAcceptSuccess,
  ];
}
