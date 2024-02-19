import 'dart:async';
import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:open_salah_api/env.dart';
import 'package:open_salah_api/open_salah_api.dart';
import 'package:open_salah_api/src/models/reverse_geolocation.dart';

///Exception thrown when locationSearch fails
class LocationRequestFailure implements Exception {}

///Exception thrown when the provided location fails
class LocationNotFoundFailure implements Exception {}

///Exception thrown when getWeather fails
class WeatherRequestFailure implements Exception {}

///Exception thrown when weather for provided location is not found
class WeatherNotFoundFailure implements Exception {}

///Exception thrown when salah  search fails
class SalahRequestFailure implements Exception {}

///Exception thrown when salah  search fails
class SalahNotFoundFailure implements Exception {}

///Dart client for Salah Times
class OpenSalahApiClient {
  OpenSalahApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  static const _baseUrlWeather = 'api.open-meteo.com';
  static const _baseUrlGeocoding = 'geocoding-api.open-meteo.com';
  static const _basePrayerTimes = 'api.aladhan.com';
  static const _baseReverseGeoCode = 'geocode.maps.co';
  final apiKey = Env.reverseGeocodingKey;

  final http.Client _httpClient;
  final _logger = Logger();

  Future<String> reverseGeo(double latitude, double longitude) async {
    final reverseLocation = Uri.https(_baseReverseGeoCode, 'reverse', {
      'lat': latitude.toString(),
      'lon': longitude.toString(),
      'key': apiKey
    });
    final response = await _httpClient.get(reverseLocation);
    _logger.i('This is the response: ${response.statusCode}');
    if (response.statusCode != 200) {
      throw LocationRequestFailure();
    }
    final locationJson = jsonDecode(response.body) as Map<String, dynamic>;
    _logger.i('This is the decoded locationJson: $locationJson');

    if (!locationJson.containsKey('address')) {
      throw LocationNotFoundFailure();
    }
    final city = locationJson['address']['city'] as String;
    _logger.i(' This is the city: $city');
    // return city.toString();
    // return ReverseGeolocation.fromJson(locationJson);
    return city;
  }

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
    _logger.i(
        'This is the current Location${Location.fromJson(results.first as Map<String, dynamic>)}');
    return Location.fromJson(results.first as Map<String, dynamic>);
  }

  ///Fetches Weather for a given [latitud
  ///e] and [longitude].
  Future<Weather> getWeather({
    required double latitude,
    required double longitude,
  }) async {
    final weatherRequest = Uri.https(_baseUrlWeather, '/v1/forecast', {
      'latitude': '$latitude',
      'longitude': '$longitude',
      'current_weather': 'true'
    });
    final weatherResponse = await _httpClient.get(weatherRequest);

    if (weatherResponse.statusCode != 200) throw WeatherRequestFailure();

    final bodyJson = jsonDecode(weatherResponse.body) as Map<String, dynamic>;

    if (!bodyJson.containsKey('current_weather')) {
      throw WeatherNotFoundFailure();
    }

    final weatherJson = bodyJson['current_weather'] as Map<String, dynamic>;
    return Weather.fromJson(weatherJson);
  }

  ///Fetches Salah times for a specific [year], [month], [latitude], and [longitude]
  ///http://api.aladhan.com/v1/calendar/2017/4?latitude=51.508515&longitude=-0.1254872&method=2
  ///This needs to return an entire list
  Future<Salah> getSalahByMonth() async {
    final Position position = await _determinePosition();
    _logger.e('This is the current position:$position');
    final city = await reverseGeo(position.latitude, position.longitude);
    final today = DateTime.now();
    final year = today.year;
    final month = today.month;
    final latitude = position.latitude;
    final longitude = position.longitude;
    final salahRequest = Uri.https(
        _basePrayerTimes,
        '/v1/calendar/' '$year/' '$month',
        {'latitude': '$latitude', 'longitude': '$longitude'});
    _logger.e(salahRequest);

    final salahResponse = await _httpClient.get(salahRequest);
    _logger.i(salahResponse.statusCode);

    if (salahResponse.statusCode != 200) throw SalahRequestFailure();

    final salahJson = jsonDecode(salahResponse.body) as Map<String, dynamic>;

    if (!salahJson.containsKey('data')) throw SalahNotFoundFailure();

    ///TODO I need to save this list as Salah objects into the DB.
    final results = salahJson['data'] as List;

    if (results.isEmpty) throw SalahNotFoundFailure();

    ///TODO This will only get the first Salah for the date.
    ///I need to save this entire list to the database in the future
    final salahs = List<Map<String, dynamic>>.from(results);
    // _logger.i(salahs.forEach((element)=> {}));
    // for (var element in salahs) {_logger.i(element);}
    // return Salah.fromJson(results.first as Map<String, dynamic>);
    return Salah.fromJson(results.last as Map<String, dynamic>, city);
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
// ///Get A Salah for a Specific Day
// ///http://api.aladhan.com/v1/timings/17-07-2007?latitude=51.508515&longitude=-0.1254872&method=2
// Future<Salah> getSalahByDay({
//   required double latitude,
//   required double longitude,
// }) async {
//   final now = DateTime.now();
//   final formattedDate = "${now.day}-${now.month}-${now.year}";
//   final salahRequest = Uri.https(
//       _basePrayerTimes,
//       '/v1/timings/' '$formattedDate',
//       {'latitude': '$latitude', 'longitude': '$longitude'});
//
//   final salahResponse = await _httpClient.get(salahRequest);
//
//   _logger.i(salahResponse.statusCode);
//   if (salahResponse.statusCode != 200) throw SalahRequestFailure();
//
//   final salahJson = jsonDecode(salahResponse.body) as Map<String, dynamic>;
//   _logger.i('This is the decoded json $salahJson');
//
//   if (!salahJson.containsKey('data')) throw SalahNotFoundFailure();
//
//   ///TODO I need to save this list as Salah objects into the DB.
//   final results = salahJson['data'];
//   _logger.i('This is the resulting json: $results');
//
//   if (results.isEmpty) throw SalahNotFoundFailure();
//
//   ///TODO This will only get the first Salah for the date.
//   ///I need to save this entire list to the database in the future
//   // return OriginSalah.fromJson(results.first as Map<String, dynamic>);
//   return Salah.fromJson(results.last as Map<String, dynamic>);
// }
