import 'package:flutter_test/flutter_test.dart';
import '../../../dummy/apply_fixture.dart';

void main() {
  group('ApplyRequestDto.toFormData', () {
    test('should convert dto to FormData without files', () async {
      final dto = await ApplyFixture.fakeApiClintRequestDto();

      final formData = await dto.toFormData();
      expect(
        formData.fields,
        anyElement((e) => e.key == "country" && e.value == "Egypt"),
      );
      expect(
        formData.fields,
        anyElement((e) => e.key == "firstName" && e.value == "Ahmed"),
      );
      expect(
        formData.fields,
        anyElement((e) => e.key == "lastName" && e.value == "Ali"),
      );
    });
  });
}
