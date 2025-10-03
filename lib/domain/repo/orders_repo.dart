import 'package:elevate_tracking_app/core/api_result/api_result.dart';

import '../entites/order_entity.dart';
import '../entites/start_order_entity.dart';

abstract interface class OrdersRepo {
  Future<ApiResult<List<OrderEntity>>> getOrders();
  Future<ApiResult<StartOrderEntity>> startOrder(String orderId);
}
