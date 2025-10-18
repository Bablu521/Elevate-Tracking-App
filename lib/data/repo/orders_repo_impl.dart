import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/domain/entities/start_order_entity.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/pending_orders_entity.dart';
import 'package:elevate_tracking_app/domain/entites/driver_order_entity_driver_related.dart';
import '../../domain/repo/orders_repo.dart';
import '../data_source/orders_remote_data_source.dart';

@Injectable(as: OrdersRepo)
class OrdersRepoImpl implements OrdersRepo {
  final OrdersRemoteDataSource _ordersRemoteDataSource;

  OrdersRepoImpl(this._ordersRemoteDataSource);

  @override
  Future<ApiResult<PendingOrdersEntity>> getOrders(int? page) {
    return _ordersRemoteDataSource.getOrders(page);
  }

  @override
  Future<ApiResult<StartOrderEntity>> startOrder(String orderId) {
    return _ordersRemoteDataSource.startOrder(orderId);
  }

  @override
  Future<ApiResult<List<DriverOrderEntityDriverRelated>>> getAllDriverOrders() {
    return _ordersRemoteDataSource.getAllDriverOrders();
  }

  @override
  Future<ApiResult<bool>> addFirestoreOrder(OrderFirestoreEntity order) {
    return _ordersRemoteDataSource.addFirestoreOrder(order);
  }

  @override
  Future<ApiResult<OrderFirestoreEntity>> getFirestoreOrder(String orderId) {
    return _ordersRemoteDataSource.getFirestoreOrder(orderId);
  }

  @override
  Stream<ApiResult<OrderFirestoreEntity>> streamFirestoreOrder(String orderId) {
    return _ordersRemoteDataSource.streamFirestoreOrder(orderId);
  }
}
