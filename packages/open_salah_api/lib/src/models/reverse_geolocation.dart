import 'package:equatable/equatable.dart';

class ReverseGeolocation extends Equatable {
  final int placeID;
  final String lat;
  final String lon;
  final String displayName;
  final String city;
  final String state;
  final String country;
  final String countryCode;

  const ReverseGeolocation(
      {required this.placeID,
      required this.lat,
      required this.lon,
      required this.displayName,
      required this.city,
      required this.state,
      required this.country,
      required this.countryCode});

  factory ReverseGeolocation.fromJson(Map<String, dynamic> json) {
    final int placeID = json['place_id'] as int;
    final String lat = json['lat'] as String;
    final String lon = json['lon'] as String;
    final String displayName = json['lon'] as String;
    final String city = json['address']['city'] as String;
    final String state = json['address']['state'] as String;
    final String country = json['address']['country'] as String;
    final String countryCode = json['address']['country_code'] as String;
    return ReverseGeolocation(
        placeID: placeID,
        lat: lat,
        lon: lon,
        displayName: displayName,
        city: city,
        state: state,
        country: country,
        countryCode: countryCode);
  }

  @override
  // TODO: implement props
  List<Object?> get props =>
      [placeID, lat, lon, displayName, city, state, country, countryCode];
}

// "place_id": 43221267,
// "licence": "Data © OpenStreetMap contributors, ODbL 1.0. https://osm.org/copyright",
// "osm_type": "node",
// "osm_id": 6782529329,
// "lat": "30.0117682",
// "lon": "31.1771554",
// "display_name": "2, Al Salamoni Street, Giza, 12623, Egypt",
// "address": {
// "house_number": "2",
// "road": "Al Salamoni Street",
// "city": "Giza",
// "state": "Giza",
// "ISO3166-2-lvl4": "EG-GZ",
// "postcode": "12623",
// "country": "Egypt",
// "country_code": "eg"
// },
