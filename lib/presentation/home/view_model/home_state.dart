part of 'home_view_model.dart';

final class HomeState extends Equatable {
  final bool isLoading;
  final bool isLoadingMore;
  final String? errorMessage;
  final List<OrderEntity>? ordersList;
  final StartOrderEntity? startOrderEntity;

  const HomeState({
    this.isLoading = false,
    this.isLoadingMore = false,
    this.errorMessage,
    this.ordersList,
    this.startOrderEntity,
  });

  HomeState copyWith({
    bool? isLoading,
    bool? isLoadingMore,
    String? errorMessage,
    List<OrderEntity>? ordersList,
    StartOrderEntity? startOrderEntity,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      errorMessage: errorMessage ?? this.errorMessage,
      ordersList: ordersList ?? this.ordersList,
      startOrderEntity: startOrderEntity ?? this.startOrderEntity,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isLoadingMore,
    errorMessage,
    ordersList,
    startOrderEntity,
  ];
}
