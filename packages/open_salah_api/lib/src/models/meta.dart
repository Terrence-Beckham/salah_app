import 'package:json_annotation/json_annotation.dart';
import 'package:json_serializable/json_serializable.dart';
part 'meta.g.dart';

@JsonSerializable()
class Meta {
  final double latitude;
  final double longitude;
  final String timezone;
  final String method;
  final String latitudeAdjustmentMethod;
  final String midnightMode;
  final String school;
  final Map<String, int> offset;
  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);
  Meta(
      {required this.latitude,
      required this.longitude,
      required this.timezone,
      required this.method,
      required this.latitudeAdjustmentMethod,
      required this.midnightMode,
      required this.school,
      required this.offset});
}
