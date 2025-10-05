import 'package:elevate_tracking_app/api/models/responses/driver_orders_response_dto/driver_order_dto_driver_related.dart';
import 'package:elevate_tracking_app/api/models/responses/driver_orders_response_dto/order_dto_driver_related.dart';
import 'package:elevate_tracking_app/api/models/responses/driver_orders_response_dto/order_item_dto_driver_related.dart';
import 'package:elevate_tracking_app/api/models/responses/driver_orders_response_dto/product_dto_driver_related.dart';
import 'package:elevate_tracking_app/api/models/responses/driver_orders_response_dto/shipping_address_dto_driver_related.dart';
import 'package:elevate_tracking_app/api/models/responses/driver_orders_response_dto/store_dto_driver_related.dart';
import 'package:elevate_tracking_app/api/models/responses/driver_orders_response_dto/user_dto_driver_related.dart';
import 'package:elevate_tracking_app/domain/entites/driver_order_entity_driver_related.dart';
import 'package:elevate_tracking_app/domain/entites/order_entity_driver_related.dart';
import 'package:elevate_tracking_app/domain/entites/order_item_entity_driver_related.dart';
import 'package:elevate_tracking_app/domain/entites/product_entity_driver_related.dart';
import 'package:elevate_tracking_app/domain/entites/shipping_address_entity_driver_related.dart';
import 'package:elevate_tracking_app/domain/entites/store_entity_driver_related.dart';
import 'package:elevate_tracking_app/domain/entites/user_entity_driver_related.dart';

extension DriverOrderDtoDriverRelatedMapper on DriverOrderDtoDriverRelated {
  DriverOrderEntityDriverRelated toEntity() {
    return DriverOrderEntityDriverRelated(
      id: id,
      driver: driver,
      order: order?.toEntity(),
      store: store?.toEntity(),
      v: v,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension OrderDtoDriverRelatedMapper on OrderDtoDriverRelated {
  OrderEntityDriverRelated toEntity() {
    return OrderEntityDriverRelated(
      id: id,
      user: user?.toEntity(),
      orderItems: orderItems?.map((e) => e.toEntity()).toList(),
      totalPrice: totalPrice,
      paymentType: paymentType,
      isPaid: isPaid,
      isDelivered: isDelivered,
      state: state,
      createdAt: createdAt,
      updatedAt: updatedAt,
      orderNumber: orderNumber,
      v: v,
      paidAt: paidAt,
      shippingAddress: shippingAddress?.toEntity(),
    );
  }
}

extension OrderItemDtoDriverRelatedMapper on OrderItemDtoDriverRelated {
  OrderItemEntityDriverRelated toEntity() {
    return OrderItemEntityDriverRelated(
      id: id,
      product: product?.toEntity(),
      price: price,
      quantity: quantity,
    );
  }
}

extension ProductDtoDriverRelatedMapper on ProductDtoDriverRelated {
  ProductEntityDriverRelated toEntity() {
    return ProductEntityDriverRelated(id: id, price: price);
  }
}

extension ShippingAddressDtoDriverRelatedMapper
    on ShippingAddressDtoDriverRelated {
  ShippingAddressEntityDriverRelated toEntity() {
    return ShippingAddressEntityDriverRelated(
      street: street,
      city: city,
      phone: phone,
      lat: lat,
      long: long,
    );
  }
}

extension UserDtoDriverRelatedMapper on UserDtoDriverRelated {
  UserEntityDriverRelated toEntity() {
    return UserEntityDriverRelated(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      gender: gender,
      phone: phone,
      photo: photo,
      passwordChangedAt: passwordChangedAt,
      passwordResetCode: passwordResetCode,
      passwordResetExpires: passwordResetExpires,
      resetCodeVerified: resetCodeVerified,
    );
  }
}

extension StoreDtoDriverRelatedMapper on StoreDtoDriverRelated {
  StoreEntityDriverRelated toEntity() {
    return StoreEntityDriverRelated(
      name: name,
      image: image,
      address: address,
      phoneNumber: phoneNumber,
      latLong: latLong,
    );
  }
}
