import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/domain/entites/driver_order_entity_driver_related.dart';
import 'package:elevate_tracking_app/domain/use_cases/get_all_driver_orders_use_case.dart';
import 'package:elevate_tracking_app/presentation/orders/view_models/driver_orders_events.dart';
import 'package:elevate_tracking_app/presentation/orders/view_models/driver_orders_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class DriverOrdersViewModel extends Cubit<DriverOrdersStates> {
  final GetAllDriverOrdersUseCase _getAllDriverOrdersUseCase;
  DriverOrdersViewModel(this._getAllDriverOrdersUseCase)
    : super(const DriverOrdersStates());

  void doIntent(DriverOrdersEvents event) {
    switch (event) {
      case OnGetAllDriverOrdersEvent():
        _getAllDriverOrders();
        break;
    }
  }

  Future<void> _getAllDriverOrders() async {
    emit(state.copyWith(driverOrdersLoading: true));
    final result = await _getAllDriverOrdersUseCase.call();
    switch (result) {
      case ApiSuccessResult<List<DriverOrderEntityDriverRelated>>():
        emit(
          state.copyWith(
            driverOrdersLoading: false,
            driverOrdersSuccess: result.data,
          ),
        );
      case ApiErrorResult<List<DriverOrderEntityDriverRelated>>():
        emit(
          state.copyWith(
            driverOrdersLoading: false,
            driverOrdersErrorMessage: result.errorMessage,
          ),
        );
    }
  }
}
