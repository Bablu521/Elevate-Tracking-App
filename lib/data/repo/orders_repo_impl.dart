import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/domain/entites/start_order_entity.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entites/pending_orders_entity.dart';
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
}
