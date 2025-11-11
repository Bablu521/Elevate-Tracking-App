import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/domain/entites/driver_order_entity_driver_related.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repo/orders_repo.dart';
import '../data_source/orders_remote_data_source.dart';

@Injectable(as: OrdersRepo)
class OrdersRepoImpl implements OrdersRepo {
  final OrdersRemoteDataSource _ordersRemoteDataSource;

  OrdersRepoImpl(this._ordersRemoteDataSource);

  @override
  Future<ApiResult<List<DriverOrderEntityDriverRelated>>> getAllDriverOrders() {
    return _ordersRemoteDataSource.getAllDriverOrders();
  }
}
