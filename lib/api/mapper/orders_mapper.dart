import 'package:elevate_tracking_app/api/models/driver_order_dto.dart';
import 'package:elevate_tracking_app/domain/entites/driver_order_entity.dart';

import '../../domain/entites/meta_data_entity.dart';
import '../../domain/entites/order_entity.dart';
import '../../domain/entites/order_item_entity.dart';
import '../../domain/entites/pending_orders_entity.dart';
import '../../domain/entites/product_entity.dart';
import '../../domain/entites/shipping_address_entity.dart';
import '../../domain/entites/start_order_entity.dart';
import '../../domain/entites/start_order_items_entity.dart';
import '../../domain/entites/store_entity.dart';
import '../../domain/entites/user_entity.dart';
import '../models/meta_data_dto.dart';
import '../models/order_dto.dart';
import '../models/order_item_dto.dart';
import '../models/product_dto.dart';
import '../models/responses/orders/orders_response.dart';
import '../models/shipping_address_dto.dart';
import '../models/start_order_dto.dart';
import '../models/start_order_items_dto.dart';
import '../models/store_dto.dart';
import '../models/user_dto.dart';

extension DriverOrderMapper on DriverOrderDTO {
  DriverOrderEntity toEntity() {
    return DriverOrderEntity(
      id: id,
      driver: driver,
      order: order?.toEntity(),
      v: v,
      createdAt: createdAt,
      updatedAt: updatedAt,
      store: store?.toEntity(),
    );
  }
}

extension OrderMapper on OrderDTO {
  OrderEntity toEntity() {
    return OrderEntity(
      id: id,
      user: user?.toEntity(),
      orderItems: orderItems?.map((dto) => dto.toEntity()).toList(),
      totalPrice: totalPrice,
      shippingAddress: shippingAddress?.toEntity(),
      paymentType: paymentType,
      isPaid: isPaid,
      isDelivered: isDelivered,
      state: state,
      createdAt: createdAt,
      updatedAt: updatedAt,
      orderNumber: orderNumber,
      v: v,
      store: store?.toEntity(),
    );
  }
}

extension OrderItemMapper on OrderItemDTO {
  OrderItemEntity toEntity() {
    return OrderItemEntity(
      product: product?.toEntity(),
      price: price,
      quantity: quantity,
      id: id,
    );
  }
}

extension ProductMapper on ProductDTO {
  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      title: title,
      slug: slug,
      description: description,
      imgCover: imgCover,
      images: images,
      price: price,
      priceAfterDiscount: priceAfterDiscount,
      quantity: quantity,
      category: category,
      occasion: occasion,
      createdAt: createdAt,
      updatedAt: updatedAt,
      v: v,
      isSuperAdmin: isSuperAdmin,
      sold: sold,
      rateAvg: rateAvg,
      rateCount: rateCount,
    );
  }
}

extension StoreMapper on StoreDTO {
  StoreEntity toEntity() {
    return StoreEntity(
      name: name,
      image: image,
      address: address,
      phoneNumber: phoneNumber,
      latLong: latLong,
    );
  }
}

extension UserMapper on UserDTO {
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      gender: gender,
      phone: phone,
      photo: photo,
      passwordChangedAt: passwordChangedAt,
    );
  }
}

extension StartOrderMapper on StartOrderDto {
  StartOrderEntity toEntity() {
    return StartOrderEntity(
      id: id,
      user: user,
      orderItems: orderItems?.map((dto) => dto.toEntity()).toList(),
      totalPrice: totalPrice,
      paymentType: paymentType,
      isPaid: isPaid,
      isDelivered: isDelivered,
      state: state,
      createdAt: createdAt,
      updatedAt: updatedAt,
      orderNumber: orderNumber,
      v: v,
    );
  }
}

extension StartOrderItemsMapper on StartOrderItemsDto {
  StartOrderItemsEntity toEntity() {
    return StartOrderItemsEntity(
      product: product,
      price: price,
      quantity: quantity,
      id: id,
    );
  }
}

extension ShippingAddressMapper on ShippingAddressDTO {
  ShippingAddressEntity toEntity() {
    return ShippingAddressEntity(
      street: street,
      city: city,
      phone: phone,
      lat: lat,
      long: long,
    );
  }
}

extension MetaDataMapper on MetaDataDTO {
  MetaDataEntity toEntity() {
    return MetaDataEntity(
      currentPage: currentPage,
      totalPages: totalPages,
      totalItems: totalItems,
      limit: limit,
    );
  }
}

extension OrderResponseMapper on OrdersResponse {
  PendingOrdersEntity toEntity() {
    return PendingOrdersEntity(
      metadata: metadata?.toEntity(),
      orders: orders?.map((dto) => dto.toEntity()).toList(),
    );
  }
}
