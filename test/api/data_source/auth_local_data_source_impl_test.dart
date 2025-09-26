import 'package:elevate_tracking_app/api/data_source/auth_local_data_source_impl.dart';
import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/domain/entites/country_entity.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import '../../fixture/apply_fixture.dart';
import '../../fixture/fake_file_json.dart';

@GenerateMocks([AssetBundle])
void main() {
  group("test get all country", () {
    late AuthLocalDataSourceImpl dataSource;
    late FakeAssetBundle fakeBundle;
    setUp(() {
      fakeBundle = ApplyFixture.fakeBundle;
      dataSource = AuthLocalDataSourceImpl(testBundle: fakeBundle);
    });

    test('returns List<CountryEntity> when fixture is valid', () async {
      final result = await dataSource.getAllCountry();
      expect(result, isA<ApiSuccessResult<List<CountryEntity>>>());
      if (result is ApiSuccessResult<List<CountryEntity>>) {
        final countries = result.data;
        expect(countries, isNotEmpty);
        expect(countries.first.name, equals('Turkey'));
        expect(countries.first.flag, equals('🇹🇷'));
      } else {
        fail('Expected success result');
      }
    });

    test('returns error when asset is missing', () async {
      final emptyBundle = FakeAssetBundle({});
      final ds = AuthLocalDataSourceImpl(testBundle: emptyBundle);

      final result = await ds.getAllCountry();

      expect(result, isA<ApiErrorResult>());
    });
  });
}
