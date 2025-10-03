import 'package:bloc/bloc.dart';
import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/domain/use_cases/start_order_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entites/order_entity.dart';
import '../../../domain/use_cases/get_all_pending_orders_use_case.dart';
import 'home_events.dart';

part 'home_state.dart';

@injectable
class HomeViewModel extends Cubit<HomeState> {
  final GetAllPendingOrdersUseCase _getAllPendingOrdersUseCase;
  final StartOrderUseCase _startOrderUseCase;

  HomeViewModel(this._getAllPendingOrdersUseCase, this._startOrderUseCase)
    : super(const HomeState());

  void doIntent(HomeEvents events) {
    switch (events) {
      case TestEvent():
    }
  }

  Future<void> getOrders() async {
    emit(const HomeState(isLoading: true));
    final result = await _getAllPendingOrdersUseCase();
    switch (result) {
      case ApiSuccessResult<List<OrderEntity>>():
        emit(state.copyWith(isLoading: false, orders: result.data));
        break;
      case ApiErrorResult<List<OrderEntity>>():
        emit(
          state.copyWith(isLoading: false, errorMessage: result.errorMessage),
        );
        break;
    }
  }
}
