import 'package:elevate_tracking_app/api/client/api_client.dart';
import 'package:elevate_tracking_app/api/mapper/orders_mapper.dart';
import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/core/api_result/safe_api_call.dart';
import 'package:elevate_tracking_app/domain/entites/start_order_entity.dart';
import 'package:injectable/injectable.dart';

import '../../data/data_source/orders_remote_data_source.dart';
import '../../domain/entites/pending_orders_entity.dart';

@Injectable(as: OrdersRemoteDataSource)
class OrdersRemoteDataSourceImpl implements OrdersRemoteDataSource {
  final ApiClient _apiClient;

  OrdersRemoteDataSourceImpl(this._apiClient);

  @override
  Future<ApiResult<PendingOrdersEntity>> getOrders(int? page) {
    return safeApiCall(
      () => _apiClient.getOrders(page),
      (response) => response.toEntity(),
    );
  }

  @override
  Future<ApiResult<StartOrderEntity>> startOrder(String orderId) {
    return safeApiCall(
      () => _apiClient.startOrder(orderId),
      (response) => response.orders!.toEntity(),
    );
  }
}
