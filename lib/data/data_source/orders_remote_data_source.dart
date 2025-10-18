import '../../core/api_result/api_result.dart';
import '../../domain/entities/pending_orders_entity.dart';
import '../../domain/entities/start_order_entity.dart';
import 'package:elevate_tracking_app/domain/entites/driver_order_entity_driver_related.dart';

abstract interface class OrdersRemoteDataSource {
  Future<ApiResult<PendingOrdersEntity>> getOrders(int? page);

  Future<ApiResult<StartOrderEntity>> startOrder(String orderId);

  Future<ApiResult<List<DriverOrderEntityDriverRelated>>> getAllDriverOrders();
  
}
