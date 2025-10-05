import 'package:elevate_tracking_app/domain/entites/driver_order_entity_driver_related.dart';
import '../../core/api_result/api_result.dart';

abstract interface class OrdersRemoteDataSource {

  Future<ApiResult<List<DriverOrderEntityDriverRelated>>> getAllDriverOrders();
}
