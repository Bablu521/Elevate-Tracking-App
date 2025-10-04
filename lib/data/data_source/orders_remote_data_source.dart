import '../../core/api_result/api_result.dart';
import '../../domain/entities/pending_orders_entity.dart';
import '../../domain/entities/start_order_entity.dart';

abstract interface class OrdersRemoteDataSource {
  Future<ApiResult<PendingOrdersEntity>> getOrders(int? page);

  Future<ApiResult<StartOrderEntity>> startOrder(String orderId);
}
