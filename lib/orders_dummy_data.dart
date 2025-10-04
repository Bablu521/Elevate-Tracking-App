import 'package:elevate_tracking_app/api/models/driver_order_dto.dart';
import 'package:elevate_tracking_app/api/models/meta_data_dto.dart';
import 'package:elevate_tracking_app/api/models/order_dto.dart';
import 'package:elevate_tracking_app/api/models/order_item_dto.dart';
import 'package:elevate_tracking_app/api/models/product_dto.dart';
import 'package:elevate_tracking_app/api/models/responses/orders/orders_response.dart';
import 'package:elevate_tracking_app/api/models/shipping_address_dto.dart';
import 'package:elevate_tracking_app/api/models/store_dto.dart';
import 'package:elevate_tracking_app/api/models/user_dto.dart';

class OrdersDummyData {
  // Dummy User Data
  final userDTO1 = UserDTO(
    id: 'user_123',
    firstName: 'John',
    lastName: 'Doe',
    email: 'john.doe@example.com',
    gender: 'Male',
    phone: '123-456-7890',
    photo: 'https://example.com/profile_pic.jpg',
    passwordChangedAt: DateTime.now().toIso8601String(),
  );

  // Dummy Store Data
  final storeDTO1 = StoreDTO(
    name: 'Central Perk Cafe',
    image: 'https://example.com/store_image.jpg',
    address: '123 Main Street, New York, NY',
    phoneNumber: '987-654-3210',
    latLong: '40.7128,-74.0060',
  );

  // Dummy Product Data
  final productDTO1 = ProductDTO(
    id: 'prod_abc',
    title: 'Classic Glazed Donut',
    slug: 'classic-glazed-donut',
    description:
        'A timeless classic, our glazed donut is light, fluffy, and delicious.',
    imgCover: 'https://example.com/donut_cover.jpg',
    images: [
      'https://example.com/donut_1.jpg',
      'https://example.com/donut_2.jpg',
    ],
    price: 10,
    priceAfterDiscount: 9,
    quantity: 100,
    category: 'cat_donuts',
    occasion: 'occ_anytime',
    createdAt: DateTime.now().toIso8601String(),
    updatedAt: DateTime.now().toIso8601String(),
    v: 1,
    isSuperAdmin: false,
    sold: 50,
    rateAvg: 4,
    rateCount: 25,
  );

  final productDTO2 = ProductDTO(
    id: 'prod_def',
    title: 'Chocolate Filled Croissant',
    slug: 'chocolate-filled-croissant',
    description: 'A buttery croissant filled with rich chocolate.',
    imgCover: 'https://example.com/croissant_cover.jpg',
    images: ['https://example.com/croissant_1.jpg'],
    price: 25,
    quantity: 50,
    category: 'cat_pastries',
    occasion: 'occ_breakfast',
    createdAt: DateTime.now().toIso8601String(),
    updatedAt: DateTime.now().toIso8601String(),
    v: 1,
    isSuperAdmin: false,
    sold: 30,
    rateAvg: 5,
    rateCount: 20,
  );

  // Dummy Order Item Data
  late final orderItemDTO1 = OrderItemDTO(
    product: productDTO1,
    price: 25,
    quantity: 2,
    id: 'item_xyz',
  );

  late final orderItemDTO2 = OrderItemDTO(
    product: productDTO2,
    price: 27,
    quantity: 1,
    id: 'item_uvw',
  );

  // Dummy Shipping Address Data
  final shippingAddressDTO1 = ShippingAddressDTO(
    street: '456 Oak Avenue',
    city: 'Metropolis',
    phone: '555-555-5555',
    lat: '34.0522',
    long: '-118.2437',
  );

  // Dummy Order Data
  late final orderDTO1 = OrderDTO(
    id: 'order_789',
    user: userDTO1,
    orderItems: [orderItemDTO1, orderItemDTO2],
    totalPrice: 55,
    shippingAddress: shippingAddressDTO1,
    paymentType: 'Credit Card',
    isPaid: true,
    isDelivered: false,
    state: 'Preparing',
    createdAt: DateTime.now()
        .subtract(const Duration(hours: 1))
        .toIso8601String(),
    updatedAt: DateTime.now().toIso8601String(),
    orderNumber: "1001",
    v: 1,
    store: storeDTO1,
  );

  late final orderDTO2 = OrderDTO(
    id: 'order_790',
    user: userDTO1,
    orderItems: [orderItemDTO1],
    totalPrice: 66,
    shippingAddress: shippingAddressDTO1,
    paymentType: 'Cash',
    isPaid: false,
    isDelivered: false,
    state: 'Pending',
    createdAt: DateTime.now()
        .subtract(const Duration(minutes: 30))
        .toIso8601String(),
    updatedAt: DateTime.now().toIso8601String(),
    orderNumber: "1002",
    v: 1,
    store: storeDTO1,
  );

  // Dummy Driver Order Data
  late final driverOrderDTO1 = DriverOrderDTO(
    id: 'driver_order_001',
    driver: 'driver_id_567',
    order: orderDTO1,
    v: 1,
    createdAt: DateTime.now().toIso8601String(),
    updatedAt: DateTime.now().toIso8601String(),
    store: storeDTO1,
  );

  // Dummy MetaData
  final metaDataDTO = MetaDataDTO(
    currentPage: 1,
    totalPages: 10,
    totalItems: 2,
    limit: 10,
  );

  // Dummy OrdersResponse (for pending orders)
  late final pendingOrdersResponse = OrdersResponse(
    metadata: metaDataDTO,
    orders: [orderDTO1, orderDTO2],
  );
}
