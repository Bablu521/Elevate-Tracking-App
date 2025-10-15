import 'package:elevate_tracking_app/api/base_state/base_state.dart';
import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/domain/entites/order_firestore_entity.dart';
import 'package:elevate_tracking_app/domain/use_cases/get_order_from_firestore_use_case.dart';
import 'package:elevate_tracking_app/presentation/order_details/view_model/order_details_event.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'order_details_view_model_state.dart';

@injectable
class OrderDetailsViewModelCubit extends Cubit<OrderDetailsViewModelState> {
  OrderDetailsViewModelCubit(this._getOrderFromFirestoreUseCase)
    : super(const OrderDetailsViewModelState());
  final GetOrderFromFirestoreUseCase _getOrderFromFirestoreUseCase;
  void doIntent(OrderDetailsEvent event) {
    switch (event) {
      case OrderDetailsGetOrderFromFireBase():
        _getOrderFromFireBase(orderId: event.orderId);
      case OrderDetailsUpdateOrderStatus():
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }

  Future<void> _getOrderFromFireBase({required String orderId}) async {
    emit(state.copyWith(orderDetails: BaseState.loading()));
    final result = await _getOrderFromFirestoreUseCase.call(orderId: orderId);
    switch (result) {
      case ApiSuccessResult<OrderFirestoreEntity>():
        emit(state.copyWith(orderDetails: BaseState.success(result.data)));
      case ApiErrorResult<OrderFirestoreEntity>():
        emit(
          state.copyWith(orderDetails: BaseState.error(result.errorMessage)),
        );
    }
  }
}
