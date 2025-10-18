import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/domain/entities/pending_orders_entity.dart';
import '../entities/start_order_entity.dart';

abstract interface class OrdersRepo {
  Future<ApiResult<PendingOrdersEntity>> getOrders(int? page);

  Future<ApiResult<StartOrderEntity>> startOrder(String orderId);
}
