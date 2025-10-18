
import 'package:elevate_tracking_app/domain/entities/order_item_entity.dart';
import 'package:elevate_tracking_app/domain/entities/shipping_address_entity.dart';
import 'package:elevate_tracking_app/domain/entities/store_entity.dart';
import 'package:elevate_tracking_app/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';


class OrderEntity extends Equatable {
  final String? id;
  final UserEntity? user;
  final List<OrderItemEntity>? orderItems;
  final int? totalPrice;
  final ShippingAddressEntity? shippingAddress;
  final String? paymentType;
  final bool? isPaid;
  final bool? isDelivered;
  final String? state;
  final String? createdAt;
  final String? updatedAt;
  final String? orderNumber;
  final int? v;
  final StoreEntity? store;

  const OrderEntity({
    this.id,
    this.user,
    this.orderItems,
    this.totalPrice,
    this.shippingAddress,
    this.paymentType,
    this.isPaid,
    this.isDelivered,
    this.state,
    this.createdAt,
    this.updatedAt,
    this.orderNumber,
    this.v,
    this.store,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user': user?.toMap(),
      'orderItems': orderItems?.map((item) => item.toMap()).toList(),
      'totalPrice': totalPrice,
      'shippingAddress': shippingAddress?.toMap(),
      'paymentType': paymentType,
      'isPaid': isPaid,
      'isDelivered': isDelivered,
      'state': state,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'orderNumber': orderNumber,
      'v': v,
      'store': store?.toMap(),
    };
  }

  factory OrderEntity.fromMap(Map<String, dynamic> map) {
    return OrderEntity(
      id: map['id'] as String?,
      user: UserEntity.fromMap(Map<String, dynamic>.from(map['user'])),
      orderItems: List<Map<String, dynamic>>.from(
        map['orderItems'],
      ).map((item) => OrderItemEntity.fromMap(item)).toList(),
      totalPrice: map['totalPrice'] as int?,
      shippingAddress: map['shippingAddress'] != null
          ? ShippingAddressEntity.fromMap(
        Map<String, dynamic>.from(map['shippingAddress']),
      )
          : _fakeShippingAddress,
      paymentType: map['paymentType'] as String?,
      isPaid: map['isPaid'] as bool?,
      isDelivered: map['isDelivered'] as bool?,
      state: map['state'] as String?,
      createdAt: map['createdAt'] as String?,
      updatedAt: map['updatedAt'] as String?,
      orderNumber: map['orderNumber'] as String?,
      v: map['v'] as int?,
      store: StoreEntity.fromMap(Map<String, dynamic>.from(map['store'])),
    );
  }

  static final _fakeShippingAddress = const ShippingAddressEntity(
    street: '456 Oak Avenue',
    city: 'Metropolis',
    phone: '555-555-5555',
    lat: '34.0522',
    long: '-118.2437',
  );

  OrderEntity copyWith({
    String? id,
    UserEntity? user,
    List<OrderItemEntity>? orderItems,
    int? totalPrice,
    ShippingAddressEntity? shippingAddress,
    String? paymentType,
    bool? isPaid,
    bool? isDelivered,
    String? state,
    String? createdAt,
    String? updatedAt,
    String? orderNumber,
    int? v,
    StoreEntity? store,
  }) {
    return OrderEntity(
      id: id ?? this.id,
      user: user ?? this.user,
      orderItems: orderItems ?? this.orderItems,
      totalPrice: totalPrice ?? this.totalPrice,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      paymentType: paymentType ?? this.paymentType,
      isPaid: isPaid ?? this.isPaid,
      isDelivered: isDelivered ?? this.isDelivered,
      state: state ?? this.state,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      orderNumber: orderNumber ?? this.orderNumber,
      v: v ?? this.v,
      store: store ?? this.store,
    );
  }

  @override
  List<Object?> get props => [
    id,
    user,
    orderItems,
    totalPrice,
    shippingAddress,
    paymentType,
    isPaid,
    isDelivered,
    state,
    createdAt,
    updatedAt,
    orderNumber,
    v,
    store,
  ];
}
