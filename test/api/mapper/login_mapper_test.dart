import 'package:elevate_tracking_app/api/mapper/login_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy/login_dummy_data.dart';

void main() {
  group("test LoginRequestMapper", () {
    test(
      "when call toRequest should return LoginRequest",
      () {
        final loginRequestEntity = LoginDummyData().fakeLoginRequestEntity;
        final result = loginRequestEntity.toRequest();
        expect(result.email, loginRequestEntity.email);
        expect(result.password, loginRequestEntity.password);
      },
    );
  });

  group("test LoginResponseMapper", () {
    test(
      "when call toEntity should return LoginRequest",
          () {
        final loginResponse = LoginDummyData().fakeLoginResponse;
        final result = loginResponse.toEntity();
        expect(result.message, loginResponse.message);
        expect(result.token, loginResponse.token);
      },
    );
  });
}
