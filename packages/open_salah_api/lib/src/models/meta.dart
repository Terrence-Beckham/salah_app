import 'package:json_annotation/json_annotation.dart';
part 'meta.g.dart';

@JsonSerializable()
class Meta {
  final double latitude;
  final double longitude;
  final String timezone;
  final String method;
  final String adjustment;
  final String midnight;
  final String school;
  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);
  Meta({
    required this.latitude,
    required this.longitude,
    required this.timezone,
    required this.method,
    required this.adjustment,
    required this.midnight,
    required this.school,
  });
}
