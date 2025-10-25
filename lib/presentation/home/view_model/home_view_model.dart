import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/core/utils/location_manager.dart';
import 'package:elevate_tracking_app/core/utils/token_storage/token_storage.dart';
import 'package:elevate_tracking_app/domain/use_cases/get_logged_driver_data_use_case.dart';
import 'package:elevate_tracking_app/domain/use_cases/start_order_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entites/driver_entity.dart';
import '../../../domain/entites/live_location_entity.dart';
import '../../../domain/entites/order_firestore_entity.dart';
import '../../../domain/entities/order_entity.dart';
import '../../../domain/entities/pending_orders_entity.dart';
import '../../../domain/entities/start_order_entity.dart';
import '../../../domain/use_cases/add_order_to_firestore_use_case.dart';
import '../../../domain/use_cases/get_all_pending_orders_use_case.dart';
import 'home_events.dart';

part 'home_state.dart';

@injectable
class HomeViewModel extends Cubit<HomeState> {
  final GetAllPendingOrdersUseCase _getAllPendingOrdersUseCase;
  final StartOrderUseCase _startOrderUseCase;
  final GetLoggedDriverDataUseCase _getLoggedDriverDataUseCase;
  final AddOrderToFirestoreUseCase _addOrderToFirestoreUseCase;

  HomeViewModel(
    this._getAllPendingOrdersUseCase,
    this._startOrderUseCase,
    this._getLoggedDriverDataUseCase,
    this._addOrderToFirestoreUseCase,
  ) : super(const HomeState());

  ValueNotifier<int> acceptOrderIndex = ValueNotifier(-1);
  ValueNotifier<int> rejectOrderIndex = ValueNotifier(-1);

  int currentPage = 1;
  int totalPages = 0;
  bool isLoadMore = false;

  late DriverEntity driverEntity;

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
    final isAcceptOrder = await TokenStorage.getIsAcceptOrder();
    if (isAcceptOrder != null) {
      emit(state.copyWith(isFinish: true, orderId: isAcceptOrder));
      return;
    }
    emit(state.copyWith(isLoading: true));
    final driverData = await _getLoggedDriverDataUseCase();
    switch (driverData) {
      case ApiSuccessResult<DriverEntity>():
        driverEntity = driverData.data;
      case ApiErrorResult<DriverEntity>():
        state.copyWith(isLoading: false, errorMessage: driverData.errorMessage);
    }
    final result = await _getAllPendingOrdersUseCase();
    switch (result) {
      case ApiSuccessResult<PendingOrdersEntity>():
        currentPage = result.data.metadata?.currentPage ?? 0;
        totalPages = result.data.metadata?.totalPages ?? 0;
        emit(state.copyWith(isLoading: false, ordersList: result.data.orders));
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
      orderId: state.ordersList?[index].id ?? "",
    );
    switch (result) {
      case ApiSuccessResult<StartOrderEntity>():
        final updatedList = List<OrderEntity>.from(state.ordersList ?? []);
        await addOrderToFirestore(index);
        updatedList.removeAt(index);
        emit(state.copyWith(ordersList: updatedList, isAcceptSuccess: true));
      case ApiErrorResult<StartOrderEntity>():
        emit(state.copyWith(errorMessage: result.errorMessage));
    }
    acceptOrderIndex.value = -1;
  }

  void _rejectOrder(int index) {
    rejectOrderIndex.value = index;
    final updatedList = List<OrderEntity>.from(state.ordersList ?? []);
    updatedList.removeAt(index);
    emit(state.copyWith(ordersList: updatedList));
    rejectOrderIndex.value = -1;
  }

  Future<void> _loadMoreOrders() async {
    if (isLoadMore || currentPage >= totalPages) return;
    currentPage++;
    isLoadMore = true;

    emit(state.copyWith(isLoadingMore: true));
    final result = await _getAllPendingOrdersUseCase(page: currentPage);
    switch (result) {
      case ApiSuccessResult<PendingOrdersEntity>():
        currentPage = result.data.metadata?.currentPage ?? 0;
        totalPages = result.data.metadata?.totalPages ?? 0;
        final updatedList = List<OrderEntity>.from(state.ordersList ?? []);
        updatedList.addAll(result.data.orders ?? []);
        emit(state.copyWith(isLoadingMore: false, ordersList: updatedList));
        isLoadMore = false;
        break;
      case ApiErrorResult<PendingOrdersEntity>():
        emit(
          state.copyWith(
            isLoadingMore: false,
            errorMessage: result.errorMessage,
          ),
        );
        isLoadMore = false;
        break;
    }
  }

  Future<void> addOrderToFirestore(int index) async {
    final liveLocation = await LocationManager.getCurrentLocation();
    final result = await _addOrderToFirestoreUseCase(
      order: OrderFirestoreEntity(
        driver: driverEntity,
        order: state.ordersList?[index],
        location:  LiveLocationEntity(
          lat: liveLocation.latitude.toString(),
          long: liveLocation.longitude.toString(),
          address: driverEntity.country,
        ),
      ),
    );

    switch (result) {
      case ApiSuccessResult<bool>():
        TokenStorage.saveIsAcceptOrder(state.ordersList?[index].id ?? "");
        emit(state.copyWith(isFinish: true, orderId: state.ordersList?[index].id));
      case ApiErrorResult<bool>():
        emit(state.copyWith(errorMessage: result.errorMessage));
    }
  }
}
