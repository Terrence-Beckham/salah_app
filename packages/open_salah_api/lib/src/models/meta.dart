class Meta {
  final double latitude;
  final double longitude;
  final String timeZone;
  final int methodId;
  final String methodName;
  final String school;

  Meta({
    required this.latitude,
    required this.longitude,
    required this.timeZone,
    required this.methodId,
    required this.methodName,
    required this.school,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    final double latitude = json['latitude'] as double;
    final double longitude = json['longitude'] as double;
    final String timeZone = json['timezone'] as String;
    final int methodId = json['method']['id'] as int;
    final String methodName = json['method']['name'] as String;
    final String school = json['school'] as String;
    return Meta(
      latitude: latitude,
      longitude: longitude,
      timeZone: timeZone,
      methodId: methodId,
      methodName: methodName,
      school: school,
    );
  }
}
