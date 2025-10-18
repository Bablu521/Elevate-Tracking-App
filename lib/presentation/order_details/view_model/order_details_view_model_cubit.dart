import 'dart:async';
import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/core/base_state/base_state.dart';
import 'package:elevate_tracking_app/domain/entites/order_firestore_entity.dart';
import 'package:elevate_tracking_app/domain/use_cases/add_order_to_firestore_use_case.dart';
import 'package:elevate_tracking_app/domain/use_cases/stream_order_from_firestore_use_case.dart';
import 'package:elevate_tracking_app/generated/l10n.dart';
import 'package:elevate_tracking_app/presentation/order_details/view_model/order_details_event.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher.dart';
part 'order_details_view_model_state.dart';

@injectable
class OrderDetailsViewModelCubit extends Cubit<OrderDetailsViewModelState> {
  OrderDetailsViewModelCubit(
    this._streamOrderFromFirestoreUseCase,
    this._addOrderToFirestoreUseCase,
  ) : super(const OrderDetailsViewModelState());
  final StreamOrderFromFirestoreUseCase _streamOrderFromFirestoreUseCase;
  final AddOrderToFirestoreUseCase _addOrderToFirestoreUseCase;
  StreamSubscription? _orderSubscription;
  void doIntent(OrderDetailsEvent event) {
    switch (event) {
      case OrderDetailsGetOrderFromFireBase():
        _getOrderFromFireBase(orderId: event.orderId);
      case OrderDetailsUpdateOrderStatus():
        _updateOrderStatus();
      case OrderDetailsDirectToWhatsApp():
        _openWhatsApp(phone: event.phoneNumber);
      case OrderDetailsDirectToCallNumber():
        _callNumber(event.phoneNumber);
    }
  }

  final List<String> _orderStatus = [
    "pending",
    "picked",
    "out for delivery",
    "arrived",
    "delivered",
  ];
  final List<String> buttonTitle = [
    AppLocalizations().arrivedAtPickupPoint,
    AppLocalizations().arrivedAtPickupPoint,
    AppLocalizations().startDeliver,
    AppLocalizations().startDeliver,
    AppLocalizations().deliveredToTheUser,
  ];
  bool isDelivered = false;
  int orderStateNumber = 0;
  Future<void> _getOrderFromFireBase({required String orderId}) async {
    emit(state.copyWith(orderDetails: BaseState.loading()));
    await _orderSubscription?.cancel();
    _orderSubscription = _streamOrderFromFirestoreUseCase
        .call(orderId: orderId)
        .listen((result) {
          switch (result) {
            case ApiSuccessResult<OrderFirestoreEntity>():
              isDelivered = result.data.order?.state == _orderStatus.last;
              _getStatusOrder(result.data.order?.state);
              emit(
                state.copyWith(orderDetails: BaseState.success(result.data)),
              );
            case ApiErrorResult<OrderFirestoreEntity>():
              emit(
                state.copyWith(
                  orderDetails: BaseState.error(result.errorMessage),
                ),
              );
          }
        });
  }

  int _getStatusOrder(String? orderStatus) {
    final int currentIndex = _orderStatus.indexOf(
      orderStatus ?? _orderStatus.first,
    );
    orderStateNumber = (currentIndex).clamp(0, _orderStatus.length - 1);
    return orderStateNumber;
  }

  Future<void> _updateOrderStatus() async {
    emit(state.copyWith(updateOrderStatus: BaseState.loading()));
    final int nextIndex =
        _getStatusOrder(state.orderDetails?.data?.order?.state) + 1;
    isDelivered = nextIndex == _orderStatus.length - 1;
    final result = await _addOrderToFirestoreUseCase.call(
      order: state.orderDetails!.data!.copyWith(
        order: state.orderDetails!.data!.order!.copyWith(
          state: _orderStatus[nextIndex],
          id: state.orderDetails?.data?.order?.id,
        ),
      ),
    );
    switch (result) {
      case ApiSuccessResult<bool>():
        emit(state.copyWith(updateOrderStatus: BaseState.success(result.data)));
      case ApiErrorResult<bool>():
        emit(
          state.copyWith(
            updateOrderStatus: BaseState.error(result.errorMessage),
          ),
        );
    }
  }

  Future<void> _openWhatsApp({
    required String phone,
    String message = '',
  }) async {
    final Uri whatsappUri = Uri.parse(
      "https://wa.me/$phone?text=${Uri.encodeComponent(message)}",
    );

    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
    } else {
      throw Exception("Could not launch WhatsApp");
    }
  }

  Future<void> _callNumber(String phoneNumber) async {
    final Uri callUri = Uri(scheme: 'tel', path: phoneNumber);

    if (await canLaunchUrl(callUri)) {
      await launchUrl(callUri, mode: LaunchMode.externalApplication);
    } else {
      throw Exception('Could not launch dialer');
    }
  }

  @override
  Future<void> close() {
    _orderSubscription?.cancel();
    return super.close();
  }
}
