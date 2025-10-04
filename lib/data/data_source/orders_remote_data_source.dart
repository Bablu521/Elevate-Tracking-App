import '../../core/api_result/api_result.dart';
import '../../domain/entites/pending_orders_entity.dart';
import '../../domain/entites/start_order_entity.dart';

abstract interface class OrdersRemoteDataSource {
  Future<ApiResult<PendingOrdersEntity>> getOrders(int? page);

  Future<ApiResult<StartOrderEntity>> startOrder(String orderId);
}
