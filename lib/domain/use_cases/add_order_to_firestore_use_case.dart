import 'package:elevate_tracking_app/domain/repo/orders_repo.dart';
import 'package:injectable/injectable.dart';

import '../../core/api_result/api_result.dart';
import '../entites/order_firestore_entity.dart';

@injectable
class AddOrderToFirestoreUseCase {
  final OrdersRepo _ordersRepo;

  AddOrderToFirestoreUseCase(this._ordersRepo);

  Future<ApiResult<bool>> call({required OrderFirestoreEntity order}) {
    return _ordersRepo.addFirestoreOrder(order);
  }
}
