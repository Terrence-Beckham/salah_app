import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@JsonSerializable()
class Location extends Equatable {
  const Location({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
  final int id;
  final String name;
  final double latitude;
  final double longitude;

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, latitude, longitude];
}
