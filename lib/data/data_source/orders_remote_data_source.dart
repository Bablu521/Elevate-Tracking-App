import '../../core/api_result/api_result.dart';
import '../../domain/entites/order_entity.dart';

abstract interface class OrdersRemoteDataSource {
  Future<ApiResult<List<OrderEntity>>> getOrders();
}