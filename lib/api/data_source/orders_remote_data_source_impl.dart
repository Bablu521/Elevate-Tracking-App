import 'package:elevate_tracking_app/api/client/api_client.dart';
import 'package:elevate_tracking_app/api/mapper/driver_orders_driver_related_mapper.dart';
import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/core/api_result/safe_api_call.dart';
import 'package:elevate_tracking_app/data/data_source/orders_remote_data_source.dart';
import 'package:elevate_tracking_app/domain/entites/driver_order_entity_driver_related.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OrdersRemoteDataSource)
class OrdersRemoteDataSourceImpl implements OrdersRemoteDataSource {
  final ApiClient _apiClient;

  OrdersRemoteDataSourceImpl(this._apiClient);

  @override
  Future<ApiResult<List<DriverOrderEntityDriverRelated>>> getAllDriverOrders() {
    return safeApiCall(
      () => _apiClient.getAllDriverOrders(),
      (response) => response.orders!.map((e) => e.toEntity()).toList(),
    );
  }
}
