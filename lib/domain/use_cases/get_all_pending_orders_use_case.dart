import 'package:elevate_tracking_app/domain/repo/orders_repo.dart';
import 'package:injectable/injectable.dart';

import '../../core/api_result/api_result.dart';
import '../entites/order_entity.dart';

@injectable
class GetAllPendingOrdersUseCase {
  final OrdersRepo _ordersRepo;

  GetAllPendingOrdersUseCase(this._ordersRepo);

  Future<ApiResult<List<OrderEntity>>> call() async {
    return await _ordersRepo.getOrders();
  }
}
