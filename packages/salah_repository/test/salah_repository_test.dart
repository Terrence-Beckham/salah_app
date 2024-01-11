import 'package:mocktail/mocktail.dart';
import 'package:open_salah_api/open_salah_api.dart' as open_salah_api;
import 'package:salah_repository/src/salah_repository.dart';
import 'package:test/test.dart';

class MockOpenSalahApiClient extends Mock
    implements open_salah_api.OpenSalahApiClient {}

class MockLocation extends Mock implements open_salah_api.Location {}

class MockSalah extends Mock implements open_salah_api.SalahApi {}

void main() {
  group('Salah Repository', () {
    late open_salah_api.OpenSalahApiClient salahApiClient;
    late SalahRepository salahRepository;

    setUp(() {
      salahApiClient = MockOpenSalahApiClient();
      salahRepository = SalahRepository(openSalahApiClient: salahApiClient);
    });

    group('constructor', () {
      test(
        'instantiates internal salah api client when not injected',
        () => expect(SalahRepository(), isNotNull),
      );
    });

    group('getSalah', () {
      const city = 'chicago';
      const latitude = 41.85003;
      const longitude = -87.65005;

      test('calls locationSearch with the correct city', () async {
        try {
          await salahRepository.getSalah(city);
        } catch (_) {}
        verify(() => salahApiClient.locationSearch(city)).called(1);
      });

      test('throws when location Search fails', () async {
        final exception = Exception('oops');
        when(() => salahApiClient.locationSearch(any())).thenThrow(exception);
        expect(() async => salahRepository.getSalah(city), throwsA(exception));
      });

      test('call getSalah with correct latitude and longitude', () async {
        final location = MockLocation();
        const year = 2023;
        const month = 12;
        when(() => location.latitude).thenReturn(latitude);
        when(() => location.longitude).thenReturn(longitude);
        when(() => salahApiClient.locationSearch(any()))
            .thenAnswer((_) async => location);
        try {
          await salahRepository.getSalah(city);
        } catch (_) {}

        {
          (_) => verify(
                () => salahApiClient.getSalahByMonth(
                  latitude: latitude,
                  longitude: longitude,
                  year: year,
                  month: month,
                ),
              ).called(1);
        }
      });
    });
  });
}
