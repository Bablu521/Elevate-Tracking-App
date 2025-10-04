import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/domain/entites/start_order_entity.dart';
import 'package:elevate_tracking_app/domain/use_cases/start_order_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entites/order_entity.dart';
import '../../../domain/entites/pending_orders_entity.dart';
import '../../../domain/use_cases/get_all_pending_orders_use_case.dart';
import 'home_events.dart';

part 'home_state.dart';

@injectable
class HomeViewModel extends Cubit<HomeState> {
  final GetAllPendingOrdersUseCase _getAllPendingOrdersUseCase;
  final StartOrderUseCase _startOrderUseCase;

  HomeViewModel(this._getAllPendingOrdersUseCase, this._startOrderUseCase)
    : super(const HomeState());

  int currentPage = 1;
  int totalPages = 0;

  List<OrderEntity>? ordersList;

  ValueNotifier<int> acceptOrderIndex = ValueNotifier(-1);
  ValueNotifier<int> rejectOrderIndex = ValueNotifier(-1);

  void doIntent(HomeEvents events) {
    switch (events) {
      case GetOrdersEvent():
        _getOrders();
      case AcceptOrderEvent():
        _acceptOrder(events.index);
      case RejectOrderEvent():
        _rejectOrder(events.index);
      case LoadMoreOrdersEvent():
        _loadMoreOrders();
    }
  }

  Future<void> _getOrders() async {
    emit(const HomeState(isLoading: true));
    final result = await _getAllPendingOrdersUseCase();
    switch (result) {
      case ApiSuccessResult<PendingOrdersEntity>():
        currentPage = result.data.metadata?.currentPage ?? 0;
        totalPages = result.data.metadata?.totalPages ?? 0;
        ordersList = result.data.orders;
        emit(state.copyWith(isLoading: false, ordersList: ordersList));
        break;
      case ApiErrorResult<PendingOrdersEntity>():
        emit(
          state.copyWith(isLoading: false, errorMessage: result.errorMessage),
        );
        break;
    }
  }

  Future<void> _acceptOrder(int index) async {
    acceptOrderIndex.value = index;
    final result = await _startOrderUseCase(
      orderId: ordersList?[index].id ?? "",
    );
    switch (result) {
      case ApiSuccessResult<StartOrderEntity>():
        ordersList?.removeAt(index);
        emit(state.copyWith(ordersList: ordersList));
      case ApiErrorResult<StartOrderEntity>():
        emit(state.copyWith(errorMessage: result.errorMessage));
    }
    acceptOrderIndex.value = -1;
  }

  void _rejectOrder(int index) {
    rejectOrderIndex.value = index;
    ordersList?.removeAt(index);
    emit(state.copyWith(ordersList: ordersList));
    rejectOrderIndex.value = -1;
  }

  Future<void> _loadMoreOrders() async {
    if (currentPage >= totalPages) return;
    currentPage++;

    emit(state.copyWith(isLoadingMore: true));
    final result = await _getAllPendingOrdersUseCase(page: currentPage);
    switch (result) {
      case ApiSuccessResult<PendingOrdersEntity>():
        currentPage = result.data.metadata?.currentPage ?? 0;
        totalPages = result.data.metadata?.totalPages ?? 0;
        ordersList?.addAll(result.data.orders ?? []);
        emit(state.copyWith(isLoadingMore: false, ordersList: ordersList));
        break;
      case ApiErrorResult<PendingOrdersEntity>():
        emit(
          state.copyWith(
            isLoadingMore: false,
            errorMessage: result.errorMessage,
          ),
        );
        break;
    }
  }
}
