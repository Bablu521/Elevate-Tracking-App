import 'package:elevate_tracking_app/domain/repo/orders_repo.dart';
import 'package:injectable/injectable.dart';

import '../../core/api_result/api_result.dart';
import '../entites/start_order_entity.dart';

@injectable
class StartOrderUseCase {
  final OrdersRepo _ordersRepo;

  StartOrderUseCase(this._ordersRepo);

  Future<ApiResult<StartOrderEntity>> call({required String orderId}) async {
    return await _ordersRepo.startOrder(orderId);
  }
}
