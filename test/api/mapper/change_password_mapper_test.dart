import 'package:elevate_tracking_app/api/mapper/change_password_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy/change_password_dummy_data.dart';

void main (){
  group("test changePassword mapper",(){
    test("when we call to response it should return changePassword entity ",(){

      final changePasswordResponse = ChangePasswordDummyData().fakeChangePasswordResponse;
      final result = changePasswordResponse.toEntity();

      expect(result.message, changePasswordResponse.message);
      expect(result.token, changePasswordResponse.token);

    });
    test("when we call to request it should return changePassword entity ",(){

      final changePasswordResponse = ChangePasswordDummyData().fakeChangePasswordRequestEntity;
      final result = changePasswordResponse.fromDomain();

      expect(result.password, changePasswordResponse.password);
      expect(result.newPassword, changePasswordResponse.newPassword);

    });
  });
}