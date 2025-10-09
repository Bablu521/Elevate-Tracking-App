import 'package:elevate_tracking_app/domain/repo/orders_repo.dart';
import 'package:injectable/injectable.dart';

import '../../core/api_result/api_result.dart';
import '../entites/order_firestore_entity.dart';

@injectable
class GetOrderFromFirestoreUseCase {
  final OrdersRepo _ordersRepo;

  GetOrderFromFirestoreUseCase(this._ordersRepo);

  Future<ApiResult<OrderFirestoreEntity>> call({required String orderId}) {
    return _ordersRepo.getFirestoreOrder(orderId);
  }
}
