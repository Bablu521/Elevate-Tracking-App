import 'package:elevate_tracking_app/api/mapper/orders_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy/orders_dummy_data.dart';

void main() {
  final dummyData = OrdersDummyData();

  group("DriverOrderMapper", () {
    test(
      "when toEntity is called, it should return a valid DriverOrderEntity",
      () {
        // Arrange
        final driverOrderDTO = dummyData.driverOrderDTO1;

        // Act
        final result = driverOrderDTO.toEntity();

        // Assert
        expect(result.id, driverOrderDTO.id);
        expect(result.driver, driverOrderDTO.driver);
        expect(result.order?.id, driverOrderDTO.order?.id);
        expect(result.v, driverOrderDTO.v);
        expect(result.createdAt, driverOrderDTO.createdAt);
        expect(result.updatedAt, driverOrderDTO.updatedAt);
        expect(result.store?.name, driverOrderDTO.store?.name);
      },
    );
  });

  group("OrderMapper", () {
    test("when toEntity is called, it should return a valid OrderEntity", () {
      // Arrange
      final orderDTO = dummyData.orderDTO1;

      // Act
      final result = orderDTO.toEntity();

      // Assert
      expect(result.id, orderDTO.id);
      expect(result.user?.id, orderDTO.user?.id);
      expect(result.orderItems?.length, orderDTO.orderItems?.length);
      expect(result.totalPrice, orderDTO.totalPrice);
      expect(result.shippingAddress?.street, orderDTO.shippingAddress?.street);
      expect(result.paymentType, orderDTO.paymentType);
      expect(result.isPaid, orderDTO.isPaid);
      expect(result.isDelivered, orderDTO.isDelivered);
      expect(result.state, orderDTO.state);
      expect(result.createdAt, orderDTO.createdAt);
      expect(result.updatedAt, orderDTO.updatedAt);
      expect(result.orderNumber, orderDTO.orderNumber);
      expect(result.v, orderDTO.v);
      expect(result.store?.name, orderDTO.store?.name);
    });
  });

  group("OrderItemMapper", () {
    test(
      "when toEntity is called, it should return a valid OrderItemEntity",
      () {
        // Arrange
        final orderItemDTO = dummyData.orderItemDTO1;

        // Act
        final result = orderItemDTO.toEntity();

        // Assert
        expect(result.product?.id, orderItemDTO.product?.id);
        expect(result.price, orderItemDTO.price);
        expect(result.quantity, orderItemDTO.quantity);
        expect(result.id, orderItemDTO.id);
      },
    );
  });

  group("ProductMapper", () {
    test("when toEntity is called, it should return a valid ProductEntity", () {
      // Arrange
      final productDTO = dummyData.productDTO1;

      // Act
      final result = productDTO.toEntity();

      // Assert
      expect(result.id, productDTO.id);
      expect(result.title, productDTO.title);
      expect(result.slug, productDTO.slug);
      expect(result.description, productDTO.description);
      expect(result.imgCover, productDTO.imgCover);
      expect(result.images, productDTO.images);
      expect(result.price, productDTO.price);
      expect(result.priceAfterDiscount, productDTO.priceAfterDiscount);
      expect(result.quantity, productDTO.quantity);
      expect(result.category, productDTO.category);
      expect(result.occasion, productDTO.occasion);
      expect(result.createdAt, productDTO.createdAt);
      expect(result.updatedAt, productDTO.updatedAt);
      expect(result.v, productDTO.v);
      expect(result.isSuperAdmin, productDTO.isSuperAdmin);
      expect(result.sold, productDTO.sold);
      expect(result.rateAvg, productDTO.rateAvg);
      expect(result.rateCount, productDTO.rateCount);
    });
  });

  group("StoreMapper", () {
    test("when toEntity is called, it should return a valid StoreEntity", () {
      // Arrange
      final storeDTO = dummyData.storeDTO1;

      // Act
      final result = storeDTO.toEntity();

      // Assert
      expect(result.name, storeDTO.name);
      expect(result.image, storeDTO.image);
      expect(result.address, storeDTO.address);
      expect(result.phoneNumber, storeDTO.phoneNumber);
      expect(result.latLong, storeDTO.latLong);
    });
  });

  group("UserMapper", () {
    test("when toEntity is called, it should return a valid UserEntity", () {
      // Arrange
      final userDTO = dummyData.userDTO1;

      // Act
      final result = userDTO.toEntity();

      // Assert
      expect(result.id, userDTO.id);
      expect(result.firstName, userDTO.firstName);
      expect(result.lastName, userDTO.lastName);
      expect(result.email, userDTO.email);
      expect(result.gender, userDTO.gender);
      expect(result.phone, userDTO.phone);
      expect(result.photo, userDTO.photo);
      expect(result.passwordChangedAt, userDTO.passwordChangedAt);
    });
  });

  group("StartOrderMapper", () {
    test(
      "when toEntity is called, it should return a valid StartOrderEntity",
      () {
        // Arrange
        final startOrderDto = dummyData.startOrderDto;

        // Act
        final result = startOrderDto.toEntity();

        // Assert
        expect(result.id, startOrderDto.id);
        expect(result.user, startOrderDto.user);
        expect(
          result.orderItems?.first.product,
          startOrderDto.orderItems?.first.product,
        );
        expect(result.totalPrice, startOrderDto.totalPrice);
        expect(result.paymentType, startOrderDto.paymentType);
        expect(result.isPaid, startOrderDto.isPaid);
        expect(result.isDelivered, startOrderDto.isDelivered);
        expect(result.state, startOrderDto.state);
        expect(result.createdAt, startOrderDto.createdAt);
        expect(result.updatedAt, startOrderDto.updatedAt);
        expect(result.orderNumber, startOrderDto.orderNumber);
        expect(result.v, startOrderDto.v);
      },
    );
  });

  group("StartOrderItemsMapper", () {
    test(
      "when toEntity is called, it should return a valid StartOrderItemsEntity",
      () {
        // Arrange
        final startOrderItemsDto = dummyData.startOrderItemsDto1;

        // Act
        final result = startOrderItemsDto.toEntity();

        // Assert
        expect(result.product, startOrderItemsDto.product);
        expect(result.price, startOrderItemsDto.price);
        expect(result.quantity, startOrderItemsDto.quantity);
        expect(result.id, startOrderItemsDto.id);
      },
    );
  });

  group("ShippingAddressMapper", () {
    test(
      "when toEntity is called, it should return a valid ShippingAddressEntity",
      () {
        // Arrange
        final shippingAddressDTO = dummyData.shippingAddressDTO1;

        // Act
        final result = shippingAddressDTO.toEntity();

        // Assert
        expect(result.street, shippingAddressDTO.street);
        expect(result.city, shippingAddressDTO.city);
        expect(result.phone, shippingAddressDTO.phone);
        expect(result.lat, shippingAddressDTO.lat);
        expect(result.long, shippingAddressDTO.long);
      },
    );
  });

  group("MetaDataMapper", () {
    test(
      "when toEntity is called, it should return a valid MetaDataEntity",
      () {
        // Arrange
        final metaDataDTO = dummyData.metaDataDTO;

        // Act
        final result = metaDataDTO.toEntity();

        // Assert
        expect(result.currentPage, metaDataDTO.currentPage);
        expect(result.totalPages, metaDataDTO.totalPages);
        expect(result.totalItems, metaDataDTO.totalItems);
        expect(result.limit, metaDataDTO.limit);
      },
    );
  });

  group("OrderResponseMapper", () {
    test(
      "when toEntity is called, it should return a valid PendingOrdersEntity",
      () {
        // Arrange
        final ordersResponse = dummyData.ordersResponse;

        // Act
        final result = ordersResponse.toEntity();

        // Assert
        expect(
          result.metadata?.totalItems,
          ordersResponse.metadata?.totalItems,
        );
        expect(result.orders?.length, ordersResponse.orders?.length);
        expect(result.orders?.first.id, ordersResponse.orders?.first.id);
      },
    );
  });
}
