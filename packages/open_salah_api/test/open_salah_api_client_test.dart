// ignore_for_file: prefer_const_constructors
// import 'dart:js_interop_unsafe';

import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:open_salah_api/src/models/models.dart';
import 'package:open_salah_api/src/open_salah_api_client.dart';
import 'package:test/test.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  group('OpenSalahApiClient', () {
    late http.Client httpClient;
    late OpenSalahApiClient apiClient;

    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      httpClient = MockHttpClient();
      // apiClient = OpenSalahApiClient(httpClient: httpClient);
      apiClient = OpenSalahApiClient(httpClient: httpClient);
    });

    group('constructor', () {
      test('does not require an httpClient', () {
        expect(OpenSalahApiClient(), isNotNull);
      });
    });

    group('locationSearch', () {
      const query = 'mock-query';
      test('makes correct http response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await apiClient.locationSearch(query);
        } catch (_) {}
        verify(
          () => httpClient.get(
            Uri.https(
              'geocoding-api.open-meteo.com',
              '/v1/search',
              {'name': query, 'count': '1'},
            ),
          ),
        ).called(1);
      });

      test('throws LocationRequestFailure on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => apiClient.locationSearch(query),
          throwsA(isA<LocationRequestFailure>()),
        );
      });

      test('throws LocationNotFoundFailure on error response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        await expectLater(
          apiClient.locationSearch(query),
          throwsA(isA<LocationNotFoundFailure>()),
        );
      });

      test('throws LocationNotFoundFailure on empty response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{"results": []}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        await expectLater(
          apiClient.locationSearch(query),
          throwsA(isA<LocationNotFoundFailure>()),
        );
      });

      test('returns Location on valid response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(
          '''
{
  "results": [
    {
      "id": 4887398,
      "name": "Chicago",
      "latitude": 41.85003,
      "longitude": -87.65005
    }
  ]
}''',
        );
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await apiClient.locationSearch(query);
        expect(
          actual,
          isA<Location>()
              .having((l) => l.name, 'name', 'Chicago')
              .having((l) => l.id, 'id', 4887398)
              .having((l) => l.latitude, 'latitude', 41.85003)
              .having((l) => l.longitude, 'longitude', -87.65005),
        );
      });
    });

    group('getWeather', () {
      const latitude = 41.85003;
      const longitude = -87.6500;

      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await apiClient.getWeather(latitude: latitude, longitude: longitude);
        } catch (_) {}
        verify(
          () => httpClient.get(
            Uri.https('api.open-meteo.com', 'v1/forecast', {
              'latitude': '$latitude',
              'longitude': '$longitude',
              'current_weather': 'true',
            }),
          ),
        ).called(1);
      });

      test('throws WeatherRequestFailure on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => apiClient.getWeather(
            latitude: latitude,
            longitude: longitude,
          ),
          throwsA(isA<WeatherRequestFailure>()),
        );
      });

      test('throws WeatherNotFoundFailure on empty response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => apiClient.getWeather(
            latitude: latitude,
            longitude: longitude,
          ),
          throwsA(isA<WeatherNotFoundFailure>()),
        );
      });

      test('returns weather on valid response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(
          '''
{
"latitude": 43,
"longitude": -87.875,
"generationtime_ms": 0.2510547637939453,
"utc_offset_seconds": 0,
"timezone": "GMT",
"timezone_abbreviation": "GMT",
"elevation": 189,
"current_weather": {
"temperature": 15.3,
"windspeed": 25.8,
"winddirection": 310,
"weathercode": 63,
"time": "2022-09-12T01:00"
}
}
        ''',
        );
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await apiClient.getWeather(
          latitude: latitude,
          longitude: longitude,
        );
        expect(
          actual,
          isA<Weather>()
              .having((w) => w.temperature, 'temperature', 15.3)
              .having((w) => w.weatherCode, 'weatherCode', 63.0),
        );
      });
    });

    group('getSalah', () {
      const latitude = 41.85003;
      const longitude = -87.6500;

      const year = 1;
      const month = 1;

      test('makes correct http request for a Salah', () async {
        final response = MockResponse();

        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);

        try {
          await apiClient.getSalah(
              latitude: latitude,
              longitude: longitude,
              year: year,
              month: month);
        } catch (_) {}
        verify(
          () => httpClient.get(
            Uri.https('api.aladhan.com', 'v1/calender/' '$year/' '$month',
                {'latitude': '$latitude', 'longitude': '$longitude'}),
          ),
        ).called(1);
      });

      test('Throws SalahRequestFailure on non 200 response ', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);

        expect(
          () => apiClient.getSalah(
              latitude: latitude,
              longitude: longitude,
              year: year,
              month: month),
          throwsA(isA<SalahRequestFailure>()),
        );
      });

      test('Throws SalahNotFoundFailure on empty response', () async {
        final response = MockResponse();

        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);

        expect(
            () async => apiClient.getSalah(
                latitude: latitude,
                longitude: longitude,
                year: year,
                month: month),
            throwsA(isA<SalahNotFoundFailure>()));
      });

//       test('returns  a Salah object on a valid response', () async {
//         final response = MockResponse();
//
//         when(() => response.statusCode).thenReturn(200);
//         when(() => response.body).thenReturn('''
//
//      {
// "timings" :{
// "Fajr": "04:59 (BST)",
// "Sunrise": "06:36 (BST)",
// "Dhuhr": "13:04 (BST)",
// "Asr": "16:36 (BST)",
// "Sunset": "19:34 (BST)",
// "Maghrib": "19:34 (BST)",
// "Isha": "21:10 (BST)",
// "Imsak": "04:49 (BST)",
// "Midnight": "01:05 (BST)",
// "Firstthird": "23:15 (BST)",
// "Lastthird": "02:55 (BST)"
// }}
//
//         ''');
//         when(() => httpClient.get(any())).thenAnswer((_) async => response);
//         final actual = await apiClient.getSalah(
//             latitude: latitude, longitude: longitude, year: year, month: month);
//
//         expect(
//           actual,
//           isA<Salah>().having(
//             (w) => w.timings,
//             'timings',
//             '''
//
//           "timings": {
//       "Fajr": "04:59 (BST)",
//       "Sunrise": "06:36 (BST)",
//       "Dhuhr": "13:04 (BST)",
//       "Asr": "16:36 (BST)",
//       "Sunset": "19:34 (BST)",
//       "Maghrib": "19:34 (BST)",
//       "Isha": "21:10 (BST)",
//       "Imsak": "04:49 (BST)",
//       "Midnight": "01:05 (BST)",
//       "Firstthird": "23:15 (BST)",
//       "Lastthird": "02:55 (BST)"
//        }''',
//           ),
//         );
//       });
    });
  });
}

//Test Push to remote
// ///Exception thrown when salah  search fails
// class SalahRequestFailure implements Exception {}
//
// ///Exception trown when salah  search fails
// class SalahNotFoundFailure implements Exception {}
