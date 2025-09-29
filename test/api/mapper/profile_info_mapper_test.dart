import 'package:elevate_tracking_app/api/mapper/profile_info_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy/profile_info_dummy.dart';

void main() {
  test("logout mapper", () {
    final dto = ProfileInfoDummy.fakeLogoutResponseDto();
    final entity = dto.toEntity();
    expect(dto.message, equals(entity.message));
  });
}
