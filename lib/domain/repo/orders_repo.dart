import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/domain/entites/driver_order_entity_driver_related.dart';

abstract interface class OrdersRepo {

  Future<ApiResult<List<DriverOrderEntityDriverRelated>>> getAllDriverOrders();
}
