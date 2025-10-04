import 'package:elevate_tracking_app/domain/repo/orders_repo.dart';
import 'package:injectable/injectable.dart';

import '../../core/api_result/api_result.dart';
import '../entities/pending_orders_entity.dart';

@injectable
class GetAllPendingOrdersUseCase {
  final OrdersRepo _ordersRepo;

  GetAllPendingOrdersUseCase(this._ordersRepo);

  Future<ApiResult<PendingOrdersEntity>> call({int? page}) async {
    return await _ordersRepo.getOrders(page);
  }
}
