import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/domain/entites/driver_order_entity_driver_related.dart';
import 'package:elevate_tracking_app/domain/repo/orders_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllDriverOrdersUseCase {
  final OrdersRepo _ordersRepo;

  GetAllDriverOrdersUseCase(this._ordersRepo);

  Future<ApiResult<List<DriverOrderEntityDriverRelated>>> call() async {
    return await _ordersRepo.getAllDriverOrders();
  }

}