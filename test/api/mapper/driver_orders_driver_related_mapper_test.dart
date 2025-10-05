import 'package:elevate_tracking_app/api/mapper/driver_orders_driver_related_mapper.dart';
import 'package:elevate_tracking_app/api/models/responses/driver_orders_response_dto/driver_order_dto_driver_related.dart';
import 'package:elevate_tracking_app/api/models/responses/driver_orders_response_dto/order_dto_driver_related.dart';
import 'package:elevate_tracking_app/api/models/responses/driver_orders_response_dto/order_item_dto_driver_related.dart';
import 'package:elevate_tracking_app/api/models/responses/driver_orders_response_dto/product_dto_driver_related.dart';
import 'package:elevate_tracking_app/api/models/responses/driver_orders_response_dto/shipping_address_dto_driver_related.dart';
import 'package:elevate_tracking_app/api/models/responses/driver_orders_response_dto/store_dto_driver_related.dart';
import 'package:elevate_tracking_app/api/models/responses/driver_orders_response_dto/user_dto_driver_related.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy/driver_orders_driver_related_dummy.dart';

void main() {
  group('test DriverOrderDtoDriverRelatedMapper', () {
    test("test DriverOrderDtoDriverRelatedMapper", () {
      //Arrange
      final DriverOrderDtoDriverRelated driverOrderDtoDriverRelated =
          DriverOrdersDriverRelatedDummy.dummyDriverOrderDtoDriverRelated;

      //Act
      final result = driverOrderDtoDriverRelated.toEntity();

      //Assert
      expect(result.id, driverOrderDtoDriverRelated.id);
      expect(result.driver, driverOrderDtoDriverRelated.driver);
      expect(result.order?.id, driverOrderDtoDriverRelated.order?.id);
      expect(result.store?.name, driverOrderDtoDriverRelated.store?.name);
      expect(result.v, driverOrderDtoDriverRelated.v);
      expect(result.createdAt, driverOrderDtoDriverRelated.createdAt);
      expect(result.updatedAt, driverOrderDtoDriverRelated.updatedAt);
    });

    test("test OrderDtoDriverRelatedMapper", () {
      //Arrange
      final OrderDtoDriverRelated orderDtoDriverRelated =
          DriverOrdersDriverRelatedDummy.dummyOrderDtoDriverRelated;

      //Act
      final result = orderDtoDriverRelated.toEntity();

      //Assert
      expect(result.id, orderDtoDriverRelated.id);
      expect(result.user?.id, orderDtoDriverRelated.user?.id);
      expect(
        result.orderItems?.length,
        orderDtoDriverRelated.orderItems?.length,
      );
      expect(result.totalPrice, orderDtoDriverRelated.totalPrice);
      expect(result.paymentType, orderDtoDriverRelated.paymentType);
      expect(result.isPaid, orderDtoDriverRelated.isPaid);
      expect(result.isDelivered, orderDtoDriverRelated.isDelivered);
      expect(result.state, orderDtoDriverRelated.state);
      expect(result.createdAt, orderDtoDriverRelated.createdAt);
      expect(result.updatedAt, orderDtoDriverRelated.updatedAt);
      expect(result.orderNumber, orderDtoDriverRelated.orderNumber);
      expect(result.v, orderDtoDriverRelated.v);
      expect(result.paidAt, orderDtoDriverRelated.paidAt);
      expect(
        result.shippingAddress?.street,
        orderDtoDriverRelated.shippingAddress?.street,
      );
    });

    test("test OrderItemDtoDriverRelatedMapper", () {
      //Arrange
      final OrderItemDtoDriverRelated orderItemDtoDriverRelated =
          DriverOrdersDriverRelatedDummy.dummyOrderItemDtoDriverRelated1;

      //Act
      final result = orderItemDtoDriverRelated.toEntity();

      //Assert
      expect(result.id, orderItemDtoDriverRelated.id);
      expect(result.product?.id, orderItemDtoDriverRelated.product?.id);
      expect(result.price, orderItemDtoDriverRelated.price);
      expect(result.quantity, orderItemDtoDriverRelated.quantity);
    });

    test("test ProductDtoDriverRelatedMapper", () {
      //Arrange
      final ProductDtoDriverRelated productDtoDriverRelated =
          DriverOrdersDriverRelatedDummy.dummyProductDtoDriverRelated;

      //Act
      final result = productDtoDriverRelated.toEntity();

      //Assert
      expect(result.id, productDtoDriverRelated.id);
      expect(result.price, productDtoDriverRelated.price);
    });

    test("test ShippingAddressDtoDriverRelatedMapper", () {
      //Arrange
      final ShippingAddressDtoDriverRelated shippingAddressDtoDriverRelated =
          DriverOrdersDriverRelatedDummy.dummyShippingAddressDtoDriverRelated;

      //Act
      final result = shippingAddressDtoDriverRelated.toEntity();

      //Assert
      expect(result.street, shippingAddressDtoDriverRelated.street);
      expect(result.city, shippingAddressDtoDriverRelated.city);
      expect(result.phone, shippingAddressDtoDriverRelated.phone);
      expect(result.lat, shippingAddressDtoDriverRelated.lat);
      expect(result.long, shippingAddressDtoDriverRelated.long);
    });

    test("test UserDtoDriverRelatedMapper", () {
      //Arrange
      final UserDtoDriverRelated userDtoDriverRelated =
          DriverOrdersDriverRelatedDummy.dummyUserDtoDriverRelated;

      //Act
      final result = userDtoDriverRelated.toEntity();

      //Assert
      expect(result.id, userDtoDriverRelated.id);
      expect(result.firstName, userDtoDriverRelated.firstName);
      expect(result.lastName, userDtoDriverRelated.lastName);
      expect(result.email, userDtoDriverRelated.email);
      expect(result.gender, userDtoDriverRelated.gender);
      expect(result.phone, userDtoDriverRelated.phone);
      expect(result.photo, userDtoDriverRelated.photo);
      expect(result.passwordChangedAt, userDtoDriverRelated.passwordChangedAt);
      expect(result.passwordResetCode, userDtoDriverRelated.passwordResetCode);
      expect(
        result.passwordResetExpires,
        userDtoDriverRelated.passwordResetExpires,
      );
      expect(result.resetCodeVerified, userDtoDriverRelated.resetCodeVerified);
    });

    test("test StoreDtoDriverRelatedMapper", (){
      //Arrange
      final StoreDtoDriverRelated storeDtoDriverRelated =
          DriverOrdersDriverRelatedDummy.dummyStoreDtoDriverRelated;

      //Act
      final result = storeDtoDriverRelated.toEntity();

      //Assert
      expect(result.name, storeDtoDriverRelated.name);
      expect(result.image, storeDtoDriverRelated.image);
      expect(result.address, storeDtoDriverRelated.address);
      expect(result.phoneNumber, storeDtoDriverRelated.phoneNumber);
      expect(result.latLong, storeDtoDriverRelated.latLong);
    });
  });
}
