import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elevate_tracking_app/api/client/api_client.dart';
import 'package:elevate_tracking_app/api/mapper/orders_mapper.dart';
import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/core/api_result/safe_api_call.dart';
import 'package:elevate_tracking_app/domain/entites/order_firestore_entity.dart';
import 'package:elevate_tracking_app/domain/entites/start_order_entity.dart';
import 'package:injectable/injectable.dart';

import '../../data/data_source/orders_remote_data_source.dart';
import '../../domain/entites/pending_orders_entity.dart';

@Injectable(as: OrdersRemoteDataSource)
class OrdersRemoteDataSourceImpl implements OrdersRemoteDataSource {
  final ApiClient _apiClient;
  final FirebaseFirestore _firestore;

  OrdersRemoteDataSourceImpl(this._apiClient, this._firestore);

  @override
  Future<ApiResult<PendingOrdersEntity>> getOrders(int? page) {
    return safeApiCall(
      () => _apiClient.getOrders(page),
      (response) => response.toEntity(),
    );
  }

  @override
  Future<ApiResult<StartOrderEntity>> startOrder(String orderId) async {
    return safeApiCall(() => _apiClient.startOrder(orderId), (response) {
      return response.orders!.toEntity();
    });
  }

  @override
  Future<ApiResult<bool>> addFirestoreOrder(OrderFirestoreEntity order) async {
    try {
      final collection = _firestore.collection('orders');
      await collection
          .doc(order.order?.id ?? "")
          .set(order.toMap(), SetOptions(merge: true));
      return ApiSuccessResult(true);
    } catch (e) {
      return ApiErrorResult(e);
    }
  }

  @override
  Future<ApiResult<OrderFirestoreEntity>> getFirestoreOrder(
    String orderId,
  ) async {
    try {
      final doc = await _firestore.collection('orders').doc(orderId).get();
      if (doc.exists) {
        return ApiSuccessResult(OrderFirestoreEntity.fromMap(doc.data()!));
      } else {
        return ApiErrorResult("Document does not exist");
      }
    } catch (e) {
      return ApiErrorResult(e);
    }
  }

  @override
  Stream<ApiResult<OrderFirestoreEntity>> streamFirestoreOrder(String orderId) async* {
    try {
      await for (final doc in _firestore.collection('orders').doc(orderId).snapshots()) {
        if (doc.exists) {
          yield ApiSuccessResult(OrderFirestoreEntity.fromMap(doc.data()!));
        } else {
          yield ApiErrorResult("Document does not exist");
        }
      }
    } catch (e) {
      yield ApiErrorResult(e.toString());
    }
  }
}
