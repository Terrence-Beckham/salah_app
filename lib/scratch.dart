import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

final dio = Dio();

Future<void> getHttp() async {
  final response = await dio.get<Uri>(
    'http://api.aladhan.com/v1/calendar/2017/4?latitude=51.508515&longitude=-0.1254872&method=2 http://api.aladhan.com/v1/calendar/2019?latitude=51.508515&longitude=-0.1254872&method=2',
  );
  Logger().i(response);
}
