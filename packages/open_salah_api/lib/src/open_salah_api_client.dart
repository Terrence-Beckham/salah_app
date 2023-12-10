import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:open_salah_api/src/open_salah_api.dart';

///Exception thrown when locationSearch fails
class LocationRequestFailure implements Exception {}

///Exception thrown when the provided location fails
class LocationNotFoundFailure implements Exception {}

///Exception thrown when getWeather fails
class WeatherRequestFailure implements Exception {}

///Exception thrown when weather for provided location is not found
class WeatherNotFoundFailure implements Exception {}

///Exception trown when salah  search fails
class SalahRequestFailure implements Exception {}

///Exception trown when salah  search fails
class SalahNotFoundFailure implements Exception {}

///Dart client for Sala Times
class OpenSalahApiClient {
  OpenSalahApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  static const _baseUrlWeather = 'api.open-meteo.com';
  static const _baseUrlGeocoding = 'geocoding-api.open-meteo.com';
  static const _basePrayerTimes = 'api.aladhan.com';

  final http.Client _httpClient;

  /// Finds a [Location] `/v1/search/?name=(query)`.
  // Future<Location> locationSearch(String query) async {
  //   final locationRequest = Uri.https(
  //     _baseUrlGeocoding,
  //     '/v1/search',
  //     {'name': query, 'count': '1'},
  //   );

  //   final locationResponse = await _httpClient.get(locationRequest);

  //   if (locationResponse.statusCode != 200) {
  //     throw LocationRequestFailure();
  //   }

  //   final locationJson = jsonDecode(locationResponse.body) as Map;

  //   if (!locationJson.containsKey('results')) throw LocationNotFoundFailure();

  //   final results = locationJson['results'] as List;

  //   if (results.isEmpty) throw LocationNotFoundFailure();

  //   return Location.fromJson(results.first as Map<String, dynamic>);
  // }

  /// Finds a location
  Future<Location> locationSearch(String query) async {
    final locationRequest = Uri.https(
      _baseUrlGeocoding,
      '/v1/search',
      {'name': query, 'count': '1'},
    );
    final locationResponse = await _httpClient.get(locationRequest);

    if (locationResponse.statusCode != 200) {
      throw LocationRequestFailure();
    }

    final locationJson = jsonDecode(locationResponse.body) as Map;

    if (!locationJson.containsKey('results')) {
      throw LocationNotFoundFailure();
    }
    final results = locationJson['results'] as List;

    if (results.isEmpty) throw LocationNotFoundFailure();

    return Location.fromJson(results.first as Map<String, dynamic>);
  }

  ///Fetches Weather for a given [latitude] and [longitude].
  Future<Weather> getWeather({
    required double latitude,
    required double longitude,
  }) async {
    final weatherRequest = Uri.https(_baseUrlWeather, '/v1/forcast', {
      'latitude': '$latitude',
      'longitude': '$longitude',
      'current_weather': 'true'
    });
    final weatherResponse = await _httpClient.get(weatherRequest);

    if (weatherResponse.statusCode != 200) throw WeatherRequestFailure();

    final bodyJson = jsonDecode(weatherResponse.body) as Map<String, dynamic>;

    if (!bodyJson.containsKey('current_weather'))
      throw WeatherNotFoundFailure();

    final weatherJson = bodyJson['current_weather'] as Map<String, dynamic>;
    return Weather.fromJson(weatherJson);
  }

  ///Fetches Salah times for a specific [year], [month], [latitude], and [longitude]
  ///http://api.aladhan.com/v1/calendar/2017/4?latitude=51.508515&longitude=-0.1254872&method=2
  Future<Salah> getSalah(
      {required double latitude,
      required double longitide,
      required int year,
      required int month}) async {
    final salahRequest = Uri.https(
        _basePrayerTimes,
        '/v1/calender/' '$year/' '$month',
        {'latitude': '$latitude', 'longitude': '$longitide'});

    final salahResponse = await _httpClient.get(salahRequest);

    if (salahResponse.statusCode != 200) throw SalahRequestFailure();

    final salahJson = jsonDecode(salahResponse.body) as Map<String, dynamic>;

    if (!salahJson.containsKey('data')) throw SalahNotFoundFailure();

    ///TODO I need to save this list as Salah objects into the DB.
    final results = salahJson['data'] as List;

    if (results.isEmpty) throw SalahNotFoundFailure();

    ///TODO This will only get the first Salah for the date.
    ///I need to save this entire list to the database in the future
    return Salah.fromJson(results.first as Map<String, dynamic>);
  }
}
