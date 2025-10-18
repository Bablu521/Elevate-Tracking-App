import 'package:elevate_tracking_app/api/models/responses/driver_orders_response_dto/driver_order_dto_driver_related.dart';
import 'package:elevate_tracking_app/api/models/responses/driver_orders_response_dto/driver_orders_response_dto_driver_related.dart';
import 'package:elevate_tracking_app/api/models/responses/driver_orders_response_dto/metadata_dto_driver_related.dart';
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

class DriverOrdersDriverRelatedDummy {

  static final ProductEntityDriverRelated dummyProductEntityDriverRelated =
      const ProductEntityDriverRelated(
    id: "prod_001",
    price: 120.50,
  );

  static final ProductDtoDriverRelated dummyProductDtoDriverRelated =
      const ProductDtoDriverRelated(
    id: "prod_001",
    price: 120.50,
  );


  static final StoreEntityDriverRelated dummyStoreEntityDriverRelated =
      const StoreEntityDriverRelated(
    name: "Fresh Mart",
    image: "https://fakeurl.com/store_image.png",
    address: "123 Nile Street, Cairo, Egypt",
    phoneNumber: "+201011223344",
    latLong: "30.0444,31.2357",
  );

  static final StoreDtoDriverRelated dummyStoreDtoDriverRelated =
      const StoreDtoDriverRelated(
    name: "Fresh Mart",
    image: "https://fakeurl.com/store_image.png",
    address: "123 Nile Street, Cairo, Egypt",
    phoneNumber: "+201011223344",
    latLong: "30.0444,31.2357",
  );


  static final UserEntityDriverRelated dummyUserEntityDriverRelated =
      const UserEntityDriverRelated(
    id: "user_101",
    firstName: "Omar",
    lastName: "Saleh",
    email: "omar.saleh@example.com",
    gender: "Male",
    phone: "+201223344556",
    photo: "https://fakeurl.com/user_photo.png",
    passwordChangedAt: "2025-01-05T12:00:00Z",
    passwordResetCode: "ABCD1234",
    passwordResetExpires: "2025-01-06T12:00:00Z",
    resetCodeVerified: true,
  );

  static final UserDtoDriverRelated dummyUserDtoDriverRelated =
      const UserDtoDriverRelated(
    id: "user_101",
    firstName: "Omar",
    lastName: "Saleh",
    email: "omar.saleh@example.com",
    gender: "Male",
    phone: "+201223344556",
    photo: "https://fakeurl.com/user_photo.png",
    passwordChangedAt: "2025-01-05T12:00:00Z",
    passwordResetCode: "ABCD1234",
    passwordResetExpires: "2025-01-06T12:00:00Z",
    resetCodeVerified: true,
  );

  static final ShippingAddressEntityDriverRelated
      dummyShippingAddressEntityDriverRelated =
      const ShippingAddressEntityDriverRelated(
    street: "10 El-Tahrir St",
    city: "Giza",
    phone: "+201112223344",
    lat: "30.0123",
    long: "31.2010",
  );

  static final ShippingAddressDtoDriverRelated
      dummyShippingAddressDtoDriverRelated =
      const ShippingAddressDtoDriverRelated(
    street: "10 El-Tahrir St",
    city: "Giza",
    phone: "+201112223344",
    lat: "30.0123",
    long: "31.2010",
  );


  static final OrderItemEntityDriverRelated dummyOrderItemEntityDriverRelated1 =
      OrderItemEntityDriverRelated(
    id: "item_001",
    product: dummyProductEntityDriverRelated,
    price: 120.50,
    quantity: 2,
  );

  static final OrderItemEntityDriverRelated dummyOrderItemEntityDriverRelated2 =
      OrderItemEntityDriverRelated(
    id: "item_002",
    product: dummyProductEntityDriverRelated,
    price: 85.75,
    quantity: 1,
  );

  static final OrderItemDtoDriverRelated dummyOrderItemDtoDriverRelated1 =
      OrderItemDtoDriverRelated(
    id: "item_001",
    product: dummyProductDtoDriverRelated,
    price: 120.50,
    quantity: 2,
  );

  static final OrderItemDtoDriverRelated dummyOrderItemDtoDriverRelated2 =
      OrderItemDtoDriverRelated(
    id: "item_002",
    product: dummyProductDtoDriverRelated,
    price: 85.75,
    quantity: 1,
  );


  static final OrderEntityDriverRelated dummyOrderEntityDriverRelated =
      OrderEntityDriverRelated(
    id: "order_789",
    user: dummyUserEntityDriverRelated,
    orderItems: [
      dummyOrderItemEntityDriverRelated1,
      dummyOrderItemEntityDriverRelated2,
    ],
    totalPrice: 326.75,
    paymentType: "Cash",
    isPaid: false,
    isDelivered: false,
    state: "Pending",
    createdAt: "2025-01-05T10:00:00Z",
    updatedAt: "2025-01-05T10:30:00Z",
    orderNumber: "ORD123456",
    v: 1,
    paidAt: null,
    shippingAddress: dummyShippingAddressEntityDriverRelated,
  );

  static final OrderDtoDriverRelated dummyOrderDtoDriverRelated =
      OrderDtoDriverRelated(
    id: "order_789",
    user: dummyUserDtoDriverRelated,
    orderItems: [
      dummyOrderItemDtoDriverRelated1,
      dummyOrderItemDtoDriverRelated2,
    ],
    totalPrice: 326.75,
    paymentType: "Cash",
    isPaid: false,
    isDelivered: false,
    state: "Pending",
    createdAt: "2025-01-05T10:00:00Z",
    updatedAt: "2025-01-05T10:30:00Z",
    orderNumber: "ORD123456",
    v: 1,
    paidAt: null,
    shippingAddress: dummyShippingAddressDtoDriverRelated,
  );


  static final DriverOrderEntityDriverRelated dummyDriverOrderEntityDriverRelated =
      DriverOrderEntityDriverRelated(
    id: "drv_order_001",
    driver: "driver_123",
    order: dummyOrderEntityDriverRelated,
    store: dummyStoreEntityDriverRelated,
    v: 1,
    createdAt: "2025-01-05T09:00:00Z",
    updatedAt: "2025-01-05T09:45:00Z",
  );

  static final DriverOrderDtoDriverRelated dummyDriverOrderDtoDriverRelated =
      DriverOrderDtoDriverRelated(
    id: "drv_order_001",
    driver: "driver_123",
    order: dummyOrderDtoDriverRelated,
    store: dummyStoreDtoDriverRelated,
    v: 1,
    createdAt: "2025-01-05T09:00:00Z",
    updatedAt: "2025-01-05T09:45:00Z",
  );


  static final MetadataDtoDriverRelated dummyMetadataDtoDriverRelated =
      const MetadataDtoDriverRelated(
    currentPage: 1,
    totalPages: 3,
    totalItems: 9,
    limit: 10,
  );


  static final DriverOrdersResponseDtoDriverRelated
      dummyDriverOrdersResponseDtoDriverRelated =
      DriverOrdersResponseDtoDriverRelated(
    message: "Driver orders fetched successfully",
    metadata: dummyMetadataDtoDriverRelated,
    orders: [
      dummyDriverOrderDtoDriverRelated,
    ],
  );
}